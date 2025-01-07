const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;

pub const Blk16 = struct {
    volwso: f32 = 0.0,
    heatso: f32 = 0.0,
    oxygso: f32 = 0.0,
    tlrsdc: f32 = 0.0,
    tlrsdn: f32 = 0.0,
    tlrsdp: f32 = 0.0,
    tlorc: f32 = 0.0,
    tlorgn: f32 = 0.0,
    tlorp: f32 = 0.0,
    tlnh4: f32 = 0.0,
    tlno3: f32 = 0.0,
    tlpo4: f32 = 0.0,
    tbalc: f32 = 0.0,
    tbaln: f32 = 0.0,
    tbalp: f32 = 0.0,
    crain: f32 = 0.0,
    heatin: f32 = 0.0,
    oxygin: f32 = 0.0,
    torgf: f32 = 0.0,
    torgn: f32 = 0.0,
    torgp: f32 = 0.0,
    co2gin: f32 = 0.0,
    zn2gin: f32 = 0.0,
    volwou: f32 = 0.0,
    cevap: f32 = 0.0,
    crun: f32 = 0.0,
    heatou: f32 = 0.0,
    oxygou: f32 = 0.0,
    tcou: f32 = 0.0,
    tzou: f32 = 0.0,
    tpou: f32 = 0.0,
    tzin: f32 = 0.0,
    tpin: f32 = 0.0,
    xcsn: f32 = 0.0,
    xzsn: f32 = 0.0,
    xpsn: f32 = 0.0,
    tlco2g: f32 = 0.0,
    tln2g: f32 = 0.0,
    hco2g: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    hch4g: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    hoxyg: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    hn2og: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    hnh3g: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uraiq: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tomt: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tont: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    topt: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    ursdc: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uorgc: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uorgf: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uxcsn: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uco2s: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udocq: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udocd: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tnbp: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uevap: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    urain: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    urun: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uvolw: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uvolo: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    ursdn: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uorgn: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    ufertn: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uxzsn: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    unh4: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uno3: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    upo4: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udonq: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udond: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udopq: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udopd: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    upp4: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    un2gs: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    ursdp: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uorgp: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    ufertp: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uh2gg: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uxpsn: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    hn2gg: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    un2gg: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uion: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uionou: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uco2g: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uch4g: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uoxyg: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    unh3g: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    un2og: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uco2f: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uch4f: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    uoxyf: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    unh3f: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    un2of: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    upo4f: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udrain: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    zdrain: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    pdrain: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    ucop: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    usedou: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    ppt: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udicq: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udicd: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udinq: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udind: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udipq: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    udipd: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    hvolo: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    wtstgt: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tion: f32 = 0.0,
    tionin: f32 = 0.0,
    tionou: f32 = 0.0,
    tsedso: f32 = 0.0,
    tsedou: f32 = 0.0,
    wqrh: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tlh2g: f32 = 0.0,
    h2gin: f32 = 0.0,
    h2gou: f32 = 0.0,

    pub fn init() Blk16 {
        return .{};
    }
};
