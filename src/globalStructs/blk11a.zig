const std = @import("std");

pub const Blk11a = struct {
    bare: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    cvrd: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tcs: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    tks: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    tcw: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    tkw: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    rac: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tsmx: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    tsmn: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    vhcp: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    vhcpw: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    volw: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    voli: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    volp: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    volwh: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    volt: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    volti: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    volr: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    volwg: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tvolwc: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    volssl: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    volwsl: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    volisl: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    volsl: comptime [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    volss: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    volws: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    volis: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    vols: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    thetw: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    theti: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    heati: comptime [jx][jy]i32 = std.mem.zeroes([jx][jy]i32),
    heate: comptime [jx][jy]i32 = std.mem.zeroes([jx][jy]i32),
    heats: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),

    pub fn init() Blk11a {
        return .{};
    }
};
