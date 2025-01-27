const std = @import("std");
const config = @import("config");

const jx = config.ewgridsmax;
const jy = config.nsgridsmax;

pub const Blktrnsfr13 = struct {
    rocfl0: [jx][jy][3]f32,
    ronfl0: [jx][jy][3]f32,
    ropfl0: [jx][jy][3]f32,
    roafl0: [jx][jy][3]f32,
    rocfl1: [jx][jy][3]f32,
    ronfl1: [jx][jy][3]f32,
    ropfl1: [jx][jy][3]f32,
    roafl1: [jx][jy][3]f32,
    rcofl0: [jx][jy]f32,
    rchfl0: [jx][jy]f32,
    roxfl0: [jx][jy]f32,
    rngfl0: [jx][jy]f32,
    rn2fl0: [jx][jy]f32,
    rhgfl0: [jx][jy]f32,
    rn4fl0: [jx][jy]f32,
    rn3fl0: [jx][jy]f32,
    rnofl0: [jx][jy]f32,
    rnxfl0: [jx][jy]f32,
    rh2pf0: [jx][jy]f32,
    rcofl1: [jx][jy]f32,
    rchfl1: [jx][jy]f32,
    roxfl1: [jx][jy]f32,
    rngfl1: [jx][jy]f32,
    rn2fl1: [jx][jy]f32,
    rhgfl1: [jx][jy]f32,
    rn4fl1: [jx][jy]f32,
    rn3fl1: [jx][jy]f32,
    rnofl1: [jx][jy]f32,
    rnxfl1: [jx][jy]f32,
    rh2pf1: [jx][jy]f32,
    rn4fl2: [jx][jy]f32,
    rn3fl2: [jx][jy]f32,
    rnofl2: [jx][jy]f32,
    rnxfl2: [jx][jy]f32,
    rh2bf2: [jx][jy]f32,
    rh1pf0: [jx][jy]f32,
    rh1pf1: [jx][jy]f32,
    rh1bf2: [jx][jy]f32,

    pub fn init() Blktrnsfr13 {
        return std.mem.zeroInit(Blktrnsfr13, .{});
    }
};
