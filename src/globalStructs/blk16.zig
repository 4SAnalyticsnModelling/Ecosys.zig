const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;

pub const Blk16 = struct {
    hco2g: [jx][jy]f32,
    hch4g: [jx][jy]f32,
    hoxyg: [jx][jy]f32,
    hn2og: [jx][jy]f32,
    hnh3g: [jx][jy]f32,
    uraiq: [jx][jy]f32,
    tomt: [jx][jy]f32,
    tont: [jx][jy]f32,
    topt: [jx][jy]f32,
    ursdc: [jx][jy]f32,
    uorgc: [jx][jy]f32,
    uorgf: [jx][jy]f32,
    uxcsn: [jx][jy]f32,
    uco2s: [jx][jy]f32,
    udocq: [jx][jy]f32,
    udocd: [jx][jy]f32,
    tnbp: [jx][jy]f32,
    uevap: [jx][jy]f32,
    urain: [jx][jy]f32,
    urun: [jx][jy]f32,
    uvolw: [jx][jy]f32,
    uvolo: [jx][jy]f32,
    ursdn: [jx][jy]f32,
    uorgn: [jx][jy]f32,
    ufertn: [jx][jy]f32,
    uxzsn: [jx][jy]f32,
    unh4: [jx][jy]f32,
    uno3: [jx][jy]f32,
    upo4: [jx][jy]f32,
    udonq: [jx][jy]f32,
    udond: [jx][jy]f32,
    udopq: [jx][jy]f32,
    udopd: [jx][jy]f32,
    upp4: [jx][jy]f32,
    un2gs: [jx][jy]f32,
    ursdp: [jx][jy]f32,
    uorgp: [jx][jy]f32,
    ufertp: [jx][jy]f32,
    uh2gg: [jx][jy]f32,
    uxpsn: [jx][jy]f32,
    hn2gg: [jx][jy]f32,
    un2gg: [jx][jy]f32,
    uion: [jx][jy]f32,
    uionou: [jx][jy]f32,
    uco2g: [jx][jy]f32,
    uch4g: [jx][jy]f32,
    uoxyg: [jx][jy]f32,
    unh3g: [jx][jy]f32,
    un2og: [jx][jy]f32,
    uco2f: [jx][jy]f32,
    uch4f: [jx][jy]f32,
    uoxyf: [jx][jy]f32,
    unh3f: [jx][jy]f32,
    un2of: [jx][jy]f32,
    upo4f: [jx][jy]f32,
    udrain: [jx][jy]f32,
    zdrain: [jx][jy]f32,
    pdrain: [jx][jy]f32,
    ucop: [jx][jy]f32,
    usedou: [jx][jy]f32,
    ppt: [jx][jy]f32,
    udicq: [jx][jy]f32,
    udicd: [jx][jy]f32,
    udinq: [jx][jy]f32,
    udind: [jx][jy]f32,
    udipq: [jx][jy]f32,
    udipd: [jx][jy]f32,
    hvolo: [jx][jy]f32,
    wtstgt: [jx][jy]f32,
    wqrh: [jx][jy]f32,
    volwso: f32,
    heatso: f32,
    oxygso: f32,
    tlrsdc: f32,
    tlrsdn: f32,
    tlrsdp: f32,
    tlorc: f32,
    tlorgn: f32,
    tlorp: f32,
    tlnh4: f32,
    tlno3: f32,
    tlpo4: f32,
    tbalc: f32,
    tbaln: f32,
    tbalp: f32,
    crain: f32,
    heatin: f32,
    oxygin: f32,
    torgf: f32,
    torgn: f32,
    torgp: f32,
    co2gin: f32,
    zn2gin: f32,
    volwou: f32,
    cevap: f32,
    crun: f32,
    heatou: f32,
    oxygou: f32,
    tcou: f32,
    tzou: f32,
    tpou: f32,
    tzin: f32,
    tpin: f32,
    xcsn: f32,
    xzsn: f32,
    xpsn: f32,
    tlco2g: f32,
    tln2g: f32,
    tlh2g: f32,
    h2gin: f32,
    h2gou: f32,
    tsedso: f32,
    tsedou: f32,
    tion: f32,
    tionin: f32,
    tionou: f32,

    pub fn init() Blk16 {
        return std.mem.zeroInit(Blk16, .{});
    }
};
