const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jp = config.pftmax;
const jc = config.canopymax;

pub const Blk12b = struct {
    rupnh4: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rupnhb: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rupno3: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rupnob: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ruph2p: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ruph2b: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ruonh4: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ruonhb: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ruono3: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ruonob: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ruoh2p: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ruoh2b: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rucnh4: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rucnhb: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rucno3: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rucnob: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ruch2p: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ruch2b: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rupnf: [jx][jy][jp][jz]f32 = std.mem.zeroes([jx][jy][jp][jz]f32),
    ruphgs: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ruph1p: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ruoh1p: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ruch1p: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ruph1b: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ruoh1b: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ruch1b: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    volwp: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    rco2n: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rdfomc: [jx][jy][jp][jz][5][2]f32 = std.mem.zeroes([jx][jy][jp][jz][5][2]f32),
    rdfomn: [jx][jy][jp][jz][5][2]f32 = std.mem.zeroes([jx][jy][jp][jz][5][2]f32),
    rdfomp: [jx][jy][jp][jz][5][2]f32 = std.mem.zeroes([jx][jy][jp][jz][5][2]f32),
    runnhp: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    runnop: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rupp2p: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    runnbp: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    runnxp: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rupp2b: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rnh3z: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    rnh3b: [jx][jy][jc][jp]f32 = std.mem.zeroes([jx][jy][jc][jp]f32),
    wfr: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rhgfla: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rhgdfa: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    h2ga: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    h2gp: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rh2gz: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    rupp1p: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    rupp1b: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),

    pub fn init() Blk12b {
        return .{};
    }
};
