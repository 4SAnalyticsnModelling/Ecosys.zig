const std = @import("std");
const Blk2a = @import("globalStructs/blk2a.zig").Blk2a;
const Blkc = @import("globalStructs/blkc.zig").Blkc;
const Blkmain = @import("localStructs/blkmain.zig").Blkmain;
const getRunAndLogFileArgs = @import("mainFuncs/getRunAndLogFileArgs.zig").getRunAndLogFileArgs;
const tokenizeLine = @import("ecosysUtils/tokenizeLine.zig").tokenizeLine;
const readLine = @import("ecosysUtils/readLine.zig").readLine;
const readSiteFile = @import("readiFuncs/readSiteFile.zig").readSiteFile;
const mkDir = @import("ecosysUtils/mkDir.zig").mkDir;
const parseTokenToInt = @import("ecosysUtils/parseTokenToInt.zig").parseTokenToInt;
const parseTokenToFloat = @import("ecosysUtils/parseTokenToFloat.zig").parseTokenToFloat;
const elapsedTime = @import("ecosysUtils/elapsedTime.zig").elapsedTime;
/// Ecosys main function
pub fn main() anyerror!void {
    const startTime_us: i64 = std.time.microTimestamp();
    var buffer: [10 * 1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();
    const runFile: []const u8 = try getRunAndLogFileArgs(allocator);
    // Create directory tree for saving the outputs
    const fs = std.fs.cwd();
    // Create or overwrite the parent directory for all outputs
    try mkDir("outputs");
    // Create or overwrite the directory to save all error log files
    try mkDir("outputs/errorLogs");
    // Create or overwrite the directory to save all run progress tracker files
    try mkDir("outputs/runStatusLogs");
    // Create or overwrite the directory to save all model inputs and other check files
    try mkDir("outputs/checkPointLogs");
    // Create or overwrite the directory to save all modelled outputs for hourly and daily plant, soil, and ecosystem carbon, water, heat, nitrogen and phosphorus cycles
    try mkDir("outputs/modelledOutputs");
    // Create the error log file
    var logError = try fs.createFile("outputs/errorLogs/errorLogFile", .{ .read = false });
    defer logError.close();
    const logErr = logError.writer();
    var runOK: bool = false;
    // Successful compeletion confirmation to be printed at the end of the model run if runOK is true
    defer {
        if (runOK) {
            const endTime_us: i64 = std.time.microTimestamp();
            const timeElapsedWithUnit = elapsedTime(startTime_us, endTime_us);
            const timeElapsed: f64 = timeElapsedWithUnit.value;
            const timeElapsedUnit: []const u8 = timeElapsedWithUnit.unit;
            logErr.print("success: Ecosys model run in {s} successfully completed in {d} {s}!\n", .{ runFile, timeElapsed, timeElapsedUnit }) catch {};
            std.debug.print("error: Ecosys model run in {s} successfully completed in {d} {s}!\n", .{ runFile, timeElapsed, timeElapsedUnit });
        }
    }
    // Run failure notice to be printed if runOK is false due to any error
    errdefer {
        const endTime_us: i64 = std.time.microTimestamp();
        const timeElapsedWithUnit = elapsedTime(startTime_us, endTime_us);
        const timeElapsed: f64 = timeElapsedWithUnit.value;
        const timeElapsedUnit: []const u8 = timeElapsedWithUnit.unit;
        logErr.print("error: Ecosys model run in {s} stopped unexpectedly in {d} {s} due to some error(s)! Please fix the error(s) and try again.\n", .{ runFile, timeElapsed, timeElapsedUnit }) catch {};
        std.debug.print("error: Ecosys model run in {s} stopped unexpectedly in {d} {s} due to some error(s)! Please fix the error(s) and try again.\n", .{ runFile, timeElapsed, timeElapsedUnit });
    }
    const file = fs.openFile(runFile, .{}) catch {
        const err = error.RunFileNotFoundOrFailedToOpenRunFile;
        try logErr.print("error: {s}\n", .{@errorName(err)});
        return err;
    };
    defer file.close();
    // Create the runscript input check log file
    var logRunfile = try fs.createFile("outputs/checkPointLogs/runscriptInputCheckLog", .{ .read = false });
    defer logRunfile.close();
    const logRun = logRunfile.writer();
    var blkmain: Blkmain = Blkmain.init();
    var blk2a: Blk2a = Blk2a.init();
    var blkc: Blkc = Blkc.init();
    const outputControlFileType: [10][]const u8 = .{ "Hourly carbon output file", "Hourly water output file", "Hourly nitrogen output file", "Hourly phosphorus output file", "Hourly energy/heat output file", "Daily carbon output file", "Daily water output file", "Daily nitrogen output file", "Daily phosphorus output file", "Daily energy/heat output file" };
    // Read number of E-W and N-S grid cells
    var line = try readLine(file, allocator);
    var tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 4) {
        const err = error.InvalidInputForGridCellNumberInRunScript;
        try logErr.print("error: {s}\n", .{@errorName(err)});
        return err;
    }
    const nhw = try parseTokenToInt(u32, error.InvalidNumberOfGridCellsInRunScript_W, tokens.items[0], logErr) - 1;
    const nvn = try parseTokenToInt(u32, error.InvalidNumberOfGridCellsInRunScript_N, tokens.items[1], logErr) - 1;
    const nhe = try parseTokenToInt(u32, error.InvalidNumberOfGridCellsInRunScript_E, tokens.items[2], logErr);
    const nvs = try parseTokenToInt(u32, error.InvalidNumberOfGridCellsInRunScript_S, tokens.items[3], logErr);
    try logRun.print("=> Grid cell positions: W: {}; E: {}; N: {}; S: {}.\n", .{ nhw, nhe, nvn, nvs });
    tokens.deinit();
    allocator.free(line);
    // Read site file
    line = try readLine(file, allocator);
    tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 1) {
        const err = error.InvalidSiteFileInRunScript;
        try logErr.print("error: {s}\n", .{@errorName(err)});
        return err;
    }
    const siteFileName: []const u8 = tokens.items[0];
    try logRun.print("=> Site file: {s}.\n", .{siteFileName});
    try readSiteFile(allocator, logErr, siteFileName, &blk2a, &blkc, nhw, nvn, nhe, nvs);
    tokens.deinit();
    allocator.free(line);
    // Read topography file
    line = try readLine(file, allocator);
    tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 1) {
        const err = error.InvalidTopographyFileInRunScript;
        try logErr.print("error: {s}\n", .{@errorName(err)});
        return err;
    }
    blkmain.data[1] = tokens.items[0];
    try logRun.print("=> Topography file: {s}.\n", .{blkmain.data[1]});
    tokens.deinit();
    allocator.free(line);
    // Read the number of the model scenarios to be executed
    line = try readLine(file, allocator);
    tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 2) {
        const err = error.InvalidNumberOfModelScenariosInRunScript;
        try logErr.print("error: {s}\n", .{@errorName(err)});
        return err;
    }
    const nax = try parseTokenToInt(u32, error.InvalidNumberOfModelScenariosInRunScript, tokens.items[0], logErr);
    const ndx = try parseTokenToInt(u32, error.InvalidNumberOfModelScenariosInRunScript, tokens.items[1], logErr);
    try logRun.print("=> Number of model scenarios: {}; Times to be repeated: {}.\n", .{ nax, ndx });
    tokens.deinit();
    allocator.free(line);
    // For each scenario
    for (0..nax) |nex| {
        // Error message to be written later in the error log file if number of model scenarios is invalid
        errdefer {
            const err = error.InvalidNumberOfModelScenariosInRunScript;
            logErr.print("error: Traceback: {s}\n", .{@errorName(err)}) catch {};
        }
        line = try readLine(file, allocator);
        tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 2) {
            const err = error.InvalidNumberOfScenesInRunScript;
            try logErr.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        const nay = try parseTokenToInt(u32, error.InvalidNumberOfScenesInRunScript, tokens.items[0], logErr);
        const ndy = try parseTokenToInt(u32, error.InvalidNumberOfScenesInRunScript, tokens.items[1], logErr);
        try logRun.print("=> Number of model scenes in a scenario: {}; Times to be repeated: {}.\n", .{ nay, ndy });
        tokens.deinit();
        allocator.free(line);
        blkmain.na[nex] = nay;
        blkmain.nd[nex] = ndy;
        // For each model scene in a scenario
        for (0..blkmain.na[nex]) |ne| {
            // Error message to be written later in the error log file if number of scenes is invalid
            errdefer {
                const err = error.InvalidNumberOfScenesInRunScript;
                logErr.print("error: Traceback: {s}\n", .{@errorName(err)}) catch {};
            }
            // Read weather file
            line = try readLine(file, allocator);
            tokens = try tokenizeLine(line, allocator);
            if (tokens.items.len != 1) {
                const err = error.InvalidWeatherNetworkInRunScript;
                try logErr.print("error: {s}\n", .{@errorName(err)});
                return err;
            }
            blkmain.datac[nex][ne][2] = tokens.items[0];
            try logRun.print("=> Weather network file (scenario #{} scene #{}): {s}.\n", .{ nex, ne, blkmain.datac[nex][ne][2] });
            tokens.deinit();
            allocator.free(line);
            // Read options file
            line = try readLine(file, allocator);
            tokens = try tokenizeLine(line, allocator);
            if (tokens.items.len != 1) {
                const err = error.InvalidOptionsFileInRunScript;
                try logErr.print("error: {s}\n", .{@errorName(err)});
                return err;
            }
            blkmain.datac[nex][ne][3] = tokens.items[0];
            try logRun.print("=> Options file (scenario #{} scene #{}): {s}.\n", .{ nex, ne, blkmain.datac[nex][ne][3] });
            tokens.deinit();
            allocator.free(line);
            // Read land management file
            line = try readLine(file, allocator);
            tokens = try tokenizeLine(line, allocator);
            if (tokens.items.len != 1) {
                const err = error.InvalidLandManagementFileInRunScript;
                try logErr.print("error: {s}\n", .{@errorName(err)});
                return err;
            }
            blkmain.datac[nex][ne][8] = tokens.items[0];
            try logRun.print("=> Land management file (scenario #{} scene #{}): {s}.\n", .{ nex, ne, blkmain.datac[nex][ne][8] });
            tokens.deinit();
            allocator.free(line);
            // Read plant management file
            line = try readLine(file, allocator);
            tokens = try tokenizeLine(line, allocator);
            if (tokens.items.len != 1) {
                const err = error.InvalidPlantManagementFileInRunScript;
                try logErr.print("error: {s}\n", .{@errorName(err)});
                return err;
            }
            blkmain.datac[nex][ne][9] = tokens.items[0];
            try logRun.print("=> Plant management file (scenario #{} scene #{}): {s}.\n", .{ nex, ne, blkmain.datac[nex][ne][9] });
            tokens.deinit();
            allocator.free(line);
            // Read output control files
            for (20..30) |n| {
                line = try readLine(file, allocator);
                tokens = try tokenizeLine(line, allocator);
                if (tokens.items.len != 1) {
                    const err = error.InvalidOutputControlFileInRunScript;
                    try logErr.print("error: {s}: Invalid {s}\n", .{ @errorName(err), outputControlFileType[n - 20] });
                    return err;
                }
                blkmain.datac[nex][ne][n] = tokens.items[0];
                try logRun.print("=> {s} (scenario #{} scene #{}): {s}.\n", .{ outputControlFileType[n - 20], nex, ne, blkmain.datac[nex][ne][n] });
                tokens.deinit();
                allocator.free(line);
            }
        }
    }
    runOK = true;
}
