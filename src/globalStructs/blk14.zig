const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jp = config.pftmax;

pub const Blk14 = struct {
    carbn: [jx][jy][jp]f32,
    tcuptk: [jx][jy][jp]f32,
    tcsnc: [jx][jy][jp]f32,
    tzuptk: [jx][jy][jp]f32,
    tzsnc: [jx][jy][jp]f32,
    tpuptk: [jx][jy][jp]f32,
    tpsnc: [jx][jy][jp]f32,
    tzupfx: [jx][jy][jp]f32,
    tco2t: [jx][jy][jp]f32,
    balc: [jx][jy][jp]f32,
    baln: [jx][jy][jp]f32,
    balp: [jx][jy][jp]f32,
    hcsnc: [jx][jy][jp]f32,
    hzsnc: [jx][jy][jp]f32,
    hpsnc: [jx][jy][jp]f32,
    hcuptk: [jx][jy][jp]f32,
    hzuptk: [jx][jy][jp]f32,
    hpuptk: [jx][jy][jp]f32,
    znpp: [jx][jy][jp]f32,
    tcsn0: [jx][jy][jp]f32,
    ctran: [jx][jy][jp]f32,
    rnh3c: [jx][jy][jp]f32,
    rsetc: [jx][jy][jp]f32,
    rsetn: [jx][jy][jp]f32,
    rsetp: [jx][jy][jp]f32,
    hvstc: [jx][jy][jp]f32,
    hvstn: [jx][jy][jp]f32,
    hvstp: [jx][jy][jp]f32,
    thvstc: [jx][jy][jp]f32,
    thvstn: [jx][jy][jp]f32,
    tnh3c: [jx][jy][jp]f32,
    thvstp: [jx][jy][jp]f32,
    tco2a: [jx][jy][jp]f32,
    vco2f: [jx][jy][jp]f32,
    vch4f: [jx][jy][jp]f32,
    voxyf: [jx][jy][jp]f32,
    vnh3f: [jx][jy][jp]f32,
    vn2of: [jx][jy][jp]f32,
    vpo4f: [jx][jy][jp]f32,
    tzsn0: [jx][jy][jp]f32,
    tpsn0: [jx][jy][jp]f32,

    pub fn init() Blk14 {
        return std.mem.zeroInit(Blk14, .{});
    }
};
