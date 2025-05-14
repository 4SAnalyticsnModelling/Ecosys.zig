const std = @import("std");

pub fn parseTokenToFloat(comptime FloatType: type, comptime ErrVal: anyerror, token: []const u8, logFileWriter: std.fs.File.Writer) !FloatType {
    return std.fmt.parseFloat(FloatType, token) catch {
        const err = ErrVal;
        try logFileWriter.print("{s}\n", .{@errorName(err)});
        return err;
    };
}
