const std = @import("std");

/// Returns a new lowercase copy of `input`.
pub fn toLowerCase(allocator: std.mem.Allocator, input: []const u8) ![]u8 {
    var out = try allocator.alloc(u8, input.len);
    for (input, 0..) |c, i| {
        out[i] = std.ascii.toLower(c);
    }
    return out;
}
