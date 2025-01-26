const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const js = config.snowlayersmax;

pub const Blk11a = struct {
    heati: [jx][jy]i32,
    heate: [jx][jy]i32,
    bare: [jx][jy]f32,
    cvrd: [jx][jy]f32,
    rac: [jx][jy]f32,
    volr: [jx][jy]f32,
    volwg: [jx][jy]f32,
    tvolwc: [jx][jy]f32,
    volss: [jx][jy]f32,
    volws: [jx][jy]f32,
    volis: [jx][jy]f32,
    vols: [jx][jy]f32,
    heats: [jx][jy]f32,
    tcs: [jx][jy][jz + 1]f32,
    tks: [jx][jy][jz + 1]f32,
    tsmx: [jx][jy][jz + 1]f32,
    tsmn: [jx][jy][jz + 1]f32,
    vhcp: [jx][jy][jz + 1]f32,
    volw: [jx][jy][jz + 1]f32,
    voli: [jx][jy][jz + 1]f32,
    volp: [jx][jy][jz + 1]f32,
    volt: [jx][jy][jz + 1]f32,
    volti: [jx][jy][jz + 1]f32,
    thetw: [jx][jy][jz + 1]f32,
    theti: [jx][jy][jz + 1]f32,
    volwh: [jx][jy][jz]f32,
    tcw: [jx][jy][js]f32,
    tkw: [jx][jy][js]f32,
    vhcpw: [jx][jy][js]f32,
    volssl: [jx][jy][js]f32,
    volwsl: [jx][jy][js]f32,
    volisl: [jx][jy][js]f32,
    volsl: [jx][jy][js]f32,

    pub fn init() Blk11a {
        return std.mem.zeroInit(Blk11a, .{});
    }
};
