const std = @import("std");

pub const Blk18b = struct {
    roxyx: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    roxyy: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rnh4x: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rnh4y: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rno3x: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rno3y: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rno2x: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rno2y: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rpo4x: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rpo4y: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rn2ox: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rn2oy: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rnhbx: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rnhby: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rn3bx: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rn3by: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rn2bx: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rn2by: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rpobx: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rpoby: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    roqcx: comptime [jx][jy][jz + 1][5]f32 = std.mem.zeroes([jx][jy][jz + 1][5]f32),
    roqcy: comptime [jx][jy][jz + 1][5]f32 = std.mem.zeroes([jx][jy][jz + 1][5]f32),
    roqax: comptime [jx][jy][jz + 1][5]f32 = std.mem.zeroes([jx][jy][jz + 1][5]f32),
    roqay: comptime [jx][jy][jz + 1][5]f32 = std.mem.zeroes([jx][jy][jz + 1][5]f32),
    th2gz: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tuphgs: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    thgfla: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tlh2gp: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tcan: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    trn: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tle: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tsh: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tgh: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tgpp: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    trau: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tnpp: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    thre: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    xhvstc: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    xhvstn: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    xhvstp: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rp14x: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rp14y: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rp1bx: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rp1by: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    iflgt: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    trinh4: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    tripo4: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),

    pub fn init() Blk18b {
        return .{};
    }
};
