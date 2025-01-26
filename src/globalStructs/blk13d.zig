const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blk13d = struct {
    coqc: [jx][jy][jz + 1][5]f32,
    coqa: [jx][jy][jz + 1][5]f32,
    fosrh: [jx][jy][jz + 1][5]f32,

    pub fn init() Blk13d {
        return std.mem.zeroInit(Blk13d, .{});
    }
};
