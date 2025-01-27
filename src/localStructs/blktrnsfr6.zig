const std = @import("std");
const config = @import("config");

const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blktrnsfr6 = struct {
    rcobbl: [jx][jy][jz]f32,
    rchbbl: [jx][jy][jz]f32,
    roxbbl: [jx][jy][jz]f32,
    rngbbl: [jx][jy][jz]f32,
    rn2bbl: [jx][jy][jz]f32,
    rn3bbl: [jx][jy][jz]f32,
    rnbbbl: [jx][jy][jz]f32,
    rhgbbl: [jx][jy][jz]f32,
    tn3flg: [jx][jy][jz]f32,

    pub fn init() Blktrnsfr6 {
        return std.mem.zeroInit(Blktrnsfr6, .{});
    }
};
