const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jh = jx + 1;
const jv = jy + 1;
const jd = jz + 1;

pub const Blk20b = struct {
    xalfsl: [jh][jv][jd + 1][3]f32,
    xfeels: [jh][jv][jd + 1][3]f32,
    xhyfsl: [jh][jv][jd + 1][3]f32,
    xcafls: [jh][jv][jd + 1][3]f32,
    xmgfls: [jh][jv][jd + 1][3]f32,
    xnafsl: [jh][jv][jd + 1][3]f32,
    xkafls: [jh][jv][jd + 1][3]f32,
    xohfls: [jh][jv][jd + 1][3]f32,
    xsofls: [jh][jv][jd + 1][3]f32,
    xclfls: [jh][jv][jd + 1][3]f32,
    xc3fls: [jh][jv][jd + 1][3]f32,
    xhcfls: [jh][jv][jd + 1][3]f32,
    xal1fs: [jh][jv][jd + 1][3]f32,
    xal2fs: [jh][jv][jd + 1][3]f32,
    xal3fs: [jh][jv][jd + 1][3]f32,
    xal4fs: [jh][jv][jd + 1][3]f32,
    xalsfs: [jh][jv][jd + 1][3]f32,
    xfe1fs: [jh][jv][jd + 1][3]f32,
    xfe2fs: [jh][jv][jd + 1][3]f32,
    xfe3fs: [jh][jv][jd + 1][3]f32,
    xfe4fs: [jh][jv][jd + 1][3]f32,
    xfesfs: [jh][jv][jd + 1][3]f32,
    xcaofs: [jh][jv][jd + 1][3]f32,
    xcacfs: [jh][jv][jd + 1][3]f32,
    xcahfs: [jh][jv][jd + 1][3]f32,
    xcasfs: [jh][jv][jd + 1][3]f32,
    xmgoofs: [jh][jv][jd + 1][3]f32,
    xmgcfs: [jh][jv][jd + 1][3]f32,
    xmghfs: [jh][jv][jd + 1][3]f32,
    xmgsfs: [jh][jv][jd + 1][3]f32,
    xnacfs: [jh][jv][jd + 1][3]f32,
    xnasfs: [jh][jv][jd + 1][3]f32,
    xkasfs: [jh][jv][jd + 1][3]f32,
    xh0pfs: [jh][jv][jd + 1][3]f32,
    xh3pfs: [jh][jv][jd + 1][3]f32,
    xf1pfs: [jh][jv][jd + 1][3]f32,
    xf2pfs: [jh][jv][jd + 1][3]f32,
    xc0pfs: [jh][jv][jd + 1][3]f32,
    xc1pfs: [jh][jv][jd + 1][3]f32,
    xc2pfs: [jh][jv][jd + 1][3]f32,
    xm1pfs: [jh][jv][jd + 1][3]f32,
    xh0bfb: [jh][jv][jd + 1][3]f32,
    xh3bfb: [jh][jv][jd + 1][3]f32,
    xf1bfb: [jh][jv][jd + 1][3]f32,
    xf2bfb: [jh][jv][jd + 1][3]f32,
    xc0bfb: [jh][jv][jd + 1][3]f32,
    xc1bfb: [jh][jv][jd + 1][3]f32,
    xc2bfb: [jh][jv][jd + 1][3]f32,
    xm1bfb: [jh][jv][jd + 1][3]f32,

    pub fn init() Blk20b {
        return std.mem.zeroInit(Blk20b, .{});
    }
};
