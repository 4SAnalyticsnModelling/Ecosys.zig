const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blk18b = struct {
    roqcx: [jx][jy][jz + 1][5]f32, // Fortran: ROQCX(0:4,0:JZ,JY,JX)
    roqcy: [jx][jy][jz + 1][5]f32, // Fortran: ROQCY(0:4,0:JZ,JY,JX)
    roqax: [jx][jy][jz + 1][5]f32, // Fortran: ROQAX(0:4,0:JZ,JY,JX)
    roqay: [jx][jy][jz + 1][5]f32, // Fortran: ROQAY(0:4,0:JZ,JY,JX)
    roxyx: [jx][jy][jz + 1]f32, // Fortran: ROXYX(0:JZ,JY,JX)
    roxyy: [jx][jy][jz + 1]f32, // Fortran: ROXYY(0:JZ,JY,JX)
    rnh4x: [jx][jy][jz + 1]f32, // Fortran: RNH4X(0:JZ,JY,JX)
    rnh4y: [jx][jy][jz + 1]f32, // Fortran: RNH4Y(0:JZ,JY,JX)
    rno3x: [jx][jy][jz + 1]f32, // Fortran: RNO3X(0:JZ,JY,JX)
    rno3y: [jx][jy][jz + 1]f32, // Fortran: RNO3Y(0:JZ,JY,JX)
    rno2x: [jx][jy][jz + 1]f32, // Fortran: RNO2X(0:JZ,JY,JX)
    rno2y: [jx][jy][jz + 1]f32, // Fortran: RNO2Y(0:JZ,JY,JX)
    rpo4x: [jx][jy][jz + 1]f32, // Fortran: RPO4X(0:JZ,JY,JX)
    rpo4y: [jx][jy][jz + 1]f32, // Fortran: RPO4Y(0:JZ,JY,JX)
    rn2ox: [jx][jy][jz + 1]f32, // Fortran: RN2OX(0:JZ,JY,JX)
    rn2oy: [jx][jy][jz + 1]f32, // Fortran: RN2OY(0:JZ,JY,JX)
    rnhbx: [jx][jy][jz + 1]f32, // Fortran: RNHBX(0:JZ,JY,JX)
    rnhby: [jx][jy][jz + 1]f32, // Fortran: RNHBY(0:JZ,JY,JX)
    rn3bx: [jx][jy][jz + 1]f32, // Fortran: RN3BX(0:JZ,JY,JX)
    rn3by: [jx][jy][jz + 1]f32, // Fortran: RN3BY(0:JZ,JY,JX)
    rn2bx: [jx][jy][jz + 1]f32, // Fortran: RN2BX(0:JZ,JY,JX)
    rn2by: [jx][jy][jz + 1]f32, // Fortran: RN2BY(0:JZ,JY,JX)
    rpobx: [jx][jy][jz + 1]f32, // Fortran: RPOBX(0:JZ,JY,JX)
    rpoby: [jx][jy][jz + 1]f32, // Fortran: RPOBY(0:JZ,JY,JX)
    rp14x: [jx][jy][jz + 1]f32, // Fortran: RP14X(0:JZ,JY,JX)
    rp14y: [jx][jy][jz + 1]f32, // Fortran: RP14Y(0:JZ,JY,JX)
    rp1bx: [jx][jy][jz + 1]f32, // Fortran: RP1BX(0:JZ,JY,JX)
    rp1by: [jx][jy][jz + 1]f32, // Fortran: RP1BY(0:JZ,JY,JX)
    tuphgs: [jx][jy][jz]f32, // Fortran: TUPHGS(JZ,JY,JX)
    thgfla: [jx][jy][jz]f32, // Fortran: THGFLA(JZ,JY,JX)
    tlh2gp: [jx][jy][jz]f32, // Fortran: TLH2GP(JZ,JY,JX)
    th2gz: [jx][jy]f32, // Fortran: TH2GZ(JY,JX)
    tcan: [jx][jy]f32, // Fortran: TCAN(JY,JX)
    trn: [jx][jy]f32, // Fortran: TRN(JY,JX)
    tle: [jx][jy]f32, // Fortran: TLE(JY,JX)
    tsh: [jx][jy]f32, // Fortran: TSH(JY,JX)
    tgh: [jx][jy]f32, // Fortran: TGH(JY,JX)
    tgpp: [jx][jy]f32, // Fortran: TGPP(JY,JX)
    trau: [jx][jy]f32, // Fortran: TRAU(JY,JX)
    tnpp: [jx][jy]f32, // Fortran: TNPP(JY,JX)
    thre: [jx][jy]f32, // Fortran: THRE(JY,JX)
    xhvstc: [jx][jy]f32, // Fortran: XHVSTC(JY,JX)
    xhvstn: [jx][jy]f32, // Fortran: XHVSTN(JY,JX)
    xhvstp: [jx][jy]f32, // Fortran: XHVSTP(JY,JX)
    iflgt: [jx][jy]i32, // Fortran: IFLGT(JY,JX)
    trinh4: [jx][jy]f32, // Fortran: TRINH4(JY,JX)
    tripo4: [jx][jy]f32, // Fortran: TRIPO4(JY,JX)

    pub fn init() Blk18b {
        return std.mem.zeroInit(Blk18b, .{});
    }
};
