const std = @import("std");

pub const Blk20e = struct {
    xh0pxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xh3pxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xf1pxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xf2pxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xc0pxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xc1pxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xc2pxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xm1pxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xh0bxb: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xh3bxb: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xf1bxb: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xf2bxb: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xc0bxb: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xc1bxb: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xc2bxb: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xm1bxb: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xnxfxb: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),

    pub fn init() Blk20e {
        return .{};
    }
};
