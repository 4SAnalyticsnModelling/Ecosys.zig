const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blk13b = struct {
    osa: [jx][jy][jz + 1][5][4]f32,
    roqcs: [jx][jy][jz + 1][5][7]f32,
    roqas: [jx][jy][jz + 1][5][7]f32,
    xno2s: [jx][jy][jz + 1]f32,
    cnh4s: [jx][jy][jz + 1]f32,
    cnh3s: [jx][jy][jz + 1]f32,
    cno3s: [jx][jy][jz + 1]f32,
    cno2s: [jx][jy][jz + 1]f32,
    cnh4b: [jx][jy][jz + 1]f32,
    cnh3b: [jx][jy][jz + 1]f32,
    cno3b: [jx][jy][jz + 1]f32,
    cpo4b: [jx][jy][jz + 1]f32,
    cnh3g: [jx][jy][jz + 1]f32,
    cz2gg: [jx][jy][jz + 1]f32,
    cz2gs: [jx][jy][jz + 1]f32,
    cz2og: [jx][jy][jz + 1]f32,
    cz2os: [jx][jy][jz + 1]f32,
    oxys: [jx][jy][jz + 1]f32,
    co2s: [jx][jy][jz + 1]f32,
    ch4s: [jx][jy][jz + 1]f32,
    coxyf: [jx][jy][jz + 1]f32,
    cch4g: [jx][jy][jz + 1]f32,
    coxys: [jx][jy][jz + 1]f32,
    cco2g: [jx][jy][jz + 1]f32,
    cco2s: [jx][jy][jz + 1]f32,
    cch4s: [jx][jy][jz + 1]f32,
    rupoxo: [jx][jy][jz + 1]f32,
    rco2o: [jx][jy][jz + 1]f32,
    rch4o: [jx][jy][jz + 1]f32,
    rh2go: [jx][jy][jz + 1]f32,
    rn2g: [jx][jy][jz + 1]f32,
    rn2o: [jx][jy][jz + 1]f32,
    oxyg: [jx][jy][jz]f32,
    co2g: [jx][jy][jz]f32,
    ch4g: [jx][jy][jz]f32,
    oxysh: [jx][jy][jz]f32,
    co2sh: [jx][jy][jz]f32,
    ch4sh: [jx][jy][jz]f32,
    cpo4s: [jx][jy][jz]f32,

    pub fn init() Blk13b {
        return std.mem.zeroInit(Blk13b, .{});
    }
};
