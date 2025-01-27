const std = @import("std");
const config = @import("config");

const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jh = jx + 1;
const jv = jy + 1;
const jd = jz + 1;

pub const Blktrnsfr12 = struct {
    flqm: [jh][jv][jd][3]f32,
    rhgfhs: [jh][jv][jd][3]f32,
    rhgflg: [jh][jv][jd][3]f32,
    dch4g: [jx][jy][jz][3]f32,
    dco2g: [jx][jy][jz][3]f32,
    dh2gg: [jx][jy][jz][3]f32,
    dnh3g: [jx][jy][jz][3]f32,
    doxyg: [jx][jy][jz][3]f32,
    dz2gg: [jx][jy][jz][3]f32,
    dz2og: [jx][jy][jz][3]f32,
    h2gs2: [jx][jy][jz + 1]f32,
    rhgdfg: [jx][jy][jz + 1]f32,
    volwco: [jx][jy][jz + 1]f32,
    volwch: [jx][jy][jz + 1]f32,
    volwox: [jx][jy][jz + 1]f32,
    volwng: [jx][jy][jz + 1]f32,
    volwn2: [jx][jy][jz + 1]f32,
    volwn3: [jx][jy][jz + 1]f32,
    volwnb: [jx][jy][jz + 1]f32,
    volwhg: [jx][jy][jz + 1]f32,
    volwxa: [jx][jy][jz + 1]f32,
    flvm: [jx][jy][jz]f32,
    h2gg2: [jx][jy][jz]f32,
    h2gsh2: [jx][jy][jz]f32,
    hgsgl2: [jx][jy][jz]f32,
    rhgfxs: [jx][jy][jz]f32,
    rhgflz: [jx][jy][jz]f32,
    theth2: [jx][jy][jz]f32,
    thethl: [jx][jy][jz]f32,
    thetw1: [jx][jy][jz]f32,
    thgflg: [jx][jy][jz]f32,
    thgfls: [jx][jy][jz]f32,
    thgfhs: [jx][jy][jz]f32,
    volpma: [jx][jy][jz]f32,
    volpmb: [jx][jy][jz]f32,
    volwma: [jx][jy][jz]f32,
    volwmb: [jx][jy][jz]f32,
    volwxb: [jx][jy][jz]f32,
    pargch: [jy][jx]f32,
    pargco: [jy][jx]f32,
    pargh2: [jy][jx]f32,
    pargn2: [jy][jx]f32,
    pargn3: [jy][jx]f32,
    pargng: [jy][jx]f32,
    pargox: [jy][jx]f32,

    pub fn init() Blktrnsfr12 {
        return std.mem.zeroInit(Blktrnsfr12, .{});
    }
};
