const std = @import("std");

///This function checks validity of number of tokens in a line.
pub fn checkTokenInLine(comptime err: anyerror, token_num: usize, token_thresh: u32, err_log: *std.Io.Writer) !void {
    const token_num_u32: u32 = @intCast(token_num);
    if (token_num_u32 != token_thresh) {
        try err_log.print("error: {s}\n", .{@errorName(err)});
        try err_log.flush();
        return err;
    }
}
