const std = @import("std");

pub const Blk11b = struct {
    zlsgl: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    zhsgl: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    znsgl: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    zosgl: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    posgl: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    ocsgl: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    onsgl: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    opsgl: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    oasgl: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    z2sgl: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zvsgl: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    wgsgl: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    wgsgw: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    wgsgar: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    sco2l: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    soxyl: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    sch4l: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    sn2ol: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    sn2gl: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    snh3l: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    sh2gl: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    psise: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    psisa: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    psiso: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    psish: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    thetx: comptime i32 = 0,
    thetpi: comptime i32 = 0,
    densi: comptime i32 = 0,
    densj: comptime i32 = 0,
    thety: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    thets: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    volq: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    tfnq: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    hgsgl: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    hlsql: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    thawr: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    hthawr: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    flsw: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    flswh: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    hflsw: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    flswr: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    hflswr: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),

    pub fn init() Blk11b {
        return .{};
    }
};
