const std = @import("std");
const offset: u32 = 1;
const Blkc = @import("../globalStructs/blkc.zig").Blkc;
const Blkmain = @import("../localStructs/blkmain.zig").Blkmain;
const Files = @import("../globalStructs/files.zig").Files;
const tokenizeLine = @import("../ecosysUtils/tokenizeLine.zig").tokenizeLine;
const parseTokenToInt = @import("../ecosysUtils/parseTokenToInt.zig").parseTokenToInt;
const parseTokenToFloat = @import("../ecosysUtils/parseTokenToFloat.zig").parseTokenToFloat;
const toLowerCase = @import("../ecosysUtils/toLowerCase.zig").toLowerCase;
/// This function reads weather options
// pub fn readOptionFile(allocator: std.mem.Allocator, logFileWriter: *std.Io.Writer, optionFileName: []const u8, blkc: *Blkc, blkmain: *Blkmain, files: *Files, nhw: u32, nvn: u32, nhe: u32, nvs: u32) !void {
pub fn readOptionFile(allocator: std.mem.Allocator, logFileWriter: *std.Io.Writer, logOption: *std.Io.Writer, optionFileName: []const u8, blkmain: *Blkmain, files: *Files) !void {
    // Log error message if this function fails
    errdefer {
        const err = error.FunctionFailed_readOptionFile;
        logFileWriter.print("error: {s}\n", .{@errorName(err)}) catch {};
        logFileWriter.flush() catch {};
        std.debug.print("error: {s}\n", .{@errorName(err)});
    }
    // Buffer for file I/O: read
    var inBuf: [1024]u8 = undefined;
    // Open site file
    const fs = std.fs.cwd();
    const optionF = fs.openFile(optionFileName, .{}) catch {
        const err = error.OptionFileNotFoundOrFailedToOpenOptionFile;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        try logFileWriter.flush();
        return err;
    };
    defer optionF.close();
    var optionFileBuf = optionF.reader(&inBuf);
    const optionFile = &optionFileBuf.interface;
    // Read option file line by line
    // Read scenario start date in DDMMYYY format
    var line = try optionFile.takeDelimiterExclusive('\n');
    var tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 1) {
        const err = error.InvalidInputForScenarioStartDateInOptionFile;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        try logFileWriter.flush();
        return err;
    }
    files.idata[0] = try parseTokenToInt(u32, error.InvalidScenarioStartDate_DD_InOptionFile, tokens.items[0][0..2], logFileWriter);
    files.idata[1] = try parseTokenToInt(u32, error.InvalidScenarioStartDate_MM_InOptionFile, tokens.items[0][2..4], logFileWriter);
    files.idata[2] = try parseTokenToInt(u32, error.InvalidScenarioStartDate_YYYY_InOptionFile, tokens.items[0][4..8], logFileWriter);
    try logOption.print("=> [Start of {s} file.] {s} line#1 inputs: scenario start date (day/month/year) {d}/{d}/{d}\n", .{ optionFileName, optionFileName, files.idata[0], files.idata[1], files.idata[2] });
    try logOption.flush();
    tokens.deinit(allocator);
    // Read scenario end date in DDMMYYY format
    line = try optionFile.takeDelimiterExclusive('\n');
    tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 1) {
        const err = error.InvalidInputForScenarioEndDateInOptionFile;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        try logFileWriter.flush();
        return err;
    }
    files.idata[3] = try parseTokenToInt(u32, error.InvalidScenarioEndDate_DD_InOptionFile, tokens.items[0][0..2], logFileWriter);
    files.idata[4] = try parseTokenToInt(u32, error.InvalidScenarioEndDate_MM_InOptionFile, tokens.items[0][2..4], logFileWriter);
    files.idata[5] = try parseTokenToInt(u32, error.InvalidScenarioEndDate_YYYY_InOptionFile, tokens.items[0][4..8], logFileWriter);
    try logOption.print("=> {s} line#2 inputs: scenario end date (day/month/year) {d}/{d}/{d}\n", .{ optionFileName, files.idata[3], files.idata[4], files.idata[5] });
    try logOption.flush();
    tokens.deinit(allocator);
    // Read model run start date in DDMMYYY format
    line = try optionFile.takeDelimiterExclusive('\n');
    tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 1) {
        const err = error.InvalidInputForModelRunStartDateInOptionFile;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        try logFileWriter.flush();
        return err;
    }
    files.idata[6] = try parseTokenToInt(u32, error.InvalidModelRunStartDate_DD_InOptionFile, tokens.items[0][0..2], logFileWriter);
    files.idata[7] = try parseTokenToInt(u32, error.InvalidModelRunStartDate_MM_InOptionFile, tokens.items[0][2..4], logFileWriter);
    files.idata[8] = try parseTokenToInt(u32, error.InvalidModelRunStartDate_YYYY_InOptionFile, tokens.items[0][4..8], logFileWriter);
    try logOption.print("=> {s} line#3 inputs: model run start date (day/month/year) {d}/{d}/{d}\n", .{ optionFileName, files.idata[6], files.idata[7], files.idata[8] });
    try logOption.flush();
    tokens.deinit(allocator);
    // Read flag for generating checkpoint files, resuming from earlier checkpoint files
    line = try optionFile.takeDelimiterExclusive('\n');
    tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 1) {
        const err = error.InvalidInputForCheckPointFileFlagInOptionFile;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        try logFileWriter.flush();
        return err;
    }
    const lowerFlag = try toLowerCase(allocator, tokens.items[0]);
    defer allocator.free(lowerFlag);
    blkmain.data[20] = lowerFlag;
    if (!(std.mem.eql(u8, blkmain.data[20], "yes") or
        std.mem.eql(u8, blkmain.data[20], "no")))
    {
        const err = error.InvalidInputForCheckPointFileFlagInOptionFile;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        try logFileWriter.flush();
        return err;
    }
    try logOption.print("=> {s} line#4 inputs: start from an earlier run?: {s}\n", .{ optionFileName, blkmain.data[20] });
    try logOption.flush();
    tokens.deinit(allocator);
}
