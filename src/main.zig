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
const timeStampUTC = @import("ecosysUtils/timeStampUTC.zig").timeStampUTC;

pub fn main() anyerror!void {
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
    const ts: u64 = @intCast(std.time.milliTimestamp());
    const dt = timeStampUTC(ts);
    var runOK: bool = false;
    // Successful compeletion confirmation to be printed at the end of the model run if runOK is true
    defer {
        if (runOK) {
            logErr.print("success: Ecosys model run in {s} completed successfully at UTC {:0>4}-{:0>2}-{:0>2} {:0>2}:{:0>2}:{:0>2}! Please check the outputs in the 'outputs' folder.\n", .{ runFile, dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second }) catch {};
        }
    }
    // Run failure notice to be printed if runOK is false due to any error
    errdefer {
        logErr.print("error: Ecosys model run in {s} stopped unwantedly at UTC {:0>4}-{:0>2}-{:0>2} {:0>2}:{:0>2}:{:0>2} due to some error(s)! Please fix the error(s) and try again.\n", .{ runFile, dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second }) catch {};
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
    var nhe: u32 = 0;
    var nhw: u32 = 0;
    var nvn: u32 = 0;
    var nvs: u32 = 0;
    var nax: u32 = 0;
    var ndx: u32 = 0;
    var nay: u32 = 0;
    var ndy: u32 = 0;
    // Read number of E-W and N-S grid cells
    var line = try readLine(file, allocator);
    var tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 4) {
        const err = error.InvalidInputForGridCellNumber;
        try logErr.print("error: {s}\n", .{@errorName(err)});
        return err;
    }
    nhw = try parseTokenToInt(u32, error.InvalidNumberOfGridCells, tokens.items[0], logErr);
    nvn = try parseTokenToInt(u32, error.InvalidNumberOfGridCells, tokens.items[1], logErr);
    nhe = try parseTokenToInt(u32, error.InvalidNumberOfGridCells, tokens.items[2], logErr);
    nvs = try parseTokenToInt(u32, error.InvalidNumberOfGridCells, tokens.items[3], logErr);
    nhw = nhw - 1;
    nvn = nvn - 1;
    try logRun.print("Grid cell positions -> West: {}; East: {}; North: {}; South: {}\n", .{ nhw, nhe, nvn, nvs });
    tokens.deinit();
    allocator.free(line);
    // Read site cluster file
    line = try readLine(file, allocator);
    tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 1) {
        const err = error.InvalidSiteClusterFile;
        try logErr.print("error: {s}\n", .{@errorName(err)});
        return err;
    }
    // Read site files within the site cluster
    const siteClusterName: []const u8 = tokens.items[0];
    try logRun.print("Site cluster file: {s}\n", .{siteClusterName});
    try readSiteFile(allocator, logErr, siteClusterName, &blk2a, &blkc);
    tokens.deinit();
    allocator.free(line);
    // Read topography file
    line = try readLine(file, allocator);
    tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 1) {
        const err = error.InvalidTopographyFile;
        try logErr.print("error: {s}\n", .{@errorName(err)});
        return err;
    }
    blkmain.data[1] = tokens.items[0];
    try logRun.print("Topography file: {s}\n", .{blkmain.data[1]});
    tokens.deinit();
    allocator.free(line);
    // Read the number of the model scenarios to be executed
    line = try readLine(file, allocator);
    tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 2) {
        const err = error.InvalidNumberOfModelScenarios;
        try logErr.print("error: {s}\n", .{@errorName(err)});
        return err;
    }
    nax = try parseTokenToInt(u32, error.InvalidNumberOfModelScenarios, tokens.items[0], logErr);
    ndx = try parseTokenToInt(u32, error.InvalidNumberOfModelScenarios, tokens.items[1], logErr);
    try logRun.print("Number of model scenarios: {}; Times to be repeated: {}\n", .{ nax, ndx });
    tokens.deinit();
    allocator.free(line);
    // For each scenario
    for (0..nax) |nex| {
        // Error message to be written later in the error log file if number of model scenarios is invalid
        errdefer {
            const err = error.InvalidNumberOfModelScenarios;
            logErr.print("error: Traceback: {s}\n", .{@errorName(err)}) catch {};
        }
        line = try readLine(file, allocator);
        tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 2) {
            const err = error.InvalidNumberOfScenes;
            try logErr.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        nay = try parseTokenToInt(u32, error.InvalidNumberOfScenes, tokens.items[0], logErr);
        ndy = try parseTokenToInt(u32, error.InvalidNumberOfScenes, tokens.items[1], logErr);
        try logRun.print("Number of model scenes in a scenario: {}; Times to be repeated: {}\n", .{ nay, ndy });
        tokens.deinit();
        allocator.free(line);
        blkmain.na[nex] = nay;
        blkmain.nd[nex] = ndy;
        // For each model scene in a scenario
        for (0..blkmain.na[nex]) |ne| {
            // Error message to be written later in the error log file if number of scenes is invalid
            errdefer {
                const err = error.InvalidNumberOfScenes;
                logErr.print("error: Traceback: {s}\n", .{@errorName(err)}) catch {};
            }
            // Read weather file
            line = try readLine(file, allocator);
            tokens = try tokenizeLine(line, allocator);
            if (tokens.items.len != 1) {
                const err = error.InvalidWeatherNetwork;
                try logErr.print("error: {s}\n", .{@errorName(err)});
                return err;
            }
            blkmain.datac[nex][ne][2] = tokens.items[0];
            try logRun.print("Weather network file (scenario #{} scene #{}): {s}\n", .{ nex, ne, blkmain.datac[nex][ne][2] });
            tokens.deinit();
            allocator.free(line);
            // Read options file
            line = try readLine(file, allocator);
            tokens = try tokenizeLine(line, allocator);
            if (tokens.items.len != 1) {
                const err = error.InvalidOptionsFile;
                try logErr.print("error: {s}\n", .{@errorName(err)});
                return err;
            }
            blkmain.datac[nex][ne][3] = tokens.items[0];
            try logRun.print("Options file (scenario #{} scene #{}): {s}\n", .{ nex, ne, blkmain.datac[nex][ne][3] });
            tokens.deinit();
            allocator.free(line);
            // Read land management file
            line = try readLine(file, allocator);
            tokens = try tokenizeLine(line, allocator);
            if (tokens.items.len != 1) {
                const err = error.InvalidLandManagementFile;
                try logErr.print("error: {s}\n", .{@errorName(err)});
                return err;
            }
            blkmain.datac[nex][ne][8] = tokens.items[0];
            try logRun.print("Land management file (scenario #{} scene #{}): {s}\n", .{ nex, ne, blkmain.datac[nex][ne][8] });
            tokens.deinit();
            allocator.free(line);
            // Read plant management file
            line = try readLine(file, allocator);
            tokens = try tokenizeLine(line, allocator);
            if (tokens.items.len != 1) {
                const err = error.InvalidPlantManagementFile;
                try logErr.print("error: {s}\n", .{@errorName(err)});
                return err;
            }
            blkmain.datac[nex][ne][9] = tokens.items[0];
            try logRun.print("Plant management file (scenario #{} scene #{}): {s}\n", .{ nex, ne, blkmain.datac[nex][ne][9] });
            tokens.deinit();
            allocator.free(line);
            // Read output control files
            for (20..30) |n| {
                const outputControlFileType: []const u8 = switch (n) {
                    20 => "Hourly carbon output file",
                    21 => "Hourly water output file",
                    22 => "Hourly nitrogen output file",
                    23 => "Hourly phosphorus output file",
                    24 => "Hourly energy/heat output file",
                    25 => "Daily carbon output file",
                    26 => "Daily water output file",
                    27 => "Daily nitrogen output file",
                    28 => "Daily phosphorus output file",
                    29 => "Daily energy/heat output file",
                    else => "warning: extra file",
                };
                line = try readLine(file, allocator);
                tokens = try tokenizeLine(line, allocator);
                if (tokens.items.len != 1) {
                    const err = error.InvalidOutputControlFile;
                    try logErr.print("error: {s}: Invalid {s}\n", .{ @errorName(err), outputControlFileType });
                    return err;
                }
                blkmain.datac[nex][ne][n] = tokens.items[0];
                try logRun.print("{s} (scenario #{} scene #{}): {s}\n", .{ outputControlFileType, nex, ne, blkmain.datac[nex][ne][n] });
                tokens.deinit();
                allocator.free(line);
            }
        }
    }
    runOK = true;
}
