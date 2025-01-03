const std = @import("std");

pub const Blk1cr = struct {
    wtrt: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtrts: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wsrtl: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    wtrt1: comptime [jx][jy][jp][jc][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jc][jz][2]f32),
    wtrt2: comptime [jx][jy][jp][jc][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jc][jz][2]f32),
    wtrtd: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtlgp: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtlg1: comptime [jx][jy][jp][jc][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jc][jz][2]f32),
    rtlg2: comptime [jx][jy][jp][jc][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jc][jz][2]f32),
    rtdnp: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtn1: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtnl: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtn2: comptime [jx][jy][jp][jc][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jc][jz][2]f32),
    rtlga: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtarp: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtvlw: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rrad1: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtvlp: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtdp1: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rrad2: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtlg1x: comptime [jx][jy][jp][2]f32 = std.mem.zeroes([jx][jy][jp][2]f32),
    rtlg2x: comptime [jx][jy][jp][2]f32 = std.mem.zeroes([jx][jy][jp][2]f32),
    wtrvc: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtrvx: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtndl: comptime [jx][jy][jp][jz]f32 = std.mem.zeroes([jx][jy][jp][jz]f32),
    wtnd: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtrvn: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtrvp: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtrtl: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    cpoolr: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ccpolr: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rtwt1: comptime [jx][jy][jp][jc][2]f32 = std.mem.zeroes([jx][jy][jp][jc][2]f32),
    htctl: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    cwsrtl: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    cpooln: comptime [jx][jy][jp][jz]f32 = std.mem.zeroes([jx][jy][jp][jz]f32),

    pub fn init() Blk1cr {
        return .{};
    }
};
