const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jp = config.pftmax;
const jc = config.canopymax;

pub const Blk1g = struct {
    surf: [jx][jy][jp][jc][25][jz][4]f32,
    surfx: [jx][jy][jp][jc][25][jz][4]f32,
    pardif: [jx][jy][jp][jz][4][4]f32,
    par: [jx][jy][jp][jz][4][4]f32,
    surfb: [jx][jy][jp][jc][jz][4]f32,
    arstk: [jx][jy][jp][jc][jz]f32,
    cfopc: [jx][jy][jp][4][6]f32,
    dmvl: [jx][jy][jp][2]f32,
    rrad1x: [jx][jy][jp][2]f32,
    rrad2x: [jx][jy][jp][2]f32,
    rtar1x: [jx][jy][jp][2]f32,
    rtar2x: [jx][jy][jp][2]f32,
    vcgro: [jx][jy][jp][jc][25]f32,
    vgro: [jx][jy][jp][jc][25]f32,
    compl: [jx][jy][jp][jc][25]f32,
    etgro: [jx][jy][jp][jc][25]f32,
    cbxn: [jx][jy][jp][jc][25]f32,
    cpool3: [jx][jy][jp][jc][25]f32,
    co2b: [jx][jy][jp][jc][25]f32,
    vcgr4: [jx][jy][jp][jc][25]f32,
    vgro4: [jx][jy][jp][jc][25]f32,
    etgr4: [jx][jy][jp][jc][25]f32,
    cbxn4: [jx][jy][jp][jc][25]f32,
    cpool4: [jx][jy][jp][jc][25]f32,
    hcob: [jx][jy][jp][jc][25]f32,
    fdbk4: [jx][jy][jp][jc][25]f32,
    tfn4: [jx][jy][jp][jz]f32,
    flwc: [jx][jy][jp]f32,
    volwc: [jx][jy][jp]f32,
    radc: [jx][jy][jp]f32,
    radp: [jx][jy][jp]f32,
    fradp: [jx][jy][jp]f32,
    arlfp: [jx][jy][jp]f32,
    arstp: [jx][jy][jp]f32,
    arlfs: [jx][jy][jp]f32,
    o2i: [jx][jy][jp]f32,
    co2i: [jx][jy][jp]f32,
    dco2: [jx][jy][jp]f32,
    co2q: [jx][jy][jp]f32,
    co2l: [jx][jy][jp]f32,
    o2l: [jx][jy][jp]f32,
    sco2: [jx][jy][jp]f32,
    so2: [jx][jy][jp]f32,
    xkco2l: [jx][jy][jp]f32,
    xkco2o: [jx][jy][jp]f32,
    tfn3: [jx][jy][jp]f32,
    tcc: [jx][jy][jp]f32,
    tcg: [jx][jy][jp]f32,
    tkc: [jx][jy][jp]f32,
    tkg: [jx][jy][jp]f32,
    dtkc: [jx][jy][jp]f32,
    chill: [jx][jy][jp]f32,
    fmol: [jx][jy][jp]f32,
    zc: [jx][jy][jp]f32,
    fdbk: [jx][jy][jp][jc]f32,
    fdbkx: [jx][jy][jp][jc]f32,

    pub fn init() Blk1g {
        return std.mem.zeroInit(Blk1g, .{});
    }
};
