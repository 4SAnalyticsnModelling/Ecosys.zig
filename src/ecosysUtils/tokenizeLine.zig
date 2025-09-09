const std = @import("std");

pub fn tokenizeLine(line: []const u8, allocator: std.mem.Allocator) !std.ArrayList([]const u8) {
    var it = std.mem.tokenizeAny(u8, line, " ,\t\r\n");
    var maxCap: usize = 1;
    for (line) |c| {
        if (c == ' ' or c == ',') maxCap += 1;
    }
    var tokens = try std.ArrayList([]const u8).initCapacity(allocator, maxCap);
    while (it.next()) |token| {
        try tokens.append(allocator, token);
    }
    return tokens;
}
