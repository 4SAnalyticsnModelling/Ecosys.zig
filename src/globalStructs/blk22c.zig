const std = @import("std");

pub const Blk22c = struct {
    xmghbs: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xmgsbs: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xnacbs: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xnasbs: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xkasbs: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xh0pbs: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xh3pbs: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xf1pbs: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xf2pbs: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xc0pbs: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xc1pbs: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xc2pbs: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xm1pbs: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),

    pub fn init() Blk22c {
        return .{};
    }
};
