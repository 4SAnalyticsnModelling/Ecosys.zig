const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const js = config.snowlayersmax;

pub const Blk19d = struct {
    co2w: [jx][jy][js]f32, // Fortran: CO2W(JS,JY,JX)
    ch4w: [jx][jy][js]f32, // Fortran: CH4W(JS,JY,JX)
    oxyw: [jx][jy][js]f32, // Fortran: OXYW(JS,JY,JX)
    zn2w: [jx][jy][js]f32, // Fortran: ZN2W(JS,JY,JX)
    zngw: [jx][jy][js]f32, // Fortran: ZNGW(JS,JY,JX)
    zn4w: [jx][jy][js]f32, // Fortran: ZN4W(JS,JY,JX)
    zn3w: [jx][jy][js]f32, // Fortran: ZN3W(JS,JY,JX)
    znow: [jx][jy][js]f32, // Fortran: ZNOW(JS,JY,JX)
    z1pw: [jx][jy][js]f32, // Fortran: Z1PW(JS,JY,JX)
    zhpw: [jx][jy][js]f32, // Fortran: ZHPW(JS,JY,JX)
    zalw: [jx][jy][js]f32, // Fortran: ZALW(JS,JY,JX)
    zfew: [jx][jy][js]f32, // Fortran: ZFEW(JS,JY,JX)
    zhyw: [jx][jy][js]f32, // Fortran: ZHYW(JS,JY,JX)
    zcaw: [jx][jy][js]f32, // Fortran: ZCAW(JS,JY,JX)
    zmgw: [jx][jy][js]f32, // Fortran: ZMGW(JS,JY,JX)
    znaw: [jx][jy][js]f32, // Fortran: ZNAW(JS,JY,JX)
    zkaw: [jx][jy][js]f32, // Fortran: ZKAW(JS,JY,JX)
    zohw: [jx][jy][js]f32, // Fortran: ZOHW(JS,JY,JX)
    zso4w: [jx][jy][js]f32, // Fortran: ZSO4W(JS,JY,JX)
    zclw: [jx][jy][js]f32, // Fortran: ZCLW(JS,JY,JX)
    zco3w: [jx][jy][js]f32, // Fortran: ZCO3W(JS,JY,JX)
    zhco3w: [jx][jy][js]f32, // Fortran: ZHCO3W(JS,JY,JX)
    zalh1w: [jx][jy][js]f32, // Fortran: ZALH1W(JS,JY,JX)
    zalh2w: [jx][jy][js]f32, // Fortran: ZALH2W(JS,JY,JX)
    zalh3w: [jx][jy][js]f32, // Fortran: ZALH3W(JS,JY,JX)
    zalh4w: [jx][jy][js]f32, // Fortran: ZALH4W(JS,JY,JX)
    zalsw: [jx][jy][js]f32, // Fortran: ZALSW(JS,JY,JX)
    zfeh1w: [jx][jy][js]f32, // Fortran: ZFEH1W(JS,JY,JX)
    zfeh2w: [jx][jy][js]f32, // Fortran: ZFEH2W(JS,JY,JX)
    zfeh3w: [jx][jy][js]f32, // Fortran: ZFEH3W(JS,JY,JX)
    zfeh4w: [jx][jy][js]f32, // Fortran: ZFEH4W(JS,JY,JX)
    zfesw: [jx][jy][js]f32, // Fortran: ZFESW(JS,JY,JX)
    zcaow: [jx][jy][js]f32, // Fortran: ZCAOW(JS,JY,JX)
    zcacw: [jx][jy][js]f32, // Fortran: ZCACW(JS,JY,JX)
    zcahw: [jx][jy][js]f32, // Fortran: ZCAHW(JS,JY,JX)
    zcasw: [jx][jy][js]f32, // Fortran: ZCASW(JS,JY,JX)
    zmgow: [jx][jy][js]f32, // Fortran: ZMGOW(JS,JY,JX)
    zmgcw: [jx][jy][js]f32, // Fortran: ZMGCW(JS,JY,JX)
    zmghw: [jx][jy][js]f32, // Fortran: ZMGHW(JS,JY,JX)
    zmgsw: [jx][jy][js]f32, // Fortran: ZMGSW(JS,JY,JX)
    znacw: [jx][jy][js]f32, // Fortran: ZNACW(JS,JY,JX)
    znasw: [jx][jy][js]f32, // Fortran: ZNASW(JS,JY,JX)
    zkasw: [jx][jy][js]f32, // Fortran: ZKASW(JS,JY,JX)
    h0po4w: [jx][jy][js]f32, // Fortran: H0PO4W(JS,JY,JX)
    h3po4w: [jx][jy][js]f32, // Fortran: H3PO4W(JS,JY,JX)
    zfe1pw: [jx][jy][js]f32, // Fortran: ZFE1PW(JS,JY,JX)
    zfe2pw: [jx][jy][js]f32, // Fortran: ZFE2PW(JS,JY,JX)
    zca0pw: [jx][jy][js]f32, // Fortran: ZCA0PW(JS,JY,JX)
    zca1pw: [jx][jy][js]f32, // Fortran: ZCA1PW(JS,JY,JX)
    zca2pw: [jx][jy][js]f32, // Fortran: ZCA2PW(JS,JY,JX)
    zmg1pw: [jx][jy][js]f32, // Fortran: ZMG1PW(JS,JY,JX)

    pub fn init() Blk19d {
        return std.mem.zeroInit(Blk19d, .{});
    }
};
