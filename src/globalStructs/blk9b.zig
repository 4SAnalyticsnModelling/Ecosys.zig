const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jp = config.pftmax;

pub const Blk9b = struct {
    offst: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    rrad1m: [jx][jy][jp][2]f32 = std.mem.zeroes([jx][jy][jp][2]f32),
    rrad2m: [jx][jy][jp][2]f32 = std.mem.zeroes([jx][jy][jp][2]f32),
    tcz: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    port: [jx][jy][jp][2]f32 = std.mem.zeroes([jx][jy][jp][2]f32),
    pr: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    rsrr: [jx][jy][jp][2]f32 = std.mem.zeroes([jx][jy][jp][2]f32),
    rsra: [jx][jy][jp][2]f32 = std.mem.zeroes([jx][jy][jp][2]f32),
    ptsht: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    upmxzh: [jx][jy][jp][2]f32 = std.mem.zeroes([jx][jy][jp][2]f32),
    upkmzh: [jx][jy][jp][2]f32 = std.mem.zeroes([jx][jy][jp][2]f32),
    upmnzh: [jx][jy][jp][2]f32 = std.mem.zeroes([jx][jy][jp][2]f32),
    upmxzo: [jx][jy][jp][2]f32 = std.mem.zeroes([jx][jy][jp][2]f32),
    upkmzo: [jx][jy][jp][2]f32 = std.mem.zeroes([jx][jy][jp][2]f32),
    upmnzo: [jx][jy][jp][2]f32 = std.mem.zeroes([jx][jy][jp][2]f32),
    upmxpo: [jx][jy][jp][2]f32 = std.mem.zeroes([jx][jy][jp][2]f32),
    upkmpo: [jx][jy][jp][2]f32 = std.mem.zeroes([jx][jy][jp][2]f32),
    upmnpo: [jx][jy][jp][2]f32 = std.mem.zeroes([jx][jy][jp][2]f32),
    rradp: [jx][jy][jp][2]f32 = std.mem.zeroes([jx][jy][jp][2]f32),
    cnrts: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    cprts: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    albr: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    albp: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    taur: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    taup: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    absr: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    absp: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    tcx: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    ztypi: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    tczd: f32 = 0.0,
    tcxd: f32 = 0.0,
    ztyp: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    ictyp: [jx][jy][jp]i32 = std.mem.zeroes([jx][jy][jp]i32),
    igtyp: [jx][jy][jp]i32 = std.mem.zeroes([jx][jy][jp]i32),
    istyp: [jx][jy][jp]i32 = std.mem.zeroes([jx][jy][jp]i32),
    idtyp: [jx][jy][jp]i32 = std.mem.zeroes([jx][jy][jp]i32),
    nnod: [jx][jy][jp]i32 = std.mem.zeroes([jx][jy][jp]i32),
    intyp: [jx][jy][jp]i32 = std.mem.zeroes([jx][jy][jp]i32),
    iwtyp: [jx][jy][jp]i32 = std.mem.zeroes([jx][jy][jp]i32),
    iptyp: [jx][jy][jp]i32 = std.mem.zeroes([jx][jy][jp]i32),
    ibtyp: [jx][jy][jp]i32 = std.mem.zeroes([jx][jy][jp]i32),
    irtyp: [jx][jy][jp]i32 = std.mem.zeroes([jx][jy][jp]i32),
    my: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),

    pub fn init() Blk9b {
        return .{};
    }
};
