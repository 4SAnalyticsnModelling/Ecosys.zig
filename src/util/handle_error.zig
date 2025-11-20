const std = @import("std");

///This function catches and prints errors encountered.
pub fn handleError(comptime err: anyerror, err_log: *std.Io.Writer) !void {
    try err_log.print("error: {s}.\n", .{@errorName(err)});
    try err_log.flush();
    std.debug.print("error: {s}.\n", .{@errorName(err)});
}
