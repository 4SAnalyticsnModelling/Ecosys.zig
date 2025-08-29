const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jh = jx + 1;
const jv = jy + 1;
const jd = jz + 1;

pub const Blktrnsfr12 = struct {
    flqm: [jh][jv][jd][3]f32, // Fortran: FLQM(3,JD,JV,JH)
    rhgfhs: [jh][jv][jd][3]f32, // Fortran: RHGFHS(3,JD,JV,JH)
    rhgflg: [jh][jv][jd][3]f32, // Fortran: RHGFLG(3,JD,JV,JH)
    dco2g: [jx][jy][jz][3]f32, // Fortran: DCO2G(3,JZ,JY,JX)
    dch4g: [jx][jy][jz][3]f32, // Fortran: DCH4G(3,JZ,JY,JX)
    doxyg: [jx][jy][jz][3]f32, // Fortran: DOXYG(3,JZ,JY,JX)
    dz2gg: [jx][jy][jz][3]f32, // Fortran: DZ2GG(3,JZ,JY,JX)
    dz2og: [jx][jy][jz][3]f32, // Fortran: DZ2OG(3,JZ,JY,JX)
    dnh3g: [jx][jy][jz][3]f32, // Fortran: DNH3G(3,JZ,JY,JX)
    dh2gg: [jx][jy][jz][3]f32, // Fortran: DH2GG(3,JZ,JY,JX)
    h2gs2: [jx][jy][jz + 1]f32, // Fortran: H2GS2(0:JZ,JY,JX)
    volwco: [jx][jy][jz + 1]f32, // Fortran: VOLWCO(0:JZ,JY,JX)
    volwch: [jx][jy][jz + 1]f32, // Fortran: VOLWCH(0:JZ,JY,JX)
    volwox: [jx][jy][jz + 1]f32, // Fortran: VOLWOX(0:JZ,JY,JX)
    volwng: [jx][jy][jz + 1]f32, // Fortran: VOLWNG(0:JZ,JY,JX)
    volwn2: [jx][jy][jz + 1]f32, // Fortran: VOLWN2(0:JZ,JY,JX)
    volwn3: [jx][jy][jz + 1]f32, // Fortran: VOLWN3(0:JZ,JY,JX)
    volwnb: [jx][jy][jz + 1]f32, // Fortran: VOLWNB(0:JZ,JY,JX)
    volwhg: [jx][jy][jz + 1]f32, // Fortran: VOLWHG(0:JZ,JY,JX)
    volwxa: [jx][jy][jz + 1]f32, // Fortran: VOLWXA(0:JZ,JY,JX)
    rhgdfg: [jx][jy][jz + 1]f32, // Fortran: RHGDFG(0:JZ,JY,JX)
    thetw1: [jx][jy][jz]f32, // Fortran: THETW1(JZ,JY,JX)
    h2gg2: [jx][jy][jz]f32, // Fortran: H2GG2(JZ,JY,JX)
    h2gsh2: [jx][jy][jz]f32, // Fortran: H2GSH2(JZ,JY,JX)
    hgsgl2: [jx][jy][jz]f32, // Fortran: HGSGL2(JZ,JY,JX)
    rhgfxs: [jx][jy][jz]f32, // Fortran: RHGFXS(JZ,JY,JX)
    rhgflz: [jx][jy][jz]f32, // Fortran: RHGFLZ(JZ,JY,JX)
    thgfhs: [jx][jy][jz]f32, // Fortran: THGFHS(JZ,JY,JX)
    thgflg: [jx][jy][jz]f32, // Fortran: THGFLG(JZ,JY,JX)
    thgfls: [jx][jy][jz]f32, // Fortran: THGFLS(JZ,JY,JX)
    flvm: [jx][jy][jz]f32, // Fortran: FLVM(JZ,JY,JX)
    theth2: [jx][jy][jz]f32, // Fortran: THETH2(JZ,JY,JX)
    thethl: [jx][jy][jz]f32, // Fortran: THETHL(JZ,JY,JX)
    volpma: [jx][jy][jz]f32, // Fortran: VOLPMA(JZ,JY,JX)
    volpmb: [jx][jy][jz]f32, // Fortran: VOLPMB(JZ,JY,JX)
    volwma: [jx][jy][jz]f32, // Fortran: VOLWMA(JZ,JY,JX)
    volwmb: [jx][jy][jz]f32, // Fortran: VOLWMB(JZ,JY,JX)
    volwxb: [jx][jy][jz]f32, // Fortran: VOLWXB(JZ,JY,JX)
    pargco: [jy][jx]f32, // Fortran: PARGCO(JY,JX)
    pargch: [jy][jx]f32, // Fortran: PARGCH(JY,JX)
    pargox: [jy][jx]f32, // Fortran: PARGOX(JY,JX)
    pargng: [jy][jx]f32, // Fortran: PARGNG(JY,JX)
    pargn2: [jy][jx]f32, // Fortran: PARGN2(JY,JX)
    pargn3: [jy][jx]f32, // Fortran: PARGN3(JY,JX)
    pargh2: [jy][jx]f32, // Fortran: PARGH2(JY,JX)

    pub fn init() Blktrnsfr12 {
        return std.mem.zeroInit(Blktrnsfr12, .{});
    }
};
