const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const js = config.snowlayersmax;

pub const Blk11b = struct {
    zlsgl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    zhsgl: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    znsgl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    zosgl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    posgl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    ocsgl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    onsgl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    opsgl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    oasgl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    z2sgl: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zvsgl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    wgsgl: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    wgsgw: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    wgsgar: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    sco2l: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    soxyl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    sch4l: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    sn2ol: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    sn2gl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    snh3l: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    sh2gl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    psise: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    psisa: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    psiso: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    psish: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    thetx: f32 = 0.0,
    thetpi: f32 = 0.0,
    densi: f32 = 0.0,
    densj: f32 = 0.0,
    thety: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    thets: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    volq: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    tfnq: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    hgsgl: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    hlsql: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    thawr: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    hthawr: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    flsw: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    flswh: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    hflsw: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    flswr: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    hflswr: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),

    pub fn init() Blk11b {
        return .{};
    }
};
