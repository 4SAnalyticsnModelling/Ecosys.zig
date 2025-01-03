const std = @import("std");

pub const Blk1u = struct {
    tkcz: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    raz: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    rsmn: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),

    pub fn init() Blk1u {
        return .{};
    }
};
