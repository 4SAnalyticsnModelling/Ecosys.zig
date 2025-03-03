const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blktrnsfr2 = struct {
    rocsk2: [jx][jy][jz + 1][5]f32, // Fortran: ROCSK2(0:4,0:JZ,JY,JX)
    ronsk2: [jx][jy][jz + 1][5]f32, // Fortran: RONSK2(0:4,0:JZ,JY,JX)
    ropsk2: [jx][jy][jz + 1][5]f32, // Fortran: ROPSK2(0:4,0:JZ,JY,JX)
    roask2: [jx][jy][jz + 1][5]f32, // Fortran: ROASK2(0:4,0:JZ,JY,JX)
    rcosk2: [jx][jy][jz + 1]f32, // Fortran: RCOSK2(0:JZ,JY,JX)
    roxsk2: [jx][jy][jz + 1]f32, // Fortran: ROXSK2(0:JZ,JY,JX)
    rchsk2: [jx][jy][jz + 1]f32, // Fortran: RCHSK2(0:JZ,JY,JX)
    rngsk2: [jx][jy][jz + 1]f32, // Fortran: RNGSK2(0:JZ,JY,JX)
    rn2sk2: [jx][jy][jz + 1]f32, // Fortran: RN2SK2(0:JZ,JY,JX)
    rn4sk2: [jx][jy][jz + 1]f32, // Fortran: RN4SK2(0:JZ,JY,JX)
    rn3sk2: [jx][jy][jz + 1]f32, // Fortran: RN3SK2(0:JZ,JY,JX)
    rnosk2: [jx][jy][jz + 1]f32, // Fortran: RNOSK2(0:JZ,JY,JX)
    rhpsk2: [jx][jy][jz + 1]f32, // Fortran: RHPSK2(0:JZ,JY,JX)
    rnxsk2: [jx][jy][jz + 1]f32, // Fortran: RNXSK2(0:JZ,JY,JX)
    rhgsk2: [jx][jy][jz + 1]f32, // Fortran: RHGSK2(0:JZ,JY,JX)
    rnhsk2: [jx][jy][jz + 1]f32, // Fortran: RNHSK2(0:JZ,JY,JX)
    r1psk2: [jx][jy][jz + 1]f32, // Fortran: R1PSK2(0:JZ,JY,JX)
    r4bsk2: [jx][jy][jz]f32, // Fortran: R4BSK2(JZ,JY,JX)
    r3bsk2: [jx][jy][jz]f32, // Fortran: R3BSK2(JZ,JY,JX)
    rnbsk2: [jx][jy][jz]f32, // Fortran: RNBSK2(JZ,JY,JX)
    rhbsk2: [jx][jy][jz]f32, // Fortran: RHBSK2(JZ,JY,JX)
    rnzsk2: [jx][jy][jz]f32, // Fortran: RNZSK2(JZ,JY,JX)

    pub fn init() Blktrnsfr2 {
        return std.mem.zeroInit(Blktrnsfr2, .{});
    }
};
