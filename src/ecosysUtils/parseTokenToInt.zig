const std = @import("std");

pub fn parseTokenToInt(comptime IntType: type, comptime ErrVal: anyerror, token: []const u8, logFileWriter: std.fs.File.Writer) !IntType {
    return std.fmt.parseInt(IntType, token, 10) catch {
        const err = ErrVal;
        try logFileWriter.print("{s}\n", .{@errorName(err)});
        return err;
    };
}
