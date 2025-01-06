const std = @import("std");

pub const Blk20e = struct {
    xh0pxs: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xh3pxs: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xf1pxs: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xf2pxs: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xc0pxs: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xc1pxs: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xc2pxs: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xm1pxs: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xh0bxb: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xh3bxb: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xf1bxb: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xf2bxb: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xc0bxb: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xc1bxb: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xc2bxb: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xm1bxb: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xnxfxb: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),

    pub fn init() Blk20e {
        return .{};
    }
};
