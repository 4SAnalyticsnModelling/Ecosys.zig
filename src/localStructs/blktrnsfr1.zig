const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const js = config.snowlayersmax;

pub const Blktrnsfr1 = struct {
    oqc2: [jx][jy][jz + 1][5]f32, // Fortran: OQC2(0:4,0:JZ,JY,JX)
    oqn2: [jx][jy][jz + 1][5]f32, // Fortran: OQN2(0:4,0:JZ,JY,JX)
    oqp2: [jx][jy][jz + 1][5]f32, // Fortran: OQP2(0:4,0:JZ,JY,JX)
    oqa2: [jx][jy][jz + 1][5]f32, // Fortran: OQA2(0:4,0:JZ,JY,JX)
    co2s2: [jx][jy][jz + 1]f32, // Fortran: CO2S2(0:JZ,JY,JX)
    ch4s2: [jx][jy][jz + 1]f32, // Fortran: CH4S2(0:JZ,JY,JX)
    oxys2: [jx][jy][jz + 1]f32, // Fortran: OXYS2(0:JZ,JY,JX)
    z2gs2: [jx][jy][jz + 1]f32, // Fortran: Z2GS2(0:JZ,JY,JX)
    z2os2: [jx][jy][jz + 1]f32, // Fortran: Z2OS2(0:JZ,JY,JX)
    zn3g2: [jx][jy][jz + 1]f32, // Fortran: ZN3G2(0:JZ,JY,JX)
    znh4s2: [jx][jy][jz + 1]f32, // Fortran: ZNH4S2(0:JZ,JY,JX)
    znh4b2: [jx][jy][jz + 1]f32, // Fortran: ZNH4B2(0:JZ,JY,JX)
    znh3s2: [jx][jy][jz + 1]f32, // Fortran: ZNH3S2(0:JZ,JY,JX)
    znh3b2: [jx][jy][jz + 1]f32, // Fortran: ZNH3B2(0:JZ,JY,JX)
    zno3s2: [jx][jy][jz + 1]f32, // Fortran: ZNO3S2(0:JZ,JY,JX)
    zno3b2: [jx][jy][jz + 1]f32, // Fortran: ZNO3B2(0:JZ,JY,JX)
    h2po42: [jx][jy][jz + 1]f32, // Fortran: H2PO42(0:JZ,JY,JX)
    h2pob2: [jx][jy][jz + 1]f32, // Fortran: H2POB2(0:JZ,JY,JX)
    zno2s2: [jx][jy][jz + 1]f32, // Fortran: ZNO2S2(0:JZ,JY,JX)
    ocsgl2: [jx][jy][jz + 1]f32, // Fortran: OCSGL2(0:JZ,JY,JX)
    onsgl2: [jx][jy][jz + 1]f32, // Fortran: ONSGL2(0:JZ,JY,JX)
    opsgl2: [jx][jy][jz + 1]f32, // Fortran: OPSGL2(0:JZ,JY,JX)
    oasgl2: [jx][jy][jz + 1]f32, // Fortran: OASGL2(0:JZ,JY,JX)
    chy0: [jx][jy][jz + 1]f32, // Fortran: CHY0(0:JZ,JY,JX)
    h1po42: [jx][jy][jz + 1]f32, // Fortran: H1PO42(0:JZ,JY,JX)
    h1pob2: [jx][jy][jz + 1]f32, // Fortran: H1POB2(0:JZ,JY,JX)
    co2g2: [jx][jy][jz]f32, // Fortran: CO2G2(JZ,JY,JX)
    ch4g2: [jx][jy][jz]f32, // Fortran: CH4G2(JZ,JY,JX)
    oxyg2: [jx][jy][jz]f32, // Fortran: OXYG2(JZ,JY,JX)
    z2gg2: [jx][jy][jz]f32, // Fortran: Z2GG2(JZ,JY,JX)
    z2og2: [jx][jy][jz]f32, // Fortran: Z2OG2(JZ,JY,JX)
    cgsgl2: [jx][jy][jz]f32, // Fortran: CGSGL2(JZ,JY,JX)
    chsgl2: [jx][jy][jz]f32, // Fortran: CHSGL2(JZ,JY,JX)
    ogsgl2: [jx][jy][jz]f32, // Fortran: OGSGL2(JZ,JY,JX)
    zgsgl2: [jx][jy][jz]f32, // Fortran: ZGSGL2(JZ,JY,JX)
    z2sgl2: [jx][jy][jz]f32, // Fortran: Z2SGL2(JZ,JY,JX)
    zhsgl2: [jx][jy][jz]f32, // Fortran: ZHSGL2(JZ,JY,JX)
    co2w2: [jx][jy][js]f32, // Fortran: CO2W2(JS,JY,JX)
    ch4w2: [jx][jy][js]f32, // Fortran: CH4W2(JS,JY,JX)
    oxyw2: [jx][jy][js]f32, // Fortran: OXYW2(JS,JY,JX)
    zngw2: [jx][jy][js]f32, // Fortran: ZNGW2(JS,JY,JX)
    zn2w2: [jx][jy][js]f32, // Fortran: ZN2W2(JS,JY,JX)
    zn4w2: [jx][jy][js]f32, // Fortran: ZN4W2(JS,JY,JX)
    zn3w2: [jx][jy][js]f32, // Fortran: ZN3W2(JS,JY,JX)
    znow2: [jx][jy][js]f32, // Fortran: ZNOW2(JS,JY,JX)
    zhpw2: [jx][jy][js]f32, // Fortran: ZHPW2(JS,JY,JX)
    z1pw2: [jx][jy][js]f32, // Fortran: Z1PW2(JS,JY,JX)

    pub fn init() Blktrnsfr1 {
        return std.mem.zeroInit(Blktrnsfr1, .{});
    }
};
