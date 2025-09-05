const std = @import("std");
const offset = 1;
const tokenizeLine = @import("../ecosysUtils/tokenizeLine.zig").tokenizeLine;
const parseTokenToInt = @import("../ecosysUtils/parseTokenToInt.zig").parseTokenToInt;

/// This struct defines number of model scenes and passes within each scene under each model scenario.
pub const Scenes = struct {
    nay: u32,
    ndy: u32,
};

/// This function parse model scenes and passes under each model scenario.
pub fn parseScenes(allocator: std.mem.Allocator, logFileWriter: *std.Io.Writer, logRun: *std.Io.Writer, ecosysRun: *std.Io.Reader, nPass: usize) !Scenes {
    const line = try ecosysRun.takeDelimiterExclusive('\n');
    var tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 2) {
        const err = error.InvalidNumberOfScenesInRunScript;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        try logFileWriter.flush();
        return err;
    }
    const nay = try parseTokenToInt(u32, error.InvalidNumberOfScenesInRunScript, tokens.items[0], logFileWriter);
    const ndy = try parseTokenToInt(u32, error.InvalidNumberOfScenesInRunScript, tokens.items[1], logFileWriter);
    if (nPass == 0) {
        try logRun.print("=> Number of model scenes in a scenario: {} each repeated: {} times.\n", .{ nay, ndy });
        try logRun.flush();
    }
    tokens.deinit(allocator);
    return Scenes{ .nay = nay, .ndy = ndy };
}
