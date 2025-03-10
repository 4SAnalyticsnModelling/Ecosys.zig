const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blk20d = struct {
    xocfxs: [jx][jy][jz][5]f32, // Fortran: XOCFXS(0:4,JZ,JY,JX)
    xonfxs: [jx][jy][jz][5]f32, // Fortran: XONFXS(0:4,JZ,JY,JX)
    xopfxs: [jx][jy][jz][5]f32, // Fortran: XOPFXS(0:4,JZ,JY,JX)
    xoafxs: [jx][jy][jz][5]f32, // Fortran: XOAFXS(0:4,JZ,JY,JX)
    xcofxs: [jx][jy][jz]f32, // Fortran: XCOFXS(JZ,JY,JX)
    xchfxs: [jx][jy][jz]f32, // Fortran: XCHFXS(JZ,JY,JX)
    xoxfxs: [jx][jy][jz]f32, // Fortran: XOXFXS(JZ,JY,JX)
    xhgfxs: [jx][jy][jz]f32, // Fortran: XHGFXS(JZ,JY,JX)
    xngfxs: [jx][jy][jz]f32, // Fortran: XNGFXS(JZ,JY,JX)
    xn2fxs: [jx][jy][jz]f32, // Fortran: XN2FXS(JZ,JY,JX)
    xn4fxw: [jx][jy][jz]f32, // Fortran: XN4FXW(JZ,JY,JX)
    xn3fxw: [jx][jy][jz]f32, // Fortran: XN3FXW(JZ,JY,JX)
    xnofxw: [jx][jy][jz]f32, // Fortran: XNOFXW(JZ,JY,JX)
    xh2pxs: [jx][jy][jz]f32, // Fortran: XH2PXS(JZ,JY,JX)
    xn4fxb: [jx][jy][jz]f32, // Fortran: XN4FXB(JZ,JY,JX)
    xn3fxb: [jx][jy][jz]f32, // Fortran: XN3FXB(JZ,JY,JX)
    xnofxb: [jx][jy][jz]f32, // Fortran: XNOFXB(JZ,JY,JX)
    xh2bxb: [jx][jy][jz]f32, // Fortran: XH2BXB(JZ,JY,JX)
    xnxfxs: [jx][jy][jz]f32, // Fortran: XNXFXS(JZ,JY,JX)
    xalfxs: [jx][jy][jz]f32, // Fortran: XALFXS(JZ,JY,JX)
    xfefxs: [jx][jy][jz]f32, // Fortran: XFEFXS(JZ,JY,JX)
    xhyfxs: [jx][jy][jz]f32, // Fortran: XHYFXS(JZ,JY,JX)
    xcafxs: [jx][jy][jz]f32, // Fortran: XCAFXS(JZ,JY,JX)
    xmgfxs: [jx][jy][jz]f32, // Fortran: XMGFXS(JZ,JY,JX)
    xnafxs: [jx][jy][jz]f32, // Fortran: XNAFXS(JZ,JY,JX)
    xkafxs: [jx][jy][jz]f32, // Fortran: XKAFXS(JZ,JY,JX)
    xohfxs: [jx][jy][jz]f32, // Fortran: XOHFXS(JZ,JY,JX)
    xsofxs: [jx][jy][jz]f32, // Fortran: XSOFXS(JZ,JY,JX)
    xclfxs: [jx][jy][jz]f32, // Fortran: XCLFXS(JZ,JY,JX)
    xc3fxs: [jx][jy][jz]f32, // Fortran: XC3FXS(JZ,JY,JX)
    xhcfxs: [jx][jy][jz]f32, // Fortran: XHCFXS(JZ,JY,JX)
    xal1xs: [jx][jy][jz]f32, // Fortran: XAL1XS(JZ,JY,JX)
    xal2xs: [jx][jy][jz]f32, // Fortran: XAL2XS(JZ,JY,JX)
    xal3xs: [jx][jy][jz]f32, // Fortran: XAL3XS(JZ,JY,JX)
    xal4xs: [jx][jy][jz]f32, // Fortran: XAL4XS(JZ,JY,JX)
    xalsxs: [jx][jy][jz]f32, // Fortran: XALSXS(JZ,JY,JX)
    xfe1xs: [jx][jy][jz]f32, // Fortran: XFE1XS(JZ,JY,JX)
    xfe2xs: [jx][jy][jz]f32, // Fortran: XFE2XS(JZ,JY,JX)
    xfe3xs: [jx][jy][jz]f32, // Fortran: XFE3XS(JZ,JY,JX)
    xfe4xs: [jx][jy][jz]f32, // Fortran: XFE4XS(JZ,JY,JX)
    xfesxs: [jx][jy][jz]f32, // Fortran: XFESXS(JZ,JY,JX)
    xcaoxs: [jx][jy][jz]f32, // Fortran: XCAOXS(JZ,JY,JX)
    xcacxs: [jx][jy][jz]f32, // Fortran: XCACXS(JZ,JY,JX)
    xcahxs: [jx][jy][jz]f32, // Fortran: XCAHXS(JZ,JY,JX)
    xcasxs: [jx][jy][jz]f32, // Fortran: XCASXS(JZ,JY,JX)
    xmgoxs: [jx][jy][jz]f32, // Fortran: XMGOXS(JZ,JY,JX)
    xmgcxs: [jx][jy][jz]f32, // Fortran: XMGCXS(JZ,JY,JX)
    xmghxs: [jx][jy][jz]f32, // Fortran: XMGHXS(JZ,JY,JX)
    xmgsxs: [jx][jy][jz]f32, // Fortran: XMGSXS(JZ,JY,JX)
    xnacxs: [jx][jy][jz]f32, // Fortran: XNACXS(JZ,JY,JX)
    xnasxs: [jx][jy][jz]f32, // Fortran: XNASXS(JZ,JY,JX)
    xkasxs: [jx][jy][jz]f32, // Fortran: XKASXS(JZ,JY,JX)
    xh1pxs: [jx][jy][jz]f32, // Fortran: XH1PXS(JZ,JY,JX)
    xh1bxb: [jx][jy][jz]f32, // Fortran: XH1BXB(JZ,JY,JX)

    pub fn init() Blk20d {
        return std.mem.zeroInit(Blk20d, .{});
    }
};
