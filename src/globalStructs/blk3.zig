const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jp = config.pftmax;
const jc = config.canopymax;

pub const Blk3 = struct {
    iday: [jx][jy][jp][jc][10]i32, // Fortran: IDAY(10,JC,JP,JY,JX)
    group: [jx][jy][jp][jc]f32, // Fortran: GROUP(JC,JP,JY,JX)
    gstgi: [jx][jy][jp][jc]f32, // Fortran: GSTGI(JC,JP,JY,JX)
    vstg: [jx][jy][jp][jc]f32, // Fortran: VSTG(JC,JP,JY,JX)
    vstgx: [jx][jy][jp][jc]f32, // Fortran: VSTGX(JC,JP,JY,JX)
    dgstgi: [jx][jy][jp][jc]f32, // Fortran: DGSTGI(JC,JP,JY,JX)
    dgstgf: [jx][jy][jp][jc]f32, // Fortran: DGSTGF(JC,JP,JY,JX)
    pstg: [jx][jy][jp][jc]f32, // Fortran: PSTG(JC,JP,JY,JX)
    pstgi: [jx][jy][jp][jc]f32, // Fortran: PSTGI(JC,JP,JY,JX)
    gstgf: [jx][jy][jp][jc]f32, // Fortran: GSTGF(JC,JP,JY,JX)
    pstgf: [jx][jy][jp][jc]f32, // Fortran: PSTGF(JC,JP,JY,JX)
    tgstgi: [jx][jy][jp][jc]f32, // Fortran: TGSTGI(JC,JP,JY,JX)
    tgstgf: [jx][jy][jp][jc]f32, // Fortran: TGSTGF(JC,JP,JY,JX)
    flg4: [jx][jy][jp][jc]f32, // Fortran: FLG4(JC,JP,JY,JX)
    vrns: [jx][jy][jp][jc]f32, // Fortran: VRNS(JC,JP,JY,JX)
    vrnf: [jx][jy][jp][jc]f32, // Fortran: VRNF(JC,JP,JY,JX)
    atrp: [jx][jy][jp][jc]f32, // Fortran: ATRP(JC,JP,JY,JX)
    flgz: [jx][jy][jp][jc]f32, // Fortran: FLGZ(JC,JP,JY,JX)
    vrny: [jx][jy][jp][jc]f32, // Fortran: VRNY(JC,JP,JY,JX)
    vrnz: [jx][jy][jp][jc]f32, // Fortran: VRNZ(JC,JP,JY,JX)
    kvstgn: [jx][jy][jp][jc]i32, // Fortran: KVSTGN(JC,JP,JY,JX)
    nbtb: [jx][jy][jp][jc]i32, // Fortran: NBTB(JC,JP,JY,JX)
    ninr: [jx][jy][jp][jc]i32, // Fortran: NINR(JC,JP,JY,JX)
    kleaf: [jx][jy][jp][jc]i32, // Fortran: KLEAF(JC,JP,JY,JX)
    iflgr: [jx][jy][jp][jc]i32, // Fortran: IFLGR(JC,JP,JY,JX)
    iflgq: [jx][jy][jp][jc]i32, // Fortran: IFLGQ(JC,JP,JY,JX)
    iflgg: [jx][jy][jp][jc]i32, // Fortran: IFLGG(JC,JP,JY,JX)
    kvstg: [jx][jy][jp][jc]i32, // Fortran: KVSTG(JC,JP,JY,JX)
    idthb: [jx][jy][jp][jc]i32, // Fortran: IDTHB(JC,JP,JY,JX)
    iflgp: [jx][jy][jp][jc]i32, // Fortran: IFLGP(JC,JP,JY,JX)
    iflga: [jx][jy][jp][jc]i32, // Fortran: IFLGA(JC,JP,JY,JX)
    iflge: [jx][jy][jp][jc]i32, // Fortran: IFLGE(JC,JP,JY,JX)
    iflgf: [jx][jy][jp][jc]i32, // Fortran: IFLGF(JC,JP,JY,JX)
    kleafx: [jx][jy][jp][jc]i32, // Fortran: KLEAFX(JC,JP,JY,JX)
    psilz: [jx][jy][jp]f32, // Fortran: PSILZ(JP,JY,JX)
    nbr: [jx][jy][jp]i32, // Fortran: NBR(JP,JY,JX)
    nb1: [jx][jy][jp]i32, // Fortran: NB1(JP,JY,JX)
    nrt: [jx][jy][jp]i32, // Fortran: NRT(JP,JY,JX)
    nbt: [jx][jy][jp]i32, // Fortran: NBT(JP,JY,JX)
    idthr: [jx][jy][jp]i32, // Fortran: IDTHR(JP,JY,JX)
    idthp: [jx][jy][jp]i32, // Fortran: IDTHP(JP,JY,JX)
    nix: [jx][jy][jp]i32, // Fortran: NIX(JP,JY,JX)
    ni: [jx][jy][jp]i32, // Fortran: NI(JP,JY,JX)
    ng: [jx][jy][jp]i32, // Fortran: NG(JP,JY,JX)

    pub fn init() Blk3 {
        return std.mem.zeroInit(Blk3, .{});
    }
};
