const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jh = jx + 1;
const jv = jy + 1;
const jd = jz + 1;

pub const Blk20b = struct {
    xalfls: [jh][jv][jd + 1][3]f32, // Fortran: XALFLS(3,0:JD,JV,JH)
    xfefls: [jh][jv][jd + 1][3]f32, // Fortran: XFEFLS(3,0:JD,JV,JH)
    xhyfls: [jh][jv][jd + 1][3]f32, // Fortran: XHYFLS(3,0:JD,JV,JH)
    xcafls: [jh][jv][jd + 1][3]f32, // Fortran: XCAFLS(3,0:JD,JV,JH)
    xmgfls: [jh][jv][jd + 1][3]f32, // Fortran: XMGFLS(3,0:JD,JV,JH)
    xnafls: [jh][jv][jd + 1][3]f32, // Fortran: XNAFLS(3,0:JD,JV,JH)
    xkafls: [jh][jv][jd + 1][3]f32, // Fortran: XKAFLS(3,0:JD,JV,JH)
    xohfls: [jh][jv][jd + 1][3]f32, // Fortran: XOHFLS(3,0:JD,JV,JH)
    xsofls: [jh][jv][jd + 1][3]f32, // Fortran: XSOFLS(3,0:JD,JV,JH)
    xclfls: [jh][jv][jd + 1][3]f32, // Fortran: XCLFLS(3,0:JD,JV,JH)
    xc3fls: [jh][jv][jd + 1][3]f32, // Fortran: XC3FLS(3,0:JD,JV,JH)
    xhcfls: [jh][jv][jd + 1][3]f32, // Fortran: XHCFLS(3,0:JD,JV,JH)
    xal1fs: [jh][jv][jd + 1][3]f32, // Fortran: XAL1FS(3,0:JD,JV,JH)
    xal2fs: [jh][jv][jd + 1][3]f32, // Fortran: XAL2FS(3,0:JD,JV,JH)
    xal3fs: [jh][jv][jd + 1][3]f32, // Fortran: XAL3FS(3,0:JD,JV,JH)
    xal4fs: [jh][jv][jd + 1][3]f32, // Fortran: XAL4FS(3,0:JD,JV,JH)
    xalsfs: [jh][jv][jd + 1][3]f32, // Fortran: XALSFS(3,0:JD,JV,JH)
    xfe1fs: [jh][jv][jd + 1][3]f32, // Fortran: XFE1FS(3,0:JD,JV,JH)
    xfe2fs: [jh][jv][jd + 1][3]f32, // Fortran: XFE2FS(3,0:JD,JV,JH)
    xfe3fs: [jh][jv][jd + 1][3]f32, // Fortran: XFE3FS(3,0:JD,JV,JH)
    xfe4fs: [jh][jv][jd + 1][3]f32, // Fortran: XFE4FS(3,0:JD,JV,JH)
    xfesfs: [jh][jv][jd + 1][3]f32, // Fortran: XFESFS(3,0:JD,JV,JH)
    xcaofs: [jh][jv][jd + 1][3]f32, // Fortran: XCAOFS(3,0:JD,JV,JH)
    xcacfs: [jh][jv][jd + 1][3]f32, // Fortran: XCACFS(3,0:JD,JV,JH)
    xcahfs: [jh][jv][jd + 1][3]f32, // Fortran: XCAHFS(3,0:JD,JV,JH)
    xcasfs: [jh][jv][jd + 1][3]f32, // Fortran: XCASFS(3,0:JD,JV,JH)
    xmgofs: [jh][jv][jd + 1][3]f32, // Fortran: XMGOFS(3,0:JD,JV,JH)
    xmgcfs: [jh][jv][jd + 1][3]f32, // Fortran: XMGCFS(3,0:JD,JV,JH)
    xmghfs: [jh][jv][jd + 1][3]f32, // Fortran: XMGHFS(3,0:JD,JV,JH)
    xmgsfs: [jh][jv][jd + 1][3]f32, // Fortran: XMGSFS(3,0:JD,JV,JH)
    xnacfs: [jh][jv][jd + 1][3]f32, // Fortran: XNACFS(3,0:JD,JV,JH)
    xnasfs: [jh][jv][jd + 1][3]f32, // Fortran: XNASFS(3,0:JD,JV,JH)
    xkasfs: [jh][jv][jd + 1][3]f32, // Fortran: XKASFS(3,0:JD,JV,JH)
    xh0pfs: [jh][jv][jd + 1][3]f32, // Fortran: XH0PFS(3,0:JD,JV,JH)
    xh3pfs: [jh][jv][jd + 1][3]f32, // Fortran: XH3PFS(3,0:JD,JV,JH)
    xf1pfs: [jh][jv][jd + 1][3]f32, // Fortran: XF1PFS(3,0:JD,JV,JH)
    xf2pfs: [jh][jv][jd + 1][3]f32, // Fortran: XF2PFS(3,0:JD,JV,JH)
    xc0pfs: [jh][jv][jd + 1][3]f32, // Fortran: XC0PFS(3,0:JD,JV,JH)
    xc1pfs: [jh][jv][jd + 1][3]f32, // Fortran: XC1PFS(3,0:JD,JV,JH)
    xc2pfs: [jh][jv][jd + 1][3]f32, // Fortran: XC2PFS(3,0:JD,JV,JH)
    xm1pfs: [jh][jv][jd + 1][3]f32, // Fortran: XM1PFS(3,0:JD,JV,JH)
    xh0bfb: [jh][jv][jd + 1][3]f32, // Fortran: XH0BFB(3,0:JD,JV,JH)
    xh3bfb: [jh][jv][jd + 1][3]f32, // Fortran: XH3BFB(3,0:JD,JV,JH)
    xf1bfb: [jh][jv][jd + 1][3]f32, // Fortran: XF1BFB(3,0:JD,JV,JH)
    xf2bfb: [jh][jv][jd + 1][3]f32, // Fortran: XF2BFB(3,0:JD,JV,JH)
    xc0bfb: [jh][jv][jd + 1][3]f32, // Fortran: XC0BFB(3,0:JD,JV,JH)
    xc1bfb: [jh][jv][jd + 1][3]f32, // Fortran: XC1BFB(3,0:JD,JV,JH)
    xc2bfb: [jh][jv][jd + 1][3]f32, // Fortran: XC2BFB(3,0:JD,JV,JH)
    xm1bfb: [jh][jv][jd + 1][3]f32, // Fortran: XM1BFB(3,0:JD,JV,JH)

    pub fn init() Blk20b {
        return std.mem.zeroInit(Blk20b, .{});
    }
};
