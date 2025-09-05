const std = @import("std");
const offset = 1;
const tokenizeLine = @import("../ecosysUtils/tokenizeLine.zig").tokenizeLine;
const parseTokenToInt = @import("../ecosysUtils/parseTokenToInt.zig").parseTokenToInt;

/// This struct defines model grid cells in W, E, N, and S directions.
pub const GridCells = struct {
    nhw: u32,
    nvn: u32,
    nhe: u32,
    nvs: u32,
};

/// This function parse model grid cells.
pub fn parseGridCells(allocator: std.mem.Allocator, logFileWriter: *std.Io.Writer, logRun: *std.Io.Writer, ecosysRun: *std.Io.Reader) !GridCells {
    const line = try ecosysRun.takeDelimiterExclusive('\n');
    var tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 4) {
        const err = error.InvalidInputForGridCellNumberInRunScript;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        try logFileWriter.flush();
        return err;
    }

    const nhw = try parseTokenToInt(u32, error.InvalidNumberOfGridCellsInRunScript_W, tokens.items[0], logFileWriter) - offset;
    const nvn = try parseTokenToInt(u32, error.InvalidNumberOfGridCellsInRunScript_N, tokens.items[1], logFileWriter) - offset;
    const nhe = try parseTokenToInt(u32, error.InvalidNumberOfGridCellsInRunScript_E, tokens.items[2], logFileWriter);
    const nvs = try parseTokenToInt(u32, error.InvalidNumberOfGridCellsInRunScript_S, tokens.items[3], logFileWriter);

    try logRun.print("=> Grid cell positions: W: {}; E: {}; N: {}; S: {}.\n", .{ nhw + offset, nhe, nvn + offset, nvs });
    try logRun.flush();
    tokens.deinit(allocator);

    return GridCells{ .nhw = nhw, .nvn = nvn, .nhe = nhe, .nvs = nvs };
}
