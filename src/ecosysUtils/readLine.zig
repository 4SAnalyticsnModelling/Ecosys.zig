const std = @import("std");

pub fn readLine(file: std.fs.File, allocator: std.mem.Allocator) anyerror![]u8 {
    const reader = file.reader();
    const line = try reader.readUntilDelimiterOrEofAlloc(allocator, '\n', std.math.maxInt(usize)) orelse return error.UnexpectedEof;
    return line;
}
