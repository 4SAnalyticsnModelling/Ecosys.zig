const std = @import("std");

pub const Blk20d = struct {
    xocfxs: comptime [jx][jy][jz][5]f32 = std.mem.zeroes([jx][jy][jz][5]f32),
    xonfxs: comptime [jx][jy][jz][5]f32 = std.mem.zeroes([jx][jy][jz][5]f32),
    xopfxs: comptime [jx][jy][jz][5]f32 = std.mem.zeroes([jx][jy][jz][5]f32),
    xoafxfs: comptime [jx][jy][jz][5]f32 = std.mem.zeroes([jx][jy][jz][5]f32),
    xcofxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xchfxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xoxfxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xhgfxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xngfxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xn2fxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xn4fxw: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xn3fxw: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xnofxw: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xh2pxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xn4fxb: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xn3fxb: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xnofxb: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xh2bxb: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xnxfxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xalfxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xfefxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xhyfxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xcafxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xmgfxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xnafxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xkafxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xohfxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xsofxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xclfxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xc3fxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xhcfxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xal1xs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xal2xs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xal3xs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xal4xs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xalsxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xfe1xs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xfe2xs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xfe3xs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xfe4xs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xfesxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xcaoxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xcacxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xcahxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xcasxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xmgooxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xmgcxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xmghxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xmgsxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xnacxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xnasxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xkasxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xh1pxs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xh1bxb: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),

    pub fn init() Blk20d {
        return .{};
    }
};