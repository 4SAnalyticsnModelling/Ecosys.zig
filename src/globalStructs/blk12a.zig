const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jp = config.pftmax;

pub const Blk12a = struct {
    upwtr: [jx][jy][jp][jz][2]f32,
    psirt: [jx][jy][jp][jz][2]f32,
    pssrg: [jx][jy][jp][jz][2]f32,
    co2a: [jx][jy][jp][jz][2]f32,
    co2p: [jx][jy][jp][jz][2]f32,
    oxyp: [jx][jy][jp][jz][2]f32,
    ch4p: [jx][jy][jp][jz][2]f32,
    wstr: [jx][jy][jp]f32,
    ostr: [jx][jy][jp]f32,
    rad1: [jx][jy][jp]f32,
    thrm1: [jx][jy][jp]f32,
    eflxc: [jx][jy][jp]f32,
    sflxc: [jx][jy][jp]f32,
    hflxc: [jx][jy][jp]f32,
    engyx: [jx][jy][jp]f32,
    vhcpc: [jx][jy][jp]f32,
    psilt: [jx][jy][jp]f32,
    psilg: [jx][jy][jp]f32,
    psilo: [jx][jy][jp]f32,
    rc: [jx][jy][jp]f32,
    ra: [jx][jy][jp]f32,
    ep: [jx][jy][jp]f32,
    evapc: [jx][jy][jp]f32,
    upomp: [jx][jy][jp]f32,
    upomc: [jx][jy][jp]f32,
    upomn: [jx][jy][jp]f32,
    uph2p: [jx][jy][jp]f32,
    uph1p: [jx][jy][jp]f32,
    upnf: [jx][jy][jp]f32,
    rco2z: [jx][jy][jp]f32,
    roxyz: [jx][jy][jp]f32,
    rch4z: [jx][jy][jp]f32,
    rn2oz: [jx][jy][jp]f32,

    pub fn init() Blk12a {
        return std.mem.zeroInit(Blk12a, .{});
    }
};
