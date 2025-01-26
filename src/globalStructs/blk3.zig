const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jp = config.pftmax;
const jc = config.canopymax;

pub const Blk3 = struct {
    iday: [jx][jy][jp][jc][10]i32,
    group: [jx][jy][jp][jc]f32,
    gstgi: [jx][jy][jp][jc]f32,
    vstg: [jx][jy][jp][jc]f32,
    vstgx: [jx][jy][jp][jc]f32,
    dgstgi: [jx][jy][jp][jc]f32,
    dgstgf: [jx][jy][jp][jc]f32,
    pstg: [jx][jy][jp][jc]f32,
    pstgi: [jx][jy][jp][jc]f32,
    gstgf: [jx][jy][jp][jc]f32,
    pstgf: [jx][jy][jp][jc]f32,
    tgstgi: [jx][jy][jp][jc]f32,
    tgstgf: [jx][jy][jp][jc]f32,
    flg4: [jx][jy][jp][jc]f32,
    vrns: [jx][jy][jp][jc]f32,
    vrnf: [jx][jy][jp][jc]f32,
    atrp: [jx][jy][jp][jc]f32,
    flgz: [jx][jy][jp][jc]f32,
    vrny: [jx][jy][jp][jc]f32,
    vrnz: [jx][jy][jp][jc]f32,
    kvstgn: [jx][jy][jp][jc]i32,
    nbtb: [jx][jy][jp][jc]i32,
    ninr: [jx][jy][jp][jc]i32,
    kleaf: [jx][jy][jp][jc]i32,
    iflgr: [jx][jy][jp][jc]i32,
    iflgq: [jx][jy][jp][jc]i32,
    iflgg: [jx][jy][jp][jc]i32,
    kvstg: [jx][jy][jp][jc]i32,
    idthb: [jx][jy][jp][jc]i32,
    iflgp: [jx][jy][jp][jc]i32,
    iflga: [jx][jy][jp][jc]i32,
    iflge: [jx][jy][jp][jc]i32,
    iflgf: [jx][jy][jp][jc]i32,
    kleafx: [jx][jy][jp][jc]i32,
    psilz: [jx][jy][jp]f32,
    nbr: [jx][jy][jp]i32,
    nb1: [jx][jy][jp]i32,
    nrt: [jx][jy][jp]i32,
    nbt: [jx][jy][jp]i32,
    idthr: [jx][jy][jp]i32,
    idthp: [jx][jy][jp]i32,
    nix: [jx][jy][jp]i32,
    ni: [jx][jy][jp]i32,
    ng: [jx][jy][jp]i32,

    pub fn init() Blk3 {
        return std.mem.zeroInit(Blk3, .{});
    }
};
