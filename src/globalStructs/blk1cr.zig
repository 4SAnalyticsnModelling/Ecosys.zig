const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jp = config.pftmax;
const jc = config.canopymax;

pub const Blk1cr = struct {
    wtrt1: [jx][jy][jp][jc][jz][2]f32, // Fortran: WTRT1(2,JZ,JC,JP,JY,JX)
    wtrt2: [jx][jy][jp][jc][jz][2]f32, // Fortran: WTRT2(2,JZ,JC,JP,JY,JX)
    rtlg1: [jx][jy][jp][jc][jz][2]f32, // Fortran: RTLG1(2,JZ,JC,JP,JY,JX)
    rtlg2: [jx][jy][jp][jc][jz][2]f32, // Fortran: RTLG2(2,JZ,JC,JP,JY,JX)
    rtn2: [jx][jy][jp][jc][jz][2]f32, // Fortran: RTN2(2,JZ,JC,JP,JY,JX)
    rtwt1: [jx][jy][jp][jc][2]f32, // Fortran: RTWT1(2,JC,JP,JY,JX)
    wsrtl: [jx][jy][jp][jz][2]f32, // Fortran: WSRTL(2,JZ,JP,JY,JX)
    wtrtd: [jx][jy][jp][jz][2]f32, // Fortran: WTRTD(2,JZ,JP,JY,JX)
    rtlgp: [jx][jy][jp][jz][2]f32, // Fortran: RTLGP(2,JZ,JP,JY,JX)
    rtdnp: [jx][jy][jp][jz][2]f32, // Fortran: RTDNP(2,JZ,JP,JY,JX)
    rtn1: [jx][jy][jp][jz][2]f32, // Fortran: RTN1(2,JZ,JP,JY,JX)
    rtnl: [jx][jy][jp][jz][2]f32, // Fortran: RTNL(2,JZ,JP,JY,JX)
    rtlga: [jx][jy][jp][jz][2]f32, // Fortran: RTLGA(2,JZ,JP,JY,JX)
    rtarp: [jx][jy][jp][jz][2]f32, // Fortran: RTARP(2,JZ,JP,JY,JX)
    rtvlw: [jx][jy][jp][jz][2]f32, // Fortran: RTVLW(2,JZ,JP,JY,JX)
    rrad1: [jx][jy][jp][jz][2]f32, // Fortran: RRAD1(2,JZ,JP,JY,JX)
    rtvlp: [jx][jy][jp][jz][2]f32, // Fortran: RTVLP(2,JZ,JP,JY,JX)
    rtdp1: [jx][jy][jp][jz][2]f32, // Fortran: RTDP1(2,JZ,JP,JY,JX)
    rrad2: [jx][jy][jp][jz][2]f32, // Fortran: RRAD2(2,JZ,JP,JY,JX)
    cwsrtl: [jx][jy][jp][jz][2]f32, // Fortran: CWSRTL(2,JZ,JP,JY,JX)
    cpoolr: [jx][jy][jp][jz][2]f32, // Fortran: CPOOLR(2,JZ,JP,JY,JX)
    ccpolr: [jx][jy][jp][jz][2]f32, // Fortran: CCPOLR(2,JZ,JP,JY,JX)
    wtrtl: [jx][jy][jp][jz][2]f32, // Fortran: WTRTL(2,JZ,JP,JY,JX)
    wtndl: [jx][jy][jp][jz]f32, // Fortran: WTNDL(JZ,JP,JY,JX)
    cpooln: [jx][jy][jp][jz]f32, // Fortran: CPOOLN(JZ,JP,JY,JX)
    rtlg1x: [jx][jy][jp][2]f32, // Fortran: RTLG1X(2,JP,JY,JX)
    rtlg2x: [jx][jy][jp][2]f32, // Fortran: RTLG2X(2,JP,JY,JX)
    wtrvc: [jx][jy][jp]f32, // Fortran: WTRVC(JP,JY,JX)
    wtrvx: [jx][jy][jp]f32, // Fortran: WTRVX(JP,JY,JX)
    wtrvn: [jx][jy][jp]f32, // Fortran: WTRVN(JP,JY,JX)
    wtrvp: [jx][jy][jp]f32, // Fortran: WTRVP(JP,JY,JX)
    wtrt: [jx][jy][jp]f32, // Fortran: WTRT(JP,JY,JX)
    wtrts: [jx][jy][jp]f32, // Fortran: WTRTS(JP,JY,JX)
    wtnd: [jx][jy][jp]f32, // Fortran: WTND(JP,JY,JX)
    htctl: [jx][jy][jp]f32, // Fortran: HTCTL(JP,JY,JX)

    pub fn init() Blk1cr {
        return std.mem.zeroInit(Blk1cr, .{});
    }
};
