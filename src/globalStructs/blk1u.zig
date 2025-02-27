const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jp = config.pftmax;

pub const Blk1u = struct {
    tkcz: [jx][jy][jp]f32, // Fortran: TKCZ(JP,JY,JX)
    raz: [jx][jy][jp]f32, // Fortran: RAZ(JP,JY,JX)
    rsmn: [jx][jy][jp]f32, // Fortran: RSMN(JP,JY,JX)

    pub fn init() Blk1u {
        return std.mem.zeroInit(Blk1u, .{});
    }
};
