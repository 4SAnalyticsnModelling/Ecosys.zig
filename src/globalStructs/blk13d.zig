const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blk13d = struct {
    coqc: [jx][jy][jz + 1][5]f32, // Fortran: COQC(0:4,0:JZ,JY,JX)
    coqa: [jx][jy][jz + 1][5]f32, // Fortran: COQA(0:4,0:JZ,JY,JX)
    fosrh: [jx][jy][jz + 1][5]f32, // Fortran: FOSRH(0:4,0:JZ,JY,JX)

    pub fn init() Blk13d {
        return std.mem.zeroInit(Blk13d, .{});
    }
};
