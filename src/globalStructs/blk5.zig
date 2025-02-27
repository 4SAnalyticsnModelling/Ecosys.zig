const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jc = config.canopymax;

pub const Blk5 = struct {
    tau0: [jx][jy][jc + 1]f32, // Fortran: TAU0(JC+1,JY,JX)
    taus: [jx][jy][jc + 1]f32, // Fortran: TAUS(JC+1,JY,JX)
    zl: [jx][jy][jc + 1]f32, // Fortran: ZL(0:JC,JY,JX)
    omega: [4][4][4]f32, // Fortran: OMEGA(4,4,4)
    omegx: [4][4][4]f32, // Fortran: OMEGX(4,4,4)
    ialby: [4][4][4]i32, // Fortran: IALBY(4,4,4)
    fradg: [jx][jy]f32, // Fortran: FRADG(JY,JX)
    radg: [jx][jy]f32, // Fortran: RADG(JY,JX)
    thrmcx: [jx][jy]f32, // Fortran: THRMCX(JY,JX)
    thrmgx: [jx][jy]f32, // Fortran: THRMGX(JY,JX)
    arlfx: [jx][jy]f32, // Fortran: ARLFX(JY,JX)
    arstx: [jx][jy]f32, // Fortran: ARSTX(JY,JX)
    cnetx: [jx][jy]f32, // Fortran: CNETX(JY,JX)
    zt: [jx][jy]f32, // Fortran: ZT(JY,JX)
    beta: [4][4]f32, // Fortran: BETA(4,4)
    betx: [4][4]f32, // Fortran: BETX(4,4)
    zsin: [4]f32, // Fortran: ZSIN(4)
    zcos: [4]f32, // Fortran: ZCOS(4)

    pub fn init() Blk5 {
        return std.mem.zeroInit(Blk5, .{});
    }
};
