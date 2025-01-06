const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jc = config.canopymax;

pub const Blk5 = struct {
    beta: [4][4]f32 = std.mem.zeroes([4][4]f32),
    omega: [4][4][4]f32 = std.mem.zeroes([4][4][4]f32),
    betx: [4][4]f32 = std.mem.zeroes([4][4]f32),
    ialby: [4][4][4]i32 = std.mem.zeroes([4][4][4]i32),
    omegx: [4][4][4]f32 = std.mem.zeroes([4][4][4]f32),
    zsin: [4]f32 = std.mem.zeroes([4]f32),
    zcos: [4]f32 = std.mem.zeroes([4]f32),
    tau0: [jx][jy][jc + 1]f32 = std.mem.zeroes([jx][jy][jc + 1]f32),
    taus: [jx][jy][jc + 1]f32 = std.mem.zeroes([jx][jy][jc + 1]f32),
    fradg: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    radg: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    thrmcx: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    thrmgx: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    arlfx: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    arstx: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    cnetx: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    zt: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    zl: [jx][jy][jc + 1]f32 = std.mem.zeroes([jx][jy][jc + 1]f32),

    pub fn init() Blk5 {
        return .{};
    }
};
