const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jp = config.pftmax;
const jc = config.canopymax;

pub const Blk1s = struct {
    rczlx: [jx][jy][jp][jc]f32, // Fortran: RCZLX(JC,JP,JY,JX)
    rcplx: [jx][jy][jp][jc]f32, // Fortran: RCPLX(JC,JP,JY,JX)
    rcclx: [jx][jy][jp][jc]f32, // Fortran: RCCLX(JC,JP,JY,JX)
    wglfx: [jx][jy][jp][jc]f32, // Fortran: WGLFX(JC,JP,JY,JX)
    wglfnx: [jx][jy][jp][jc]f32, // Fortran: WGLFNX(JC,JP,JY,JX)
    wglfpx: [jx][jy][jp][jc]f32, // Fortran: WGLFPX(JC,JP,JY,JX)
    arlfz: [jx][jy][jp][jc]f32, // Fortran: ARLFZ(JC,JP,JY,JX)
    rczsx: [jx][jy][jp][jc]f32, // Fortran: RCZSX(JC,JP,JY,JX)
    rcpsx: [jx][jy][jp][jc]f32, // Fortran: RCPSX(JC,JP,JY,JX)
    rccsx: [jx][jy][jp][jc]f32, // Fortran: RCCSX(JC,JP,JY,JX)
    wgshex: [jx][jy][jp][jc]f32, // Fortran: WGSHEX(JC,JP,JY,JX)
    wgshnx: [jx][jy][jp][jc]f32, // Fortran: WGSHNX(JC,JP,JY,JX)
    wgshpx: [jx][jy][jp][jc]f32, // Fortran: WGSHPX(JC,JP,JY,JX)
    htshex: [jx][jy][jp][jc]f32, // Fortran: HTSHEX(JC,JP,JY,JX)
    wtstxb: [jx][jy][jp][jc]f32, // Fortran: WTSTXB(JC,JP,JY,JX)
    wtstxn: [jx][jy][jp][jc]f32, // Fortran: WTSTXN(JC,JP,JY,JX)
    wtstxp: [jx][jy][jp][jc]f32, // Fortran: WTSTXP(JC,JP,JY,JX)

    pub fn init() Blk1s {
        return std.mem.zeroInit(Blk1s, .{});
    }
};
