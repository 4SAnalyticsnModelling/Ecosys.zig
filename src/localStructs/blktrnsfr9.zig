const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blktrnsfr9 = struct {
    rocfxs: [jx][jy][jz][5]f32, // Fortran: ROCFXS(0:4,JZ,JY,JX)
    ronfxs: [jx][jy][jz][5]f32, // Fortran: RONFXS(0:4,JZ,JY,JX)
    ropfxs: [jx][jy][jz][5]f32, // Fortran: ROPFXS(0:4,JZ,JY,JX)
    roafxs: [jx][jy][jz][5]f32, // Fortran: ROAFXS(0:4,JZ,JY,JX)
    rcofxs: [jx][jy][jz]f32, // Fortran: RCOFXS(JZ,JY,JX)
    rchfxs: [jx][jy][jz]f32, // Fortran: RCHFXS(JZ,JY,JX)
    roxfxs: [jx][jy][jz]f32, // Fortran: ROXFXS(JZ,JY,JX)
    rngfxs: [jx][jy][jz]f32, // Fortran: RNGFXS(JZ,JY,JX)
    rn2fxs: [jx][jy][jz]f32, // Fortran: RN2FXS(JZ,JY,JX)
    rn4fxw: [jx][jy][jz]f32, // Fortran: RN4FXW(JZ,JY,JX)
    rn3fxw: [jx][jy][jz]f32, // Fortran: RN3FXW(JZ,JY,JX)
    rnofxw: [jx][jy][jz]f32, // Fortran: RNOFXW(JZ,JY,JX)
    rh2pxs: [jx][jy][jz]f32, // Fortran: RH2PXS(JZ,JY,JX)
    rn4fxb: [jx][jy][jz]f32, // Fortran: RN4FXB(JZ,JY,JX)
    rn3fxb: [jx][jy][jz]f32, // Fortran: RN3FXB(JZ,JY,JX)
    rnofxb: [jx][jy][jz]f32, // Fortran: RNOFXB(JZ,JY,JX)
    rh2bxb: [jx][jy][jz]f32, // Fortran: RH2BXB(JZ,JY,JX)
    rnxfxs: [jx][jy][jz]f32, // Fortran: RNXFXS(JZ,JY,JX)
    rnxfxb: [jx][jy][jz]f32, // Fortran: RNXFXB(JZ,JY,JX)
    rh1pxs: [jx][jy][jz]f32, // Fortran: RH1PXS(JZ,JY,JX)
    rh1bxb: [jx][jy][jz]f32, // Fortran: RH1BXB(JZ,JY,JX)

    pub fn init() Blktrnsfr9 {
        return std.mem.zeroInit(Blktrnsfr9, .{});
    }
};
