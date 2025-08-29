const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const js = config.snowlayersmax;

pub const Blktrnsfr10 = struct {
    rcobls: [jx][jy][js]f32, // Fortran: RCOBLS(JS,JY,JX)
    rchbls: [jx][jy][js]f32, // Fortran: RCHBLS(JS,JY,JX)
    roxbls: [jx][jy][js]f32, // Fortran: ROXBLS(JS,JY,JX)
    rngbls: [jx][jy][js]f32, // Fortran: RNGBLS(JS,JY,JX)
    rn2bls: [jx][jy][js]f32, // Fortran: RN2BLS(JS,JY,JX)
    rn4blw: [jx][jy][js]f32, // Fortran: RN4BLW(JS,JY,JX)
    rn3blw: [jx][jy][js]f32, // Fortran: RN3BLW(JS,JY,JX)
    rnoblw: [jx][jy][js]f32, // Fortran: RNOBLW(JS,JY,JX)
    rh1pbs: [jx][jy][js]f32, // Fortran: RH1PBS(JS,JY,JX)
    rh2pbs: [jx][jy][js]f32, // Fortran: RH2PBS(JS,JY,JX)
    tcobls: [jx][jy][js]f32, // Fortran: TCOBLS(JS,JY,JX)
    tchbls: [jx][jy][js]f32, // Fortran: TCHBLS(JS,JY,JX)
    toxbls: [jx][jy][js]f32, // Fortran: TOXBLS(JS,JY,JX)
    tngbls: [jx][jy][js]f32, // Fortran: TNGBLS(JS,JY,JX)
    tn2bls: [jx][jy][js]f32, // Fortran: TN2BLS(JS,JY,JX)
    tn4blw: [jx][jy][js]f32, // Fortran: TN4BLW(JS,JY,JX)
    tn3blw: [jx][jy][js]f32, // Fortran: TN3BLW(JS,JY,JX)
    tnoblw: [jx][jy][js]f32, // Fortran: TNOBLW(JS,JY,JX)
    th1pbs: [jx][jy][js]f32, // Fortran: TH1PBS(JS,JY,JX)
    th2pbs: [jx][jy][js]f32, // Fortran: TH2PBS(JS,JY,JX)

    pub fn init() Blktrnsfr10 {
        return std.mem.zeroInit(Blktrnsfr10, .{});
    }
};
