const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jh = jx + 1;
const jv = jy + 1;

pub const Blktrnsfr14 = struct {
    rqroc0: [jh][jv][5]f32, // Fortran: RQROC0(0:4,JV,JH)
    rqron0: [jh][jv][5]f32, // Fortran: RQRON0(0:4,JV,JH)
    rqrop0: [jh][jv][5]f32, // Fortran: RQROP0(0:4,JV,JH)
    rqroa0: [jh][jv][5]f32, // Fortran: RQROA0(0:4,JV,JH)
    rqrcos0: [jh][jv]f32, // Fortran: RQRCOS0(JV,JH)
    rqrchs0: [jh][jv]f32, // Fortran: RQRCHS0(JV,JH)
    rqroxs0: [jh][jv]f32, // Fortran: RQROXS0(JV,JH)
    rqrngs0: [jh][jv]f32, // Fortran: RQRNGS0(JV,JH)
    rqrn2s0: [jh][jv]f32, // Fortran: RQRN2S0(JV,JH)
    rqrhgs0: [jh][jv]f32, // Fortran: RQRHGS0(JV,JH)
    rqrnh40: [jh][jv]f32, // Fortran: RQRNH40(JV,JH)
    rqrnh30: [jh][jv]f32, // Fortran: RQRNH30(JV,JH)
    rqrno30: [jh][jv]f32, // Fortran: RQRNO30(JV,JH)
    rqrno20: [jh][jv]f32, // Fortran: RQRNO20(JV,JH)
    rqrh2p0: [jh][jv]f32, // Fortran: RQRH2P0(JV,JH)
    rqrh1p0: [jh][jv]f32, // Fortran: RQRH1P0(JV,JH)
    volcor: [jx][jy]f32, // Fortran: VOLCOR(JY,JX)
    volchr: [jx][jy]f32, // Fortran: VOLCHR(JY,JX)
    voloxr: [jx][jy]f32, // Fortran: VOLOXR(JY,JX)
    volngr: [jx][jy]f32, // Fortran: VOLNGR(JY,JX)
    voln2r: [jx][jy]f32, // Fortran: VOLN2R(JY,JX)
    voln3r: [jx][jy]f32, // Fortran: VOLN3R(JY,JX)
    volhgr: [jx][jy]f32, // Fortran: VOLHGR(JY,JX)
    volcot: [jx][jy]f32, // Fortran: VOLCOT(JY,JX)
    volcht: [jx][jy]f32, // Fortran: VOLCHT(JY,JX)
    voloxt: [jx][jy]f32, // Fortran: VOLOXT(JY,JX)
    volngt: [jx][jy]f32, // Fortran: VOLNGT(JY,JX)
    voln2t: [jx][jy]f32, // Fortran: VOLN2T(JY,JX)
    voln3t: [jx][jy]f32, // Fortran: VOLN3T(JY,JX)
    volnbt: [jx][jy]f32, // Fortran: VOLNBT(JY,JX)
    volhgt: [jx][jy]f32, // Fortran: VOLHGT(JY,JX)

    pub fn init() Blktrnsfr14 {
        return std.mem.zeroInit(Blktrnsfr14, .{});
    }
};
