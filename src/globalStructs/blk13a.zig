const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blk13a = struct {
    omc: [jx][jy][jz + 1][6][7][3]f32,
    omn: [jx][jy][jz + 1][6][7][3]f32,
    omp: [jx][jy][jz + 1][6][7][3]f32,
    orc: [jx][jy][jz + 1][5][2]f32,
    orn: [jx][jy][jz + 1][5][2]f32,
    orp: [jx][jy][jz + 1][5][2]f32,
    osc: [jx][jy][jz + 1][5][4]f32,
    osn: [jx][jy][jz + 1][5][4]f32,
    osp: [jx][jy][jz + 1][5][4]f32,
    oqa: [jx][jy][jz + 1][5]f32,
    oqc: [jx][jy][jz + 1][5]f32,
    oqn: [jx][jy][jz + 1][5]f32,
    oqp: [jx][jy][jz + 1][5]f32,
    oqch: [jx][jy][jz + 1][5]f32,
    oqnh: [jx][jy][jz + 1][5]f32,
    oqph: [jx][jy][jz + 1][5]f32,
    oqah: [jx][jy][jz + 1][5]f32,
    oha: [jx][jy][jz + 1][5]f32,
    ohc: [jx][jy][jz + 1][5]f32,
    ohn: [jx][jy][jz + 1][5]f32,
    ohp: [jx][jy][jz + 1][5]f32,
    orgc: [jx][jy][jz + 1]f32,
    znh4fa: [jx][jy][jz + 1]f32,
    znh3fa: [jx][jy][jz + 1]f32,
    znhufa: [jx][jy][jz + 1]f32,
    zno3fa: [jx][jy][jz + 1]f32,
    orgcx: [jx][jy][jz + 1]f32,
    toqck: [jx][jy][jz + 1]f32,
    orgn: [jx][jy][jz + 1]f32,
    orgr: [jx][jy][jz + 1]f32,
    znfni: [jx][jy][jz + 1]f32,
    znfn0: [jx][jy][jz + 1]f32,
    znhui: [jx][jy][jz + 1]f32,
    znhu0: [jx][jy][jz + 1]f32,
    h1po4: [jx][jy][jz + 1]f32,
    h1pob: [jx][jy][jz + 1]f32,
    h1po4h: [jx][jy][jz]f32,
    h1pobh: [jx][jy][jz]f32,
    rc0: [jx][jy][6]f32,

    pub fn init() Blk13a {
        return std.mem.zeroInit(Blk13a, .{});
    }
};
