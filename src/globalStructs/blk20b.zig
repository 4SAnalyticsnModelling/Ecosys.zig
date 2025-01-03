const std = @import("std");

pub const Blk20b = struct {
    xalfsl: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xfeels: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xhyfsl: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xcafls: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xmgfls: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xnafsl: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xkafls: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xohfls: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xsofls: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xclfls: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xc3fls: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xhcfls: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xal1fs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xal2fs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xal3fs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xal4fs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xalsfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xfe1fs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xfe2fs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xfe3fs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xfe4fs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xfesfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xcaofs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xcacfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xcahfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xcasfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xmgoofs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xmgcfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xmghfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xmgsfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xnacfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xnasfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xkasfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xh0pfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xh3pfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xf1pfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xf2pfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xc0pfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xc1pfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xc2pfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xm1pfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xh0bfb: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xh3bfb: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xf1bfb: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xf2bfb: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xc0bfb: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xc1bfb: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xc2bfb: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xm1bfb: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),

    pub fn init() Blk20b {
        return .{};
    }
};
