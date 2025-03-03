const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;

pub const Blktrnsfr13 = struct {
    rocfl0: [jx][jy][3]f32, // Fortran: ROCFL0(0:2,JY,JX)
    ronfl0: [jx][jy][3]f32, // Fortran: RONFL0(0:2,JY,JX)
    ropfl0: [jx][jy][3]f32, // Fortran: ROPFL0(0:2,JY,JX)
    roafl0: [jx][jy][3]f32, // Fortran: ROAFL0(0:2,JY,JX)
    rocfl1: [jx][jy][3]f32, // Fortran: ROCFL1(0:2,JY,JX)
    ronfl1: [jx][jy][3]f32, // Fortran: RONFL1(0:2,JY,JX)
    ropfl1: [jx][jy][3]f32, // Fortran: ROPFL1(0:2,JY,JX)
    roafl1: [jx][jy][3]f32, // Fortran: ROAFL1(0:2,JY,JX)
    rcofl0: [jx][jy]f32, // Fortran: RCOFL0(JY,JX)
    rchfl0: [jx][jy]f32, // Fortran: RCHFL0(JY,JX)
    roxfl0: [jx][jy]f32, // Fortran: ROXFL0(JY,JX)
    rngfl0: [jx][jy]f32, // Fortran: RNGFL0(JY,JX)
    rn2fl0: [jx][jy]f32, // Fortran: RN2FL0(JY,JX)
    rhgfl0: [jx][jy]f32, // Fortran: RHGFL0(JY,JX)
    rn4fl0: [jx][jy]f32, // Fortran: RN4FL0(JY,JX)
    rn3fl0: [jx][jy]f32, // Fortran: RN3FL0(JY,JX)
    rnofl0: [jx][jy]f32, // Fortran: RNOFL0(JY,JX)
    rnxfl0: [jx][jy]f32, // Fortran: RNXFL0(JY,JX)
    rh2pf0: [jx][jy]f32, // Fortran: RH2PF0(JY,JX)
    rcofl1: [jx][jy]f32, // Fortran: RCOFL1(JY,JX)
    rchfl1: [jx][jy]f32, // Fortran: RCHFL1(JY,JX)
    roxfl1: [jx][jy]f32, // Fortran: ROXFL1(JY,JX)
    rngfl1: [jx][jy]f32, // Fortran: RNGFL1(JY,JX)
    rn2fl1: [jx][jy]f32, // Fortran: RN2FL1(JY,JX)
    rhgfl1: [jx][jy]f32, // Fortran: RHGFL1(JY,JX)
    rn4fl1: [jx][jy]f32, // Fortran: RN4FL1(JY,JX)
    rn3fl1: [jx][jy]f32, // Fortran: RN3FL1(JY,JX)
    rnofl1: [jx][jy]f32, // Fortran: RNOFL1(JY,JX)
    rnxfl1: [jx][jy]f32, // Fortran: RNXFL1(JY,JX)
    rh2pf1: [jx][jy]f32, // Fortran: RH2PF1(JY,JX)
    rn4fl2: [jx][jy]f32, // Fortran: RN4FL2(JY,JX)
    rn3fl2: [jx][jy]f32, // Fortran: RN3FL2(JY,JX)
    rnofl2: [jx][jy]f32, // Fortran: RNOFL2(JY,JX)
    rnxfl2: [jx][jy]f32, // Fortran: RNXFL2(JY,JX)
    rh2bf2: [jx][jy]f32, // Fortran: RH2BF2(JY,JX)
    rh1pf0: [jx][jy]f32, // Fortran: RH1PF0(JY,JX)
    rh1pf1: [jx][jy]f32, // Fortran: RH1PF1(JY,JX)
    rh1bf2: [jx][jy]f32, // Fortran: RH1BF2(JY,JX)

    pub fn init() Blktrnsfr13 {
        return std.mem.zeroInit(Blktrnsfr13, .{});
    }
};
