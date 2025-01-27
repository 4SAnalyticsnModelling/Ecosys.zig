const std = @import("std");
const config = @import("config");

const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blktrnsfr9 = struct {
    rocfxs: [jx][jy][jz][5]f32,
    ronfxs: [jx][jy][jz][5]f32,
    ropfxs: [jx][jy][jz][5]f32,
    roafxs: [jx][jy][jz][5]f32,
    rcofxs: [jx][jy][jz]f32,
    rchfxs: [jx][jy][jz]f32,
    roxfxs: [jx][jy][jz]f32,
    rngfxs: [jx][jy][jz]f32,
    rn2fxs: [jx][jy][jz]f32,
    rn4fxw: [jx][jy][jz]f32,
    rn3fxw: [jx][jy][jz]f32,
    rnofxw: [jx][jy][jz]f32,
    rh2pxs: [jx][jy][jz]f32,
    rn4fxb: [jx][jy][jz]f32,
    rn3fxb: [jx][jy][jz]f32,
    rnofxb: [jx][jy][jz]f32,
    rh2bxb: [jx][jy][jz]f32,
    rnxfxs: [jx][jy][jz]f32,
    rnxfxb: [jx][jy][jz]f32,
    rh1pxs: [jx][jy][jz]f32,
    rh1bxb: [jx][jy][jz]f32,

    pub fn init() Blktrnsfr9 {
        return std.mem.zeroInit(Blktrnsfr9, .{});
    }
};
