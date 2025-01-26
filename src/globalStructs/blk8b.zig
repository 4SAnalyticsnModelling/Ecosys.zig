const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jh = jx + 1;
const jv = jy + 1;
const jd = jz + 1;

pub const Blk8b = struct {
    dist: [jh][jv][jd][3]f32,
    disp: [jh][jv][jd][3]f32,
    iyty: [jx][jy][366][3]i32,
    dlyr: [jx][jy][jz + 1][3]f32,
    area: [jx][jy][jz + 1][3]f32,
    dlyri: [jx][jy][jz + 1][3]f32,
    xdepth: [jx][jy][jz][3]f32,
    omci: [5][4][3]f32,
    depth: [jx][jy][jz + 1]f32,
    poros: [jx][jy][jz + 1]f32,
    psl: [jx][jy][jz + 1]f32,
    fcl: [jx][jy][jz + 1]f32,
    wpl: [jx][jy][jz + 1]f32,
    psd: [jx][jy][jz + 1]f32,
    fcd: [jx][jy][jz + 1]f32,
    volx: [jx][jy][jz + 1]f32,
    voly: [jx][jy][jz + 1]f32,
    bkvl: [jx][jy][jz + 1]f32,
    srp: [jx][jy][jz + 1]f32,
    tfnd: [jx][jy][jz + 1]f32,
    volai: [jx][jy][jz + 1]f32,
    cdepthz: [jx][jy][jz + 1]f32,
    depthz: [jx][jy][jz]f32,
    sand: [jx][jy][jz]f32,
    silt: [jx][jy][jz]f32,
    clay: [jx][jy][jz]f32,
    albx: [jx][jy]f32,
    poros0: [jx][jy]f32,
    fslope: [jx][jy][2]f32,
    psims: [jx][jy]f32,
    psimx: [jx][jy]f32,
    psimn: [jx][jy]f32,
    psisd: [jx][jy]f32,
    psimd: [jx][jy]f32,
    bkvlnm: [jx][jy]f32,
    bkvlnu: [jx][jy]f32,
    forgc: f32,
    fvlwb: f32,
    fch4f: f32,
    poroq: f32,
    fci: f32,
    wpi: f32,
    oxkm: f32,
    psihy: f32,
    cnrh: [5]f32,
    cprh: [5]f32,
    omcf: [7]f32,
    omca: [7]f32,
    iutyp: [jx][jy]i32,
    ixtyp: [jx][jy][2]i32,

    pub fn init() Blk8b {
        return std.mem.zeroInit(Blk8b, .{});
    }
};
