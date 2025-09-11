const std = @import("std");
const offset: u32 = 1;
const Blk11a = @import("globalStructs/blk11a.zig").Blk11a;
const Blk17 = @import("globalStructs/blk17.zig").Blk17;
const Blk8a = @import("globalStructs/blk8a.zig").Blk8a;
const Blk8b = @import("globalStructs/blk8b.zig").Blk8b;
const Blk2a = @import("globalStructs/blk2a.zig").Blk2a;
const Blk2b = @import("globalStructs/blk2b.zig").Blk2b;
const Blkc = @import("globalStructs/blkc.zig").Blkc;
const Blkmain = @import("localStructs/blkmain.zig").Blkmain;
const Files = @import("globalStructs/files.zig").Files;
const tokenizeLine = @import("ecosysUtils/tokenizeLine.zig").tokenizeLine;
const mkEcosysOutputDirs = @import("ecosysUtils/mkEcosysOutputDirs.zig").mkEcosysOutputDirs;
const parseTokenToInt = @import("ecosysUtils/parseTokenToInt.zig").parseTokenToInt;
const parseTokenToFloat = @import("ecosysUtils/parseTokenToFloat.zig").parseTokenToFloat;
const elapsedTime = @import("ecosysUtils/elapsedTime.zig").elapsedTime;
const parseGridCells = @import("readiFuncs/parseGridCells.zig").parseGridCells;
const readSiteFile = @import("readiFuncs/readSiteFile.zig").readSiteFile;
const readTopographyFile = @import("readiFuncs/readTopographyFile.zig").readTopographyFile;
const parseScenarios = @import("readsFuncs/parseScenarios.zig").parseScenarios;
const parseScenes = @import("readsFuncs/parseScenes.zig").parseScenes;
const readOptionFile = @import("readsFuncs/readOptionFile.zig").readOptionFile;
const readOutputOptionFiles = @import("readsFuncs/readOutputOptionFiles.zig").readOutputOptionFiles;
const readWeatherFile = @import("readsFuncs/readWeatherFile.zig").readWeatherFile;
/// Ecosys main function
pub fn main() !void {
    const startTimeUs: i64 = std.time.microTimestamp();
    // Buffer for allocators
    var buffer: [1024]u8 = undefined;
    var bufferLite: [1024]u8 = undefined;
    // Buffer for file I/O: read
    var inBuf: [1024]u8 = undefined;
    // Buffer for file I/O: write
    var outBuf: [1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();
    var fbaLite = std.heap.FixedBufferAllocator.init(&bufferLite);
    const allocatorLite = fbaLite.allocator();
    // Read and check ecosys run submission arguments
    const args = try std.process.argsAlloc(allocatorLite);
    defer std.process.argsFree(allocatorLite, args);
    if (args.len < 2) {
        std.debug.print(
            "error -> Missing Arguments. Ecosys job submission format should be: {s} <runFile>\n",
            .{args[0]},
        );
        return error.MissingArgumentsWhileSubmittingEcosysRun;
    }
    // Read ecosys runfile/runscript name from run submission arguments
    const runFile = try allocatorLite.dupe(u8, args[1]);
    defer allocatorLite.free(runFile);
    const fs = std.fs.cwd();
    // Create directory tree for saving the outputs
    try mkEcosysOutputDirs();
    // Create the error log file
    const logError = try fs.createFile("outputs/errorLogs/errorLogFile", .{ .truncate = false });
    defer logError.close();
    var logErrBuf = logError.writer(&outBuf);
    var logErr = &logErrBuf.interface;
    var runOK: bool = false;
    // Successful compeletion confirmation to be printed at the end of the model run if runOK is true
    defer {
        if (runOK) {
            const endTimeUs: i64 = std.time.microTimestamp();
            const timeElapsedWithUnit = elapsedTime(startTimeUs, endTimeUs);
            const timeElapsed: f64 = timeElapsedWithUnit.value;
            const timeElapsedUnit: []const u8 = timeElapsedWithUnit.unit;
            logErr.print("success: Ecosys model run in {s} successfully completed in {d} {s}!\n", .{ runFile, timeElapsed, timeElapsedUnit }) catch {};
            logErr.flush() catch {};
            std.debug.print("success: Ecosys model run in {s} successfully completed in {d} {s}!\n", .{ runFile, timeElapsed, timeElapsedUnit });
        }
    }
    // Run failure notice to be printed if runOK is false due to any error
    errdefer {
        const endTimeUs: i64 = std.time.microTimestamp();
        const timeElapsedWithUnit = elapsedTime(startTimeUs, endTimeUs);
        const timeElapsed: f64 = timeElapsedWithUnit.value;
        const timeElapsedUnit: []const u8 = timeElapsedWithUnit.unit;
        logErr.print("error: Ecosys model run in {s} stopped unexpectedly in {d} {s} due to some error(s)! Please fix the error(s) and try again.\n", .{ runFile, timeElapsed, timeElapsedUnit }) catch {};
        logErr.flush() catch {};
        std.debug.print("error: Ecosys model run in {s} stopped unexpectedly in {d} {s} due to some error(s)! Please fix the error(s) and try again.\n", .{ runFile, timeElapsed, timeElapsedUnit });
    }
    const ecosysRunFile = fs.openFile(runFile, .{}) catch {
        const err = error.RunFileNotFoundOrFailedToOpenRunFile;
        try logErr.print("error: {s}\n", .{@errorName(err)});
        try logErr.flush();
        return err;
    };
    defer ecosysRunFile.close();
    var ecosysRunFileBuf = ecosysRunFile.reader(&inBuf);
    const ecosysRun = &ecosysRunFileBuf.interface;
    // Create the runscript input check log file
    var logRunfile = try fs.createFile("outputs/checkPointLogs/runscriptInputCheckLog", .{ .truncate = false });
    defer logRunfile.close();
    var logRunfileBuf = logRunfile.writer(&outBuf);
    const logRun = &logRunfileBuf.interface;
    var blkmain: Blkmain = Blkmain.init();
    var blk11a: Blk11a = Blk11a.init();
    var blk17: Blk17 = Blk17.init();
    var blk2a: Blk2a = Blk2a.init();
    var blk2b: Blk2b = Blk2b.init();
    var blk8a: Blk8a = Blk8a.init();
    var blk8b: Blk8b = Blk8b.init();
    var blkc: Blkc = Blkc.init();
    var files: Files = Files.init();
    // Reset to reuse memory more efficiently in fixed buffered allocator.
    fba.reset();
    // Read number of E-W and N-S grid cells
    const gridCells = try parseGridCells(allocator, logErr, logRun, ecosysRun);
    const nhw = gridCells.nhw;
    const nvn = gridCells.nvn;
    const nhe = gridCells.nhe;
    const nvs = gridCells.nvs;
    fba.reset();
    // Read site file
    try readSiteFile(allocator, logErr, logRun, ecosysRun, &blk2a, &blkc, nhw, nvn, nhe, nvs);
    fba.reset();
    // Read topography file
    try readTopographyFile(allocator, logErr, logRun, ecosysRun, &blk11a, &blk2a, &blk8a, &blk8b, &blkc, nhw, nvn, nhe, nvs);
    // Read the number of the model scenarios to be executed
    const ecosysScenarios = try parseScenarios(allocator, logErr, logRun, ecosysRun);
    const nax = ecosysScenarios.nax;
    const ndx = ecosysScenarios.ndx;
    var nScenario: u32 = 0;
    var nPass: usize = 0; // This flag prevents repeated writing out of inputs for repeating cycles of scenarios and scenes.
    // Create a log file to write option file inputs to check if they are all appropriately read
    var logOptionFile = try fs.createFile("outputs/checkPointLogs/optionFileInputCheckLog", .{ .truncate = false });
    defer logOptionFile.close();
    var logOptionFileBuf = logOptionFile.writer(&outBuf);
    const logOption = &logOptionFileBuf.interface;
    // Create a log file to write weather file inputs to check if they are all appropriately read
    var logWeatherFile = try fs.createFile("outputs/checkPointLogs/weatherFileInputCheckLog", .{ .truncate = false });
    defer logWeatherFile.close();
    var logWeatherFileBuf = logWeatherFile.writer(&outBuf);
    const logWeather = &logWeatherFileBuf.interface;
    // Find cursor position at the start of the scenario
    const startScenario = ecosysRunFileBuf.logicalPos();
    // For each pass in scenarios
    for (0..ndx) |ntx| {
        try ecosysRunFileBuf.seekTo(startScenario);
        // For each scenario
        for (0..nax) |nex| {
            if (ntx == 0) {
                nPass = 0;
            } else {
                nPass += ntx;
            }
            // Error message to be written later in the error log file if number of model scenarios is invalid
            errdefer {
                const err = error.InvalidNumberOfModelScenariosInRunScript;
                logErr.print("error: Traceback: {s}\n", .{@errorName(err)}) catch {};
                logErr.flush() catch {};
            }
            // Read number of scenes in each scenario
            const ecosysScenes = try parseScenes(allocator, logErr, logRun, ecosysRun, nPass);
            const nay = ecosysScenes.nay;
            const ndy = ecosysScenes.ndy;
            // Find cursor position at the start of a scene
            const startScene = ecosysRunFileBuf.logicalPos();
            // For each pass of the scene in a scenario
            for (0..ndy) |nt| {
                try ecosysRunFileBuf.seekTo(startScene);
                // For each scene
                for (0..nay) |ne| {
                    if (ntx == 0 and nt == 0) {
                        nPass = 0;
                    } else {
                        nPass += nt;
                    }
                    // Error message to be written later in the error log file if number of scenes is invalid
                    errdefer {
                        const err = error.InvalidNumberOfScenesInRunScript;
                        logErr.print("error: Traceback: {s}\n", .{@errorName(err)}) catch {};
                        logErr.flush() catch {};
                    }
                    // Read option file
                    fba.reset();
                    try readOptionFile(allocator, logErr, logOption, logRun, ecosysRun, nPass, nex, ntx, ne, nt, nay, nScenario, &blk17, &blkc, &blkmain, &files);
                    // Read weather file
                    fba.reset();
                    try readWeatherFile(allocator, logErr, logWeather, logRun, ecosysRun, &blk2a, &blk2b, &blkc, nhw, nvn, nhe, nvs, nPass, nex, ne);
                    // Read land management file
                    var line = try ecosysRun.takeDelimiterExclusive('\n');
                    var tokens = try tokenizeLine(line, allocator);
                    if (tokens.items.len != 1) {
                        const err = error.InvalidLandManagementFileInRunScript;
                        try logErr.print("error: {s}\n", .{@errorName(err)});
                        try logErr.flush();
                        return err;
                    }
                    const landMgmtFileName = try allocatorLite.dupe(u8, tokens.items[0]);
                    defer allocatorLite.free(landMgmtFileName);
                    if (nPass == 0) {
                        try logRun.print("=> Land management file (scenario #{} scene #{}): {s}.\n", .{ nex + offset, ne + offset, landMgmtFileName });
                        try logRun.flush();
                    }
                    tokens.deinit(allocator);
                    // Read plant management file
                    line = try ecosysRun.takeDelimiterExclusive('\n');
                    tokens = try tokenizeLine(line, allocator);
                    if (tokens.items.len != 1) {
                        const err = error.InvalidPlantManagementFileInRunScript;
                        try logErr.print("error: {s}\n", .{@errorName(err)});
                        try logErr.flush();
                        return err;
                    }
                    const plantMgmtFileName = try allocatorLite.dupe(u8, tokens.items[0]);
                    defer allocatorLite.free(plantMgmtFileName);
                    if (nPass == 0) {
                        try logRun.print("=> Plant management file (scenario #{} scene #{}): {s}.\n", .{ nex + offset, ne + offset, plantMgmtFileName });
                        try logRun.flush();
                    }
                    tokens.deinit(allocator);
                    // Read output control files
                    fba.reset();
                    try readOutputOptionFiles(allocator, logErr, logRun, ecosysRun, nPass, ne, nex);
                }
                nScenario += 1;
            }
        }
    }
    runOK = true;
}
