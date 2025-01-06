const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jp = config.pftmax;

pub const Blk1u = struct {
    tkcz: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    raz: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    rsmn: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),

    pub fn init() Blk1u {
        return .{};
    }
};