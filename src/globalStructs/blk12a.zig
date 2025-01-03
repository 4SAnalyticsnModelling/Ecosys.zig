const std = @import("std");

pub const Blk12a = struct {
    wstr: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    ostr: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    rad1: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    thrm1: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    eflxc: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    sflxc: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    hflxc: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    engyx: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    vhcpc: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    psilt: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    psilg: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    psilo: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    rc: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    ra: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    ep: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    evapc: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    upwtr: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    psirt: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    pssrg: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    co2a: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    co2p: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    oxyp: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ch4p: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    upomp: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    upomc: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    upomn: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    uph2p: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    uph1p: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    upnf: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    rco2z: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    roxyz: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    rch4z: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    rn2oz: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),

    pub fn init() Blk12a {
        return .{};
    }
};
