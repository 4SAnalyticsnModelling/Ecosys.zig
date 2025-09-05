const std = @import("std");
const tokenizeLine = @import("../ecosysUtils/tokenizeLine.zig").tokenizeLine;
const offset = 1;

pub fn readOutputOptionFiles(
    allocator: std.mem.Allocator,
    logFileWriter: *std.Io.Writer,
    logRun: *std.Io.Writer,
    ecosysRun: *std.Io.Reader,
    nPass: usize,
    ne: usize,
    nex: usize,
) !void {
    const outputControlFileType: [10][]const u8 = .{ "Hourly carbon output file", "Hourly water output file", "Hourly nitrogen output file", "Hourly phosphorus output file", "Hourly energy/heat output file", "Daily carbon output file", "Daily water output file", "Daily nitrogen output file", "Daily phosphorus output file", "Daily energy/heat output file" };
    var hourlyC: []const u8 = undefined;
    var hourlyH2O: []const u8 = undefined;
    var hourlyN: []const u8 = undefined;
    var hourlyP: []const u8 = undefined;
    var hourlyEngy: []const u8 = undefined;
    var dailyC: []const u8 = undefined;
    var dailyH2O: []const u8 = undefined;
    var dailyN: []const u8 = undefined;
    var dailyP: []const u8 = undefined;
    var dailyEngy: []const u8 = undefined;
    const listOfOutputFiles: [10]*[]const u8 = .{ &hourlyC, &hourlyH2O, &hourlyN, &hourlyP, &hourlyEngy, &dailyC, &dailyH2O, &dailyN, &dailyP, &dailyEngy };
    for (listOfOutputFiles, 0..) |outfilePtr, n| {
        const line = try ecosysRun.takeDelimiterExclusive('\n');
        var tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 1) {
            const err = error.InvalidOutputControlFileInRunScript;
            try logFileWriter.print("error: {s}: Invalid {s}\n", .{ @errorName(err), outputControlFileType[n] });
            try logFileWriter.flush();
            return err;
        }
        outfilePtr.* = try allocator.dupe(u8, tokens.items[0]);
        defer allocator.free(outfilePtr.*);
        if (nPass == 0) {
            try logRun.print("=> {s} (scenario #{} scene #{}): {s}.\n", .{ outputControlFileType[n], nex + offset, ne + offset, outfilePtr.* });
            try logRun.flush();
        }
        tokens.deinit(allocator);
    }
}
