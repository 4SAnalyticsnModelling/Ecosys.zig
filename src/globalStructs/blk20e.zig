const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blk20e = struct {
    xh0pxs: [jx][jy][jz]f32, // Fortran: XH0PXS(JZ,JY,JX)
    xh3pxs: [jx][jy][jz]f32, // Fortran: XH3PXS(JZ,JY,JX)
    xf1pxs: [jx][jy][jz]f32, // Fortran: XF1PXS(JZ,JY,JX)
    xf2pxs: [jx][jy][jz]f32, // Fortran: XF2PXS(JZ,JY,JX)
    xc0pxs: [jx][jy][jz]f32, // Fortran: XC0PXS(JZ,JY,JX)
    xc1pxs: [jx][jy][jz]f32, // Fortran: XC1PXS(JZ,JY,JX)
    xc2pxs: [jx][jy][jz]f32, // Fortran: XC2PXS(JZ,JY,JX)
    xm1pxs: [jx][jy][jz]f32, // Fortran: XM1PXS(JZ,JY,JX)
    xh0bxb: [jx][jy][jz]f32, // Fortran: XH0BXB(JZ,JY,JX)
    xh3bxb: [jx][jy][jz]f32, // Fortran: XH3BXB(JZ,JY,JX)
    xf1bxb: [jx][jy][jz]f32, // Fortran: XF1BXB(JZ,JY,JX)
    xf2bxb: [jx][jy][jz]f32, // Fortran: XF2BXB(JZ,JY,JX)
    xc0bxb: [jx][jy][jz]f32, // Fortran: XC0BXB(JZ,JY,JX)
    xc1bxb: [jx][jy][jz]f32, // Fortran: XC1BXB(JZ,JY,JX)
    xc2bxb: [jx][jy][jz]f32, // Fortran: XC2BXB(JZ,JY,JX)
    xm1bxb: [jx][jy][jz]f32, // Fortran: XM1BXB(JZ,JY,JX)
    xnxfxb: [jx][jy][jz]f32, // Fortran: XNXFXB(JZ,JY,JX)

    pub fn init() Blk20e {
        return std.mem.zeroInit(Blk20e, .{});
    }
};
