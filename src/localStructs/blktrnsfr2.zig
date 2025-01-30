const std = @import("std");
const config = @import("config");

const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blktrnsfr2 = struct {
    rocsk2: [jx][jy][jz + 1][5]f32,
    ronsk2: [jx][jy][jz + 1][5]f32,
    ropsk2: [jx][jy][jz + 1][5]f32,
    roask2: [jx][jy][jz + 1][5]f32,
    rcosk2: [jx][jy][jz + 1]f32,
    roxsk2: [jx][jy][jz + 1]f32,
    rchsk2: [jx][jy][jz + 1]f32,
    rngsk2: [jx][jy][jz + 1]f32,
    rn2sk2: [jx][jy][jz + 1]f32,
    rn4sk2: [jx][jy][jz + 1]f32,
    rn3sk2: [jx][jy][jz + 1]f32,
    rnosk2: [jx][jy][jz + 1]f32,
    rhpsk2: [jx][jy][jz + 1]f32,
    rnxsk2: [jx][jy][jz + 1]f32,
    rhgsk2: [jx][jy][jz + 1]f32,
    rnhsk2: [jx][jy][jz + 1]f32,
    r1psk2: [jx][jy][jz + 1]f32,
    r4bsk2: [jx][jy][jz]f32,
    r3bsk2: [jx][jy][jz]f32,
    rnbsk2: [jx][jy][jz]f32,
    rhbsk2: [jx][jy][jz]f32,
    rnzsk2: [jx][jy][jz]f32,

    pub fn init() Blktrnsfr2 {
        return std.mem.zeroInit(Blktrnsfr2, .{});
    }
};
