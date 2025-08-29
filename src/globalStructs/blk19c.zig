const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blk19c = struct {
    zmgoh: [jx][jy][jz]f32, // Fortran: ZMGOH(JZ,JY,JX)
    zmgch: [jx][jy][jz]f32, // Fortran: ZMGCH(JZ,JY,JX)
    zmghh: [jx][jy][jz]f32, // Fortran: ZMGHH(JZ,JY,JX)
    zmgsh: [jx][jy][jz]f32, // Fortran: ZMGSH(JZ,JY,JX)
    znach: [jx][jy][jz]f32, // Fortran: ZNACH(JZ,JY,JX)
    znash: [jx][jy][jz]f32, // Fortran: ZNASH(JZ,JY,JX)
    zkash: [jx][jy][jz]f32, // Fortran: ZKASH(JZ,JY,JX)
    h0po4h: [jx][jy][jz]f32, // Fortran: H0PO4H(JZ,JY,JX)
    h3po4h: [jx][jy][jz]f32, // Fortran: H3PO4H(JZ,JY,JX)
    zfe1ph: [jx][jy][jz]f32, // Fortran: ZFE1PH(JZ,JY,JX)
    zfe2ph: [jx][jy][jz]f32, // Fortran: ZFE2PH(JZ,JY,JX)
    zca0ph: [jx][jy][jz]f32, // Fortran: ZCA0PH(JZ,JY,JX)
    zca1ph: [jx][jy][jz]f32, // Fortran: ZCA1PH(JZ,JY,JX)
    zca2ph: [jx][jy][jz]f32, // Fortran: ZCA2PH(JZ,JY,JX)
    zmg1ph: [jx][jy][jz]f32, // Fortran: ZMG1PH(JZ,JY,JX)
    h0pobh: [jx][jy][jz]f32, // Fortran: H0POBH(JZ,JY,JX)
    h3pobh: [jx][jy][jz]f32, // Fortran: H3POBH(JZ,JY,JX)
    zfe1bh: [jx][jy][jz]f32, // Fortran: ZFE1BH(JZ,JY,JX)
    zfe2bh: [jx][jy][jz]f32, // Fortran: ZFE2BH(JZ,JY,JX)
    zca0bh: [jx][jy][jz]f32, // Fortran: ZCA0BH(JZ,JY,JX)
    zca1bh: [jx][jy][jz]f32, // Fortran: ZCA1BH(JZ,JY,JX)
    zca2bh: [jx][jy][jz]f32, // Fortran: ZCA2BH(JZ,JY,JX)
    zmg1bh: [jx][jy][jz]f32, // Fortran: ZMG1BH(JZ,JY,JX)

    pub fn init() Blk19c {
        return std.mem.zeroInit(Blk19c, .{});
    }
};
