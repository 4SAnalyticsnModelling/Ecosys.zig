const std = @import("std");
const offset = 1;
const tokenizeLine = @import("../ecosysUtils/tokenizeLine.zig").tokenizeLine;
const parseTokenToInt = @import("../ecosysUtils/parseTokenToInt.zig").parseTokenToInt;

/// This struct defines number of model scenarios and passes within each scenarios.
pub const Scenarios = struct {
    nax: u32,
    ndx: u32,
};

/// This function parse model scenarios and passes.
pub fn parseScenarios(allocator: std.mem.Allocator, logFileWriter: *std.Io.Writer, logRun: *std.Io.Writer, ecosysRun: *std.Io.Reader) !Scenarios {
    const line = try ecosysRun.takeDelimiterExclusive('\n');
    var tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 2) {
        const err = error.InvalidNumberOfModelScenariosInRunScript;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        try logFileWriter.flush();
        return err;
    }
    const nax = try parseTokenToInt(u32, error.InvalidNumberOfModelScenariosInRunScript, tokens.items[0], logFileWriter);
    const ndx = try parseTokenToInt(u32, error.InvalidNumberOfModelScenariosInRunScript, tokens.items[1], logFileWriter);
    try logRun.print("=> Number of model scenarios {}, each repeated for {} passes.\n", .{ nax, ndx });
    try logRun.flush();
    tokens.deinit(allocator);

    return Scenarios{ .nax = nax, .ndx = ndx };
}
