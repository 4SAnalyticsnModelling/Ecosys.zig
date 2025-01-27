const std = @import("std");
const config = @import("config");

const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const js = config.snowlayersmax;

pub const Blktrnsfr10 = struct {
    rcobls: [jx][jy][js]f32,
    rchbls: [jx][jy][js]f32,
    roxbls: [jx][jy][js]f32,
    rngbls: [jx][jy][js]f32,
    rn2bls: [jx][jy][js]f32,
    rn4blw: [jx][jy][js]f32,
    rn3blw: [jx][jy][js]f32,
    rnoblw: [jx][jy][js]f32,
    rh1pbs: [jx][jy][js]f32,
    rh2pbs: [jx][jy][js]f32,
    tcobls: [jx][jy][js]f32,
    tchbls: [jx][jy][js]f32,
    toxbls: [jx][jy][js]f32,
    tngbls: [jx][jy][js]f32,
    tn2bls: [jx][jy][js]f32,
    tn4blw: [jx][jy][js]f32,
    tn3blw: [jx][jy][js]f32,
    tnoblw: [jx][jy][js]f32,
    th1pbs: [jx][jy][js]f32,
    th2pbs: [jx][jy][js]f32,

    pub fn init() Blktrnsfr10 {
        return std.mem.zeroInit(Blktrnsfr10, .{});
    }
};
