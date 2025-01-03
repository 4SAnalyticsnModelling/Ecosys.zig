const std = @import("std");

pub const Blk5 = struct {
    beta: comptime [4][4]f32 = std.mem.zeroes([4][4]f32),
    omega: comptime [4][4][4]f32 = std.mem.zeroes([4][4][4]f32),
    betx: comptime [4][4]f32 = std.mem.zeroes([4][4]f32),
    ialby: comptime [4][4][4]i32 = std.mem.zeroes([4][4][4]i32),
    omegx: comptime [4][4][4]f32 = std.mem.zeroes([4][4][4]f32),
    zsin: comptime [4]f32 = std.mem.zeroes([4]f32),
    zcos: comptime [4]f32 = std.mem.zeroes([4]f32),
    tau0: comptime [jx][jy][jc + 1]f32 = std.mem.zeroes([jx][jy][jc + 1]f32),
    taus: comptime [jx][jy][jc + 1]f32 = std.mem.zeroes([jx][jy][jc + 1]f32),
    fradg: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    radg: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    thrmcx: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    thrmgx: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    arlfx: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    arstx: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    cnetx: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    zt: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    zl: comptime [jx][jy][jc + 1]f32 = std.mem.zeroes([jx][jy][jc + 1]f32),

    pub fn init() Blk5 {
        return .{};
    }
};
