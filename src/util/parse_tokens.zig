const std = @import("std");
///This function parses tokens to integers.
pub fn parseTokenToInt(comptime IntType: type, comptime err_desc: anyerror, token: []const u8, log_file_writer: *std.Io.Writer) !IntType {
    return std.fmt.parseInt(IntType, token, 10) catch {
        const err = err_desc;
        try log_file_writer.print("{s}.\n", .{@errorName(err)});
        try log_file_writer.flush();
        return err;
    };
}
///This function parses tokens to floating point numbers.
pub fn parseTokenToFloat(comptime FloatType: type, comptime err_val: anyerror, token: []const u8, log_file_writer: *std.Io.Writer) !FloatType {
    return std.fmt.parseFloat(FloatType, token) catch {
        const err = err_val;
        try log_file_writer.print("{s}.\n", .{@errorName(err)});
        try log_file_writer.flush();
        return err;
    };
}
