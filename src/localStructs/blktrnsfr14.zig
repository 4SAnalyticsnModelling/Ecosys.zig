const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jh = jx + 1;
const jv = jy + 1;

pub const Blktrnsfr14 = struct {
    volcor: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    volchr: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    voloxr: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    volngr: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    voln2r: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    voln3r: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    volhgr: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    volcoc: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    volcht: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    voloxt: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    volngt: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    voln2t: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    voln3t: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    volnbt: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    volhgt: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rqroc0: [jh][jv][5]f32 = std.mem.zeroes([jh][jv][5]f32),
    rqron0: [jh][jv][5]f32 = std.mem.zeroes([jh][jv][5]f32),
    rqrop0: [jh][jv][5]f32 = std.mem.zeroes([jh][jv][5]f32),
    rqroa0: [jh][jv][5]f32 = std.mem.zeroes([jh][jv][5]f32),
    rqrcos0: [jh][jv]f32 = std.mem.zeroes([jh][jv]f32),
    rqrchs0: [jh][jv]f32 = std.mem.zeroes([jh][jv]f32),
    rqroxs0: [jh][jv]f32 = std.mem.zeroes([jh][jv]f32),
    rqrngs0: [jh][jv]f32 = std.mem.zeroes([jh][jv]f32),
    rqrn2s0: [jh][jv]f32 = std.mem.zeroes([jh][jv]f32),
    rqrhgs0: [jh][jv]f32 = std.mem.zeroes([jh][jv]f32),
    rqrnh40: [jh][jv]f32 = std.mem.zeroes([jh][jv]f32),
    rqrnh30: [jh][jv]f32 = std.mem.zeroes([jh][jv]f32),
    rqrno30: [jh][jv]f32 = std.mem.zeroes([jh][jv]f32),
    rqrno20: [jh][jv]f32 = std.mem.zeroes([jh][jv]f32),
    rqrh2p0: [jh][jv]f32 = std.mem.zeroes([jh][jv]f32),
    rqrh1p0: [jh][jv]f32 = std.mem.zeroes([jh][jv]f32),

    pub fn init() Blktrnsfr14 {
        return .{};
    }
};
