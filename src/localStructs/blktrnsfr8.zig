const std = @import("std");
const config = @import("config");

const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blktrnsfr8 = struct {
    rchflz: [jx][jy][jz]f32,
    rcoflz: [jx][jy][jz]f32,
    rh1bbz: [jx][jy][jz]f32,
    rh1pfz: [jx][jy][jz]f32,
    rh2bbz: [jx][jy][jz]f32,
    rh2pfz: [jx][jy][jz]f32,
    rngflz: [jx][jy][jz]f32,
    rn2flz: [jx][jy][jz]f32,
    rn3fbz: [jx][jy][jz]f32,
    rn3flz: [jx][jy][jz]f32,
    rn4fbz: [jx][jy][jz]f32,
    rn4flz: [jx][jy][jz]f32,
    rnofbz: [jx][jy][jz]f32,
    rnoflz: [jx][jy][jz]f32,
    roxflz: [jx][jy][jz]f32,

    pub fn init() Blktrnsfr8 {
        return std.mem.zeroInit(Blktrnsfr8, .{});
    }
};
