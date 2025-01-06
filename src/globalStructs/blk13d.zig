const std = @import("std");

pub const Blk13d = struct {
    coqc: [jx][jy][jz + 1][5]f32 = std.mem.zeroes([jx][jy][jz + 1][5]f32),
    coqa: [jx][jy][jz + 1][5]f32 = std.mem.zeroes([jx][jy][jz + 1][5]f32),
    fosrh: [jx][jy][jz + 1][5]f32 = std.mem.zeroes([jx][jy][jz + 1][5]f32),

    pub fn init() Blk13d {
        return .{};
    }
};
