const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blk19c = struct {
    zmgoh: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zmgch: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zmghh: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zmgsh: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    znach: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    znash: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zkash: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    h0po4h: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    h3po4h: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zfe1ph: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zfe2ph: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zca0ph: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zca1ph: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zca2ph: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zmg1ph: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    h0pobh: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    h3pobh: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zfe1bh: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zfe2bh: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zca0bh: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zca1bh: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zca2bh: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zmg1bh: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),

    pub fn init() Blk19c {
        return .{};
    }
};
