const std = @import("std");
const offset: u32 = 1;
const Blk11a = @import("globalStructs/blk11a.zig").Blk11a;
const Blk8a = @import("globalStructs/blk8a.zig").Blk8a;
const Blk8b = @import("globalStructs/blk8b.zig").Blk8b;
const Blk2a = @import("globalStructs/blk2a.zig").Blk2a;
const Blkc = @import("globalStructs/blkc.zig").Blkc;
const Blkmain = @import("localStructs/blkmain.zig").Blkmain;
const Files = @import("globalStructs/files.zig").Files;
const tokenizeLine = @import("ecosysUtils/tokenizeLine.zig").tokenizeLine;
const readSiteFile = @import("readiFuncs/readSiteFile.zig").readSiteFile;
const readTopographyFile = @import("readiFuncs/readTopographyFile.zig").readTopographyFile;
const readOptionFile = @import("readsFuncs/readOptionFile.zig").readOptionFile;
const readOutputOptionFiles = @import("readsFuncs/readOutputOptionFiles.zig").readOutputOptionFiles;
const mkEcosysOutputDirs = @import("ecosysUtils/mkEcosysOutputDirs.zig").mkEcosysOutputDirs;
const parseTokenToInt = @import("ecosysUtils/parseTokenToInt.zig").parseTokenToInt;
const parseTokenToFloat = @import("ecosysUtils/parseTokenToFloat.zig").parseTokenToFloat;
const elapsedTime = @import("ecosysUtils/elapsedTime.zig").elapsedTime;
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
    var blk2a: Blk2a = Blk2a.init();
    var blk8a: Blk8a = Blk8a.init();
    var blk8b: Blk8b = Blk8b.init();
    var blkc: Blkc = Blkc.init();
    var files: Files = Files.init();
    // Read number of E-W and N-S grid cells
    var line = try ecosysRun.takeDelimiterExclusive('\n');
    var tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 4) {
        const err = error.InvalidInputForGridCellNumberInRunScript;
        try logErr.print("error: {s}\n", .{@errorName(err)});
        try logErr.flush();
        return err;
    }
    const nhw = try parseTokenToInt(u32, error.InvalidNumberOfGridCellsInRunScript_W, tokens.items[0], logErr) - offset;
    const nvn = try parseTokenToInt(u32, error.InvalidNumberOfGridCellsInRunScript_N, tokens.items[1], logErr) - offset;
    const nhe = try parseTokenToInt(u32, error.InvalidNumberOfGridCellsInRunScript_E, tokens.items[2], logErr);
    const nvs = try parseTokenToInt(u32, error.InvalidNumberOfGridCellsInRunScript_S, tokens.items[3], logErr);
    try logRun.print("=> Grid cell positions: W: {}; E: {}; N: {}; S: {}.\n", .{ nhw + offset, nhe, nvn + offset, nvs });
    try logRun.flush();
    // Free up memory allocated in tokenized line
    tokens.deinit(allocator);
    // Reset to reuse memory more efficiently in fixed buffered allocator.
    fba.reset();
    // Read site file
    try readSiteFile(allocator, logErr, logRun, ecosysRun, &blk2a, &blkc, nhw, nvn, nhe, nvs);
    fba.reset();
    // Read topography file
    try readTopographyFile(allocator, logErr, logRun, ecosysRun, &blk11a, &blk2a, &blk8a, &blk8b, &blkc, nhw, nvn, nhe, nvs);
    // Read the number of the model scenarios to be executed
    line = try ecosysRun.takeDelimiterExclusive('\n');
    tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 2) {
        const err = error.InvalidNumberOfModelScenariosInRunScript;
        try logErr.print("error: {s}\n", .{@errorName(err)});
        try logErr.flush();
        return err;
    }
    const nax = try parseTokenToInt(u32, error.InvalidNumberOfModelScenariosInRunScript, tokens.items[0], logErr);
    const ndx = try parseTokenToInt(u32, error.InvalidNumberOfModelScenariosInRunScript, tokens.items[1], logErr);
    try logRun.print("=> Number of model scenarios: {} each repeated: {} times.\n", .{ nax, ndx });
    try logRun.flush();
    tokens.deinit(allocator);
    var nPass: usize = 0; // This flag prevents repeated writing out of inputs for repeating cycles of scenarios and scenes.
    // Create a log file to write option file inputs to check if they are all appropriately read
    var logOptionFile = try fs.createFile("outputs/checkPointLogs/optionFileInputCheckLog", .{ .truncate = false });
    defer logOptionFile.close();
    var logOptionFileBuf = logOptionFile.writer(&outBuf);
    const logOption = &logOptionFileBuf.interface;
    // Find cursor position at the start of the scenario
    const startScenario = ecosysRunFileBuf.logicalPos();
    // For each pass in scenarios
    for (0..ndx) |nfx| {
        fba.reset();
        try ecosysRunFileBuf.seekTo(startScenario);
        // For each scenario
        for (0..nax) |nex| {
            if (nfx == 0) {
                nPass = 0;
            } else {
                nPass += nfx;
            }
            // Error message to be written later in the error log file if number of model scenarios is invalid
            errdefer {
                const err = error.InvalidNumberOfModelScenariosInRunScript;
                logErr.print("error: Traceback: {s}\n", .{@errorName(err)}) catch {};
                logErr.flush() catch {};
            }
            line = try ecosysRun.takeDelimiterExclusive('\n');
            tokens = try tokenizeLine(line, allocator);
            if (tokens.items.len != 2) {
                const err = error.InvalidNumberOfScenesInRunScript;
                try logErr.print("error: {s}\n", .{@errorName(err)});
                try logErr.flush();
                return err;
            }
            const nay = try parseTokenToInt(u32, error.InvalidNumberOfScenesInRunScript, tokens.items[0], logErr);
            const ndy = try parseTokenToInt(u32, error.InvalidNumberOfScenesInRunScript, tokens.items[1], logErr);
            if (nPass == 0) {
                try logRun.print("=> Number of model scenes in a scenario: {} each repeated: {} times.\n", .{ nay, ndy });
                try logRun.flush();
            }
            tokens.deinit(allocator);
            // Find cursor position at the start of a scene
            const startScene = ecosysRunFileBuf.logicalPos();
            // For each pass of the scene in a scenario
            for (0..ndy) |nd| {
                try ecosysRunFileBuf.seekTo(startScene);
                // For each scene
                for (0..nay) |ne| {
                    if (nfx == 0 and nd == 0) {
                        nPass = 0;
                    } else {
                        nPass += nd;
                    }
                    // Error message to be written later in the error log file if number of scenes is invalid
                    errdefer {
                        const err = error.InvalidNumberOfScenesInRunScript;
                        logErr.print("error: Traceback: {s}\n", .{@errorName(err)}) catch {};
                        logErr.flush() catch {};
                    }
                    // Read weather file names
                    line = try ecosysRun.takeDelimiterExclusive('\n');
                    tokens = try tokenizeLine(line, allocator);
                    if (tokens.items.len != 1) {
                        const err = error.InvalidWeatherFileInRunScript;
                        try logErr.print("error: {s}\n", .{@errorName(err)});
                        try logErr.flush();
                        return err;
                    }
                    const weatherFileName = try allocatorLite.dupe(u8, tokens.items[0]);
                    defer allocatorLite.free(weatherFileName);
                    if (nPass == 0) {
                        try logRun.print("=> Weather file (scenario #{} scene #{}): {s}.\n", .{ nex + offset, ne + offset, weatherFileName });
                        try logRun.flush();
                    }
                    tokens.deinit(allocator);
                    // Read option file names
                    line = try ecosysRun.takeDelimiterExclusive('\n');
                    tokens = try tokenizeLine(line, allocator);
                    if (tokens.items.len != 1) {
                        const err = error.InvalidOptionsFileInRunScript;
                        try logErr.print("error: {s}\n", .{@errorName(err)});
                        try logErr.flush();
                        return err;
                    }
                    const optionFileName = try allocatorLite.dupe(u8, tokens.items[0]);
                    defer allocatorLite.free(optionFileName);
                    if (nPass == 0) {
                        try logRun.print("=> Options file (scenario #{} pass #{} scene #{} pass #{}): {s}.\n", .{ nex + offset, nfx + offset, ne + offset, nd + offset, optionFileName });
                        try logRun.flush();
                    }
                    tokens.deinit(allocator);
                    // Open and read option file
                    fba.reset();
                    try readOptionFile(allocator, logErr, logOption, optionFileName, nPass, nex, nfx, ne, nd, &blkc, &blkmain, &files);
                    // Open and read weather file
                    //
                    // Read land management file
                    line = try ecosysRun.takeDelimiterExclusive('\n');
                    tokens = try tokenizeLine(line, allocator);
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
            }
        }
    }
    runOK = true;
}
