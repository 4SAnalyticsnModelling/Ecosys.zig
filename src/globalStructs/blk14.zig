const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jp = config.pftmax;

pub const Blk14 = struct {
    carbn: [jx][jy][jp]f32, // Fortran: CARBN(JP,JY,JX)
    tcuptk: [jx][jy][jp]f32, // Fortran: TCUPTK(JP,JY,JX)
    tcsnc: [jx][jy][jp]f32, // Fortran: TCSNC(JP,JY,JX)
    tzuptk: [jx][jy][jp]f32, // Fortran: TZUPTK(JP,JY,JX)
    tzsnc: [jx][jy][jp]f32, // Fortran: TZSNC(JP,JY,JX)
    tpuptk: [jx][jy][jp]f32, // Fortran: TPUPTK(JP,JY,JX)
    tpsnc: [jx][jy][jp]f32, // Fortran: TPSNC(JP,JY,JX)
    tzupfx: [jx][jy][jp]f32, // Fortran: TZUPFX(JP,JY,JX)
    tco2t: [jx][jy][jp]f32, // Fortran: TCO2T(JP,JY,JX)
    balc: [jx][jy][jp]f32, // Fortran: BALC(JP,JY,JX)
    baln: [jx][jy][jp]f32, // Fortran: BALN(JP,JY,JX)
    balp: [jx][jy][jp]f32, // Fortran: BALP(JP,JY,JX)
    hcsnc: [jx][jy][jp]f32, // Fortran: HCSNC(JP,JY,JX)
    hzsnc: [jx][jy][jp]f32, // Fortran: HZSNC(JP,JY,JX)
    hpsnc: [jx][jy][jp]f32, // Fortran: HPSNC(JP,JY,JX)
    hcuptk: [jx][jy][jp]f32, // Fortran: HCUPTK(JP,JY,JX)
    hzuptk: [jx][jy][jp]f32, // Fortran: HZUPTK(JP,JY,JX)
    hpuptk: [jx][jy][jp]f32, // Fortran: HPUPTK(JP,JY,JX)
    znpp: [jx][jy][jp]f32, // Fortran: ZNPP(JP,JY,JX)
    tcsn0: [jx][jy][jp]f32, // Fortran: TCSN0(JP,JY,JX)
    ctran: [jx][jy][jp]f32, // Fortran: CTRAN(JP,JY,JX)
    rnh3c: [jx][jy][jp]f32, // Fortran: RNH3C(JP,JY,JX)
    rsetc: [jx][jy][jp]f32, // Fortran: RSETC(JP,JY,JX)
    rsetn: [jx][jy][jp]f32, // Fortran: RSETN(JP,JY,JX)
    rsetp: [jx][jy][jp]f32, // Fortran: RSETP(JP,JY,JX)
    hvstc: [jx][jy][jp]f32, // Fortran: HVSTC(JP,JY,JX)
    hvstn: [jx][jy][jp]f32, // Fortran: HVSTN(JP,JY,JX)
    hvstp: [jx][jy][jp]f32, // Fortran: HVSTP(JP,JY,JX)
    thvstc: [jx][jy][jp]f32, // Fortran: THVSTC(JP,JY,JX)
    thvstn: [jx][jy][jp]f32, // Fortran: THVSTN(JP,JY,JX)
    tnh3c: [jx][jy][jp]f32, // Fortran: TNH3C(JP,JY,JX)
    thvstp: [jx][jy][jp]f32, // Fortran: THVSTP(JP,JY,JX)
    tco2a: [jx][jy][jp]f32, // Fortran: TCO2A(JP,JY,JX)
    vco2f: [jx][jy][jp]f32, // Fortran: VCO2F(JP,JY,JX)
    vch4f: [jx][jy][jp]f32, // Fortran: VCH4F(JP,JY,JX)
    voxyf: [jx][jy][jp]f32, // Fortran: VOXYF(JP,JY,JX)
    vnh3f: [jx][jy][jp]f32, // Fortran: VNH3F(JP,JY,JX)
    vn2of: [jx][jy][jp]f32, // Fortran: VN2OF(JP,JY,JX)
    vpo4f: [jx][jy][jp]f32, // Fortran: VPO4F(JP,JY,JX)
    tzsn0: [jx][jy][jp]f32, // Fortran: TZSN0(JP,JY,JX)
    tpsn0: [jx][jy][jp]f32, // Fortran: TPSN0(JP,JY,JX)

    pub fn init() Blk14 {
        return std.mem.zeroInit(Blk14, .{});
    }
};
