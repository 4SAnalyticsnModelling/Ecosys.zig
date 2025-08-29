const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jp = config.pftmax;
const jc = config.canopymax;
const offset: u32 = 1;

pub const Blk1n = struct {
    wglfln: [jx][jy][jp][jc][26][jz]f32, // Fortran: WGLFLN(JZ,0:25,JC,JP,JY,JX)
    zsnc: [jx][jy][jp][jz + offset][2][4]f32, // Fortran: ZSNC(4,0:1,0:JZ,JP,JY,JX)
    cfopn: [jx][jy][jp][4][6]f32, // Fortran: CFOPN(0:5,4,JP,JY,JX)
    zpoolr: [jx][jy][jp][jz][2]f32, // Fortran: ZPOOLR(2,JZ,JP,JY,JX)
    czpolr: [jx][jy][jp][jz][2]f32, // Fortran: CZPOLR(2,JZ,JP,JY,JX)
    wtrt1n: [jx][jy][jp][jc][jz][2]f32, // Fortran: WTRT1N(2,JZ,JC,JP,JY,JX)
    wtrt2n: [jx][jy][jp][jc][jz][2]f32, // Fortran: WTRT2N(2,JZ,JC,JP,JY,JX)
    rtwt1n: [jx][jy][jp][jc][2]f32, // Fortran: RTWT1N(2,JC,JP,JY,JX)
    wtstdn: [jx][jy][jp][4]f32, // Fortran: WTSTDN(4,JP,JY,JX)
    wglfn: [jx][jy][jp][jc][26]f32, // Fortran: WGLFN(0:25,JC,JP,JY,JX)
    wgshn: [jx][jy][jp][jc][26]f32, // Fortran: WGSHN(0:25,JC,JP,JY,JX)
    wgnodn: [jx][jy][jp][jc][26]f32, // Fortran: WGNODN(0:25,JC,JP,JY,JX)
    wtlfbn: [jx][jy][jp][jc]f32, // Fortran: WTLFBN(JC,JP,JY,JX)
    wtshbn: [jx][jy][jp][jc]f32, // Fortran: WTSHBN(JC,JP,JY,JX)
    wtstbn: [jx][jy][jp][jc]f32, // Fortran: WTSTBN(JC,JP,JY,JX)
    wtrsbn: [jx][jy][jp][jc]f32, // Fortran: WTRSBN(JC,JP,JY,JX)
    wthsbn: [jx][jy][jp][jc]f32, // Fortran: WTHSBN(JC,JP,JY,JX)
    wteabn: [jx][jy][jp][jc]f32, // Fortran: WTEABN(JC,JP,JY,JX)
    wtgrbn: [jx][jy][jp][jc]f32, // Fortran: WTGRBN(JC,JP,JY,JX)
    zpool: [jx][jy][jp][jc]f32, // Fortran: ZPOOL(JC,JP,JY,JX)
    czpolb: [jx][jy][jp][jc]f32, // Fortran: CZPOLB(JC,JP,JY,JX)
    zpolnb: [jx][jy][jp][jc]f32, // Fortran: ZPOLNB(JC,JP,JY,JX)
    wtndbn: [jx][jy][jp][jc]f32, // Fortran: WTNDBN(JC,JP,JY,JX)
    wtndln: [jx][jy][jp][jz]f32, // Fortran: WTNDLN(JZ,JP,JY,JX)
    wtshn: [jx][jy][jp]f32, // Fortran: WTSHN(JP,JY,JX)
    zpoolp: [jx][jy][jp]f32, // Fortran: ZPOOLP(JP,JY,JX)
    wtlfn: [jx][jy][jp]f32, // Fortran: WTLFN(JP,JY,JX)
    wtshen: [jx][jy][jp]f32, // Fortran: WTSHEN(JP,JY,JX)
    wtstkn: [jx][jy][jp]f32, // Fortran: WTSTKN(JP,JY,JX)
    wtrsvn: [jx][jy][jp]f32, // Fortran: WTRSVN(JP,JY,JX)
    wthskn: [jx][jy][jp]f32, // Fortran: WTHSKN(JP,JY,JX)
    wtearn: [jx][jy][jp]f32, // Fortran: WTEARN(JP,JY,JX)
    wtgrnn: [jx][jy][jp]f32, // Fortran: WTGRNN(JP,JY,JX)
    wtrtn: [jx][jy][jp]f32, // Fortran: WTRTN(JP,JY,JX)
    wtndn: [jx][jy][jp]f32, // Fortran: WTNDN(JP,JY,JX)
    czpolp: [jx][jy][jp]f32, // Fortran: CZPOLP(JP,JY,JX)
    wtstgn: [jx][jy][jp]f32, // Fortran: WTSTGN(JP,JY,JX)
    zpolnp: [jx][jy][jp]f32, // Fortran: ZPOLNP(JP,JY,JX)

    pub fn init() Blk1n {
        return std.mem.zeroInit(Blk1n, .{});
    }
};
