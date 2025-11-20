const std = @import("std");
const offset: u32 = 1;
const Grid = @import("../dtypes/domain/grids.zig").Grid;
const parseTokenToInt = @import("../util/parse_tokens.zig").parseTokenToInt;
const checkTokenInLine = @import("../util/check_token_in_line.zig").checkTokenInLine;
///This function returns grid positions in W, N, E, and S directions.
pub fn parseGrids(comptime err: anyerror, tokens: std.ArrayList([]const u8), grid: *Grid, parse_grid_num: bool, token_thresh: u32, err_log: *std.Io.Writer, input_check_log: *std.Io.Writer) !void {
    // Check if the number of inputs in the line is appropriate.
    try checkTokenInLine(err, tokens.items.len, token_thresh, err_log);
    if (parse_grid_num) {
        // Read grid cell numbers in W, N, E, and S direction for model simulation, if parse_grid_num is true.
        grid.num.west = try parseTokenToInt(u32, err, tokens.items[0], err_log) - offset;
        grid.num.north = try parseTokenToInt(u32, err, tokens.items[1], err_log) - offset;
        grid.num.east = try parseTokenToInt(u32, err, tokens.items[2], err_log);
        grid.num.south = try parseTokenToInt(u32, err, tokens.items[3], err_log);
        try input_check_log.print("=> Number of grids for simulation: W: {}, N: {}, E: {}, S: {}.\n", .{ grid.num.west + offset, grid.num.north + offset, grid.num.east, grid.num.south });
        try input_check_log.flush();
    } else {
        // Read grid cell positions in W, N, E, and S direction
        grid.pos.west = try parseTokenToInt(u32, err, tokens.items[0], err_log) - offset;
        grid.pos.north = try parseTokenToInt(u32, err, tokens.items[1], err_log) - offset;
        grid.pos.east = try parseTokenToInt(u32, err, tokens.items[2], err_log);
        grid.pos.south = try parseTokenToInt(u32, err, tokens.items[3], err_log);
        try input_check_log.print("=> Grid cell positions: W: {}, N: {}, E: {}, S: {}.\n", .{ grid.pos.west + offset, grid.pos.north + offset, grid.pos.east, grid.pos.south });
        try input_check_log.flush();
        // Check if grid positions are outside the bounds of grid numbers.
        if (grid.pos.west > grid.pos.east or grid.pos.north > grid.pos.south or grid.pos.west < grid.num.west or grid.pos.east > grid.num.west or grid.pos.north < grid.num.north or grid.pos.south > grid.num.south) {
            try err_log.print("error: {s}\n", .{@errorName(err)});
            try err_log.flush();
            return err;
        }
    }
}
