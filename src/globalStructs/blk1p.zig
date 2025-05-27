const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jp = config.pftmax;
const jc = config.canopymax;
const offset: u32 = 1;

pub const Blk1p = struct {
    wglflp: [jx][jy][jp][jc][26][jz]f32, // Fortran: WGLFLP(JZ,0:25,JC,JP,JY,JX)
    psnc: [jx][jy][jp][jz + offset][2][4]f32, // Fortran: PSNC(4,0:1,0:JZ,JP,JY,JX)
    cfopp: [jx][jy][jp][4][6]f32, // Fortran: CFOPP(0:5,4,JP,JY,JX)
    ppoolr: [jx][jy][jp][jz][2]f32, // Fortran: PPOOLR(2,JZ,JP,JY,JX)
    cppolr: [jx][jy][jp][jz][2]f32, // Fortran: CPPOLR(2,JZ,JP,JY,JX)
    wtrt1p: [jx][jy][jp][jc][jz][2]f32, // Fortran: WTRT1P(2,JZ,JC,JP,JY,JX)
    wtrt2p: [jx][jy][jp][jc][jz][2]f32, // Fortran: WTRT2P(2,JZ,JC,JP,JY,JX)
    rtwt1p: [jx][jy][jp][jc][2]f32, // Fortran: RTWT1P(2,JC,JP,JY,JX)
    wglfp: [jx][jy][jp][jc][26]f32, // Fortran: WGLFP(0:25,JC,JP,JY,JX)
    wgshp: [jx][jy][jp][jc][26]f32, // Fortran: WGSHP(0:25,JC,JP,JY,JX)
    wgnodp: [jx][jy][jp][jc][26]f32, // Fortran: WGNODP(0:25,JC,JP,JY,JX)
    wtstdp: [jx][jy][jp][4]f32, // Fortran: WTSTDP(4,JP,JY,JX)
    wtlfbp: [jx][jy][jp][jc]f32, // Fortran: WTLFBP(JC,JP,JY,JX)
    wtshbp: [jx][jy][jp][jc]f32, // Fortran: WTSHBP(JC,JP,JY,JX)
    wtstbp: [jx][jy][jp][jc]f32, // Fortran: WTSTBP(JC,JP,JY,JX)
    wtrsbp: [jx][jy][jp][jc]f32, // Fortran: WTRSBP(JC,JP,JY,JX)
    wthsbp: [jx][jy][jp][jc]f32, // Fortran: WTHSBP(JC,JP,JY,JX)
    wteabp: [jx][jy][jp][jc]f32, // Fortran: WTEABP(JC,JP,JY,JX)
    wtgrbp: [jx][jy][jp][jc]f32, // Fortran: WTGRBP(JC,JP,JY,JX)
    ppool: [jx][jy][jp][jc]f32, // Fortran: PPOOL(JC,JP,JY,JX)
    cppolb: [jx][jy][jp][jc]f32, // Fortran: CPPOLB(JC,JP,JY,JX)
    ppolnb: [jx][jy][jp][jc]f32, // Fortran: PPOLNB(JC,JP,JY,JX)
    wtndbp: [jx][jy][jp][jc]f32, // Fortran: WTNDBP(JC,JP,JY,JX)
    wtshtp: [jx][jy][jp][jc]f32, // Fortran: WTSHTP(JC,JP,JY,JX)
    wtndlp: [jx][jy][jp][jz]f32, // Fortran: WTNDLP(JZ,JP,JY,JX)
    wtshp: [jx][jy][jp]f32, // Fortran: WTSHP(JP,JY,JX)
    ppoolp: [jx][jy][jp]f32, // Fortran: PPOOLP(JP,JY,JX)
    wtlfp: [jx][jy][jp]f32, // Fortran: WTLFP(JP,JY,JX)
    wtshep: [jx][jy][jp]f32, // Fortran: WTSHEP(JP,JY,JX)
    wtstkp: [jx][jy][jp]f32, // Fortran: WTSTKP(JP,JY,JX)
    wtrsvp: [jx][jy][jp]f32, // Fortran: WTRSVP(JP,JY,JX)
    wthskp: [jx][jy][jp]f32, // Fortran: WTHSKP(JP,JY,JX)
    wtearp: [jx][jy][jp]f32, // Fortran: WTEARP(JP,JY,JX)
    wtgrnp: [jx][jy][jp]f32, // Fortran: WTGRNP(JP,JY,JX)
    wtrtp: [jx][jy][jp]f32, // Fortran: WTRTP(JP,JY,JX)
    wtndp: [jx][jy][jp]f32, // Fortran: WTNDP(JP,JY,JX)
    cppolp: [jx][jy][jp]f32, // Fortran: CPPOLP(JP,JY,JX)
    wtstgp: [jx][jy][jp]f32, // Fortran: WTSTGP(JP,JY,JX)
    ppolnp: [jx][jy][jp]f32, // Fortran: PPOLNP(JP,JY,JX)

    pub fn init() Blk1p {
        return std.mem.zeroInit(Blk1p, .{});
    }
};
