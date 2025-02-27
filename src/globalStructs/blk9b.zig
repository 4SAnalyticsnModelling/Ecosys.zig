const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jp = config.pftmax;

pub const Blk9b = struct {
    class: [jx][jy][jp][4]f32, // Fortran: CLASS(4,JP,JY,JX)
    rrad1m: [jx][jy][jp][2]f32, // Fortran: RRAD1M(2,JP,JY,JX)
    rrad2m: [jx][jy][jp][2]f32, // Fortran: RRAD2M(2,JP,JY,JX)
    port: [jx][jy][jp][2]f32, // Fortran: PORT(2,JP,JY,JX)
    rsrr: [jx][jy][jp][2]f32, // Fortran: RSRR(2,JP,JY,JX)
    rsra: [jx][jy][jp][2]f32, // Fortran: RSRA(2,JP,JY,JX)
    upmxzh: [jx][jy][jp][2]f32, // Fortran: UPMXZH(2,JP,JY,JX)
    upkmzh: [jx][jy][jp][2]f32, // Fortran: UPKMZH(2,JP,JY,JX)
    upmnzh: [jx][jy][jp][2]f32, // Fortran: UPMNZH(2,JP,JY,JX)
    upmxzo: [jx][jy][jp][2]f32, // Fortran: UPMXZO(2,JP,JY,JX)
    upkmzo: [jx][jy][jp][2]f32, // Fortran: UPKMZO(2,JP,JY,JX)
    upmnzo: [jx][jy][jp][2]f32, // Fortran: UPMNZO(2,JP,JY,JX)
    upmxpo: [jx][jy][jp][2]f32, // Fortran: UPMXPO(2,JP,JY,JX)
    upkmpo: [jx][jy][jp][2]f32, // Fortran: UPKMPO(2,JP,JY,JX)
    upmnpo: [jx][jy][jp][2]f32, // Fortran: UPMNPO(2,JP,JY,JX)
    rradp: [jx][jy][jp][2]f32, // Fortran: RRADP(2,JP,JY,JX)
    offst: [jx][jy][jp]f32, // Fortran: OFFST(JP,JY,JX)
    tcz: [jx][jy][jp]f32, // Fortran: TCZ(JP,JY,JX)
    pr: [jx][jy][jp]f32, // Fortran: PR(JP,JY,JX)
    ptsht: [jx][jy][jp]f32, // Fortran: PTSHT(JP,JY,JX)
    cnrts: [jx][jy][jp]f32, // Fortran: CNRTS(JP,JY,JX)
    cprts: [jx][jy][jp]f32, // Fortran: CPRTS(JP,JY,JX)
    albr: [jx][jy][jp]f32, // Fortran: ALBR(JP,JY,JX)
    albp: [jx][jy][jp]f32, // Fortran: ALBP(JP,JY,JX)
    taur: [jx][jy][jp]f32, // Fortran: TAUR(JP,JY,JX)
    taup: [jx][jy][jp]f32, // Fortran: TAUP(JP,JY,JX)
    absr: [jx][jy][jp]f32, // Fortran: ABSR(JP,JY,JX)
    absp: [jx][jy][jp]f32, // Fortran: ABSP(JP,JY,JX)
    tcx: [jx][jy][jp]f32, // Fortran: TCX(JP,JY,JX)
    ztypi: [jx][jy][jp]f32, // Fortran: ZTYPI(JP,JY,JX)
    ztyp: [jx][jy][jp]f32, // Fortran: ZTYP(JP,JY,JX)
    my: [jx][jy][jp]f32, // Fortran: MY(JP,JY,JX)
    ictyp: [jx][jy][jp]i32, // Fortran: ICTYP(JP,JY,JX)
    igtyp: [jx][jy][jp]i32, // Fortran: IGTYP(JP,JY,JX)
    istyp: [jx][jy][jp]i32, // Fortran: ISTYP(JP,JY,JX)
    idtyp: [jx][jy][jp]i32, // Fortran: IDTYP(JP,JY,JX)
    nnod: [jx][jy][jp]i32, // Fortran: NNOD(JP,JY,JX)
    intyp: [jx][jy][jp]i32, // Fortran: INTYP(JP,JY,JX)
    iwtyp: [jx][jy][jp]i32, // Fortran: IWTYP(JP,JY,JX)
    iptyp: [jx][jy][jp]i32, // Fortran: IPTYP(JP,JY,JX)
    ibtyp: [jx][jy][jp]i32, // Fortran: IBTYP(JP,JY,JX)
    irtyp: [jx][jy][jp]i32, // Fortran: IRTYP(JP,JY,JX)
    tczd: f32, // Fortran: TCZD
    tcxd: f32, // Fortran: TCXD

    pub fn init() Blk9b {
        return std.mem.zeroInit(Blk9b, .{});
    }
};
