const std = @import("std");

pub fn parseTokenToInt(comptime IntType: type, comptime ErrVal: anyerror, token: []const u8, logFileWriter: *std.Io.Writer) !IntType {
    return std.fmt.parseInt(IntType, token, 10) catch {
        const err = ErrVal;
        try logFileWriter.print("{s}\n", .{@errorName(err)});
        try logFileWriter.flush();
        return err;
    };
}
