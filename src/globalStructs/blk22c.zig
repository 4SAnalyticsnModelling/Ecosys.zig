const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const js = config.snowlayersmax;

pub const Blk22c = struct {
    xmghbs: [jx][jy][js]f32,
    xmgsbs: [jx][jy][js]f32,
    xnacbs: [jx][jy][js]f32,
    xnasbs: [jx][jy][js]f32,
    xkasbs: [jx][jy][js]f32,
    xh0pbs: [jx][jy][js]f32,
    xh3pbs: [jx][jy][js]f32,
    xf1pbs: [jx][jy][js]f32,
    xf2pbs: [jx][jy][js]f32,
    xc0pbs: [jx][jy][js]f32,
    xc1pbs: [jx][jy][js]f32,
    xc2pbs: [jx][jy][js]f32,
    xm1pbs: [jx][jy][js]f32,

    pub fn init() Blk22c {
        return std.mem.zeroInit(Blk22c, .{});
    }
};
