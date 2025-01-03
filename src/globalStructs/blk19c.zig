const std = @import("std");

pub const Blk19c = struct {
    zmgoh: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zmgch: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zmghh: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zmgsh: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    znach: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    znash: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zkash: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    h0po4h: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    h3po4h: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zfe1ph: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zfe2ph: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zca0ph: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zca1ph: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zca2ph: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zmg1ph: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    h0pobh: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    h3pobh: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zfe1bh: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zfe2bh: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zca0bh: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zca1bh: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zca2bh: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zmg1bh: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),

    pub fn init() Blk19c {
        return .{};
    }
};
