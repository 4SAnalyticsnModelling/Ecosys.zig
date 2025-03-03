const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blktrnsfr8 = struct {
    rcoflz: [jx][jy][jz]f32, // Fortran: RCOFLZ(JZ,JY,JX)
    rchflz: [jx][jy][jz]f32, // Fortran: RCHFLZ(JZ,JY,JX)
    roxflz: [jx][jy][jz]f32, // Fortran: ROXFLZ(JZ,JY,JX)
    rngflz: [jx][jy][jz]f32, // Fortran: RNGFLZ(JZ,JY,JX)
    rn2flz: [jx][jy][jz]f32, // Fortran: RN2FLZ(JZ,JY,JX)
    rn4flz: [jx][jy][jz]f32, // Fortran: RN4FLZ(JZ,JY,JX)
    rn3flz: [jx][jy][jz]f32, // Fortran: RN3FLZ(JZ,JY,JX)
    rnoflz: [jx][jy][jz]f32, // Fortran: RNOFLZ(JZ,JY,JX)
    rh2pfz: [jx][jy][jz]f32, // Fortran: RH2PFZ(JZ,JY,JX)
    rn4fbz: [jx][jy][jz]f32, // Fortran: RN4FBZ(JZ,JY,JX)
    rn3fbz: [jx][jy][jz]f32, // Fortran: RN3FBZ(JZ,JY,JX)
    rnofbz: [jx][jy][jz]f32, // Fortran: RNOFBZ(JZ,JY,JX)
    rh2bbz: [jx][jy][jz]f32, // Fortran: RH2BBZ(JZ,JY,JX)
    rh1pfz: [jx][jy][jz]f32, // Fortran: RH1PFZ(JZ,JY,JX)
    rh1bbz: [jx][jy][jz]f32, // Fortran: RH1BBZ(JZ,JY,JX)

    pub fn init() Blktrnsfr8 {
        return std.mem.zeroInit(Blktrnsfr8, .{});
    }
};
