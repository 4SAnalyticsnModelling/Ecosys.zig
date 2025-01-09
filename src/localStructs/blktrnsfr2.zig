const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blktrnsfr2 = struct {
    rocs2k: [jx][jy][jz + 1][5]f32 = std.mem.zeroes([jx][jy][jz + 1][5]f32),
    rons2k: [jx][jy][jz + 1][5]f32 = std.mem.zeroes([jx][jy][jz + 1][5]f32),
    rops2k: [jx][jy][jz + 1][5]f32 = std.mem.zeroes([jx][jy][jz + 1][5]f32),
    roas2k: [jx][jy][jz + 1][5]f32 = std.mem.zeroes([jx][jy][jz + 1][5]f32),
    rcos2k: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    roxs2k: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rchs2k: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rngs2k: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rn2s2k: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rn4s2k: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rn3s2k: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rnos2k: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rhps2k: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    r4bs2k: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    r3bs2k: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rnbs2k: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rhbs2k: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rnx2k: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rnzs2k: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rhgs2k: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rnhs2k: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    r1ps2k: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),

    pub fn init() Blktrnsfr2 {
        return .{};
    }
};
