const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blktrnsfr6 = struct {
    tn3flg: [jx][jy][jz]f32, // Fortran: TN3FLG(JZ,JY,JX)
    rcobbl: [jx][jy][jz]f32, // Fortran: RCOBBL(JZ,JY,JX)
    rchbbl: [jx][jy][jz]f32, // Fortran: RCHBBL(JZ,JY,JX)
    roxbbl: [jx][jy][jz]f32, // Fortran: ROXBBL(JZ,JY,JX)
    rngbbl: [jx][jy][jz]f32, // Fortran: RNGBBL(JZ,JY,JX)
    rn2bbl: [jx][jy][jz]f32, // Fortran: RN2BBL(JZ,JY,JX)
    rn3bbl: [jx][jy][jz]f32, // Fortran: RN3BBL(JZ,JY,JX)
    rnbbbl: [jx][jy][jz]f32, // Fortran: RNBBBL(JZ,JY,JX)
    rhgbbl: [jx][jy][jz]f32, // Fortran: RHGBBL(JZ,JY,JX)

    pub fn init() Blktrnsfr6 {
        return std.mem.zeroInit(Blktrnsfr6, .{});
    }
};
