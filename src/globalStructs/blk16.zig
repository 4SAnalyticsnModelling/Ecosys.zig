const std = @import("std");

pub const Blk16 = struct {
    volwso: comptime f32 = 0,
    heatso: comptime f32 = 0,
    oxygso: comptime f32 = 0,
    tlrsdc: comptime f32 = 0,
    tlrsdn: comptime f32 = 0,
    tlrsdp: comptime f32 = 0,
    tlorc: comptime f32 = 0,
    tlorgn: comptime f32 = 0,
    tlorp: comptime f32 = 0,
    tlnh4: comptime f32 = 0,
    tlno3: comptime f32 = 0,
    tlpo4: comptime f32 = 0,
    tbalc: comptime f32 = 0,
    tbaln: comptime f32 = 0,
    tbalp: comptime f32 = 0,
    crain: comptime f32 = 0,
    heatin: comptime f32 = 0,
    oxygin: comptime f32 = 0,
    torgf: comptime f32 = 0,
    torgn: comptime f32 = 0,
    torgp: comptime f32 = 0,
    co2gin: comptime f32 = 0,
    zn2gin: comptime f32 = 0,
    volwou: comptime f32 = 0,
    cevap: comptime f32 = 0,
    crun: comptime f32 = 0,
    heatou: comptime f32 = 0,
    oxygou: comptime f32 = 0,
    tcou: comptime f32 = 0,
    tzou: comptime f32 = 0,
    tpou: comptime f32 = 0,
    tzin: comptime f32 = 0,
    tpin: comptime f32 = 0,
    xcsn: comptime f32 = 0,
    xzsn: comptime f32 = 0,
    xpsn: comptime f32 = 0,
    tlco2g: comptime f32 = 0,
    tln2g: comptime f32 = 0,
    hco2g: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    hch4g: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    hoxyg: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    hn2og: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    hnh3g: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uraiq: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tomt: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tont: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    topt: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    ursdc: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uorgc: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uorgf: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uxcsn: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uco2s: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udocq: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udocd: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tnbp: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uevap: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    urain: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    urun: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uvolw: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uvolo: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    ursdn: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uorgn: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    ufertn: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uxzsn: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    unh4: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uno3: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    upo4: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udonq: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udond: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udopq: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udopd: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    upp4: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    un2gs: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    ursdp: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uorgp: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    ufertp: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uh2gg: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uxpsn: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    hn2gg: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    un2gg: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uion: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uionou: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uco2g: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uch4g: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uoxyg: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    unh3g: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    un2og: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uco2f: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uch4f: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uoxyf: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    unh3f: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    un2of: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    upo4f: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udrain: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    zdrain: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    pdrain: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    ucop: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    usedou: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    ppt: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udicq: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udicd: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udinq: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udind: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udipq: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udipd: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    hvolo: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    wtstgt: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tion: comptime f32 = 0,
    tionin: comptime f32 = 0,
    tionou: comptime f32 = 0,
    tsedso: comptime f32 = 0,
    tsedou: comptime f32 = 0,
    wqrh: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tlh2g: comptime f32 = 0,
    h2gin: comptime f32 = 0,
    h2gou: comptime f32 = 0,

    pub fn init() Blk16 {
        return .{};
    }
};
