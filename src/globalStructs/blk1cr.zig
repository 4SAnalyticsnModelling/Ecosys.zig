const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jp = config.pftmax;
const jc = config.canopymax;

pub const Blk1cr = struct {
    wtrt: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtrts: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wsrtl: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    wtrt1: [jx][jy][jp][jc][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jc][jz][2]f32),
    wtrt2: [jx][jy][jp][jc][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jc][jz][2]f32),
    wtrtd: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtlgp: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtlg1: [jx][jy][jp][jc][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jc][jz][2]f32),
    rtlg2: [jx][jy][jp][jc][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jc][jz][2]f32),
    rtdnp: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtn1: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtnl: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtn2: [jx][jy][jp][jc][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jc][jz][2]f32),
    rtlga: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtarp: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtvlw: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rrad1: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtvlp: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtdp1: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rrad2: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtlg1x: [jx][jy][jp][2]f32 = std.mem.zeroes([jx][jy][jp][2]f32),
    rtlg2x: [jx][jy][jp][2]f32 = std.mem.zeroes([jx][jy][jp][2]f32),
    wtrvc: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtrvx: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtndl: [jx][jy][jp][jz]f32 = std.mem.zeroes([jx][jy][jp][jz]f32),
    wtnd: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtrvn: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtrvp: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtrtl: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    cpoolr: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ccpolr: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtwt1: [jx][jy][jp][jc][2]f32 = std.mem.zeroes([jx][jy][jp][jc][2]f32),
    htctl: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    cwsrtl: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    cpooln: [jx][jy][jp][jz]f32 = std.mem.zeroes([jx][jy][jp][jz]f32),

    pub fn init() Blk1cr {
        return .{};
    }
};