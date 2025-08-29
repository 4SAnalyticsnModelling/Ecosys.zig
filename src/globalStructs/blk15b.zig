const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jh = jx + 1;
const jv = jy + 1;
const jd = jz + 1;

pub const Blk15b = struct {
    xocfhs: [jh][jv][jd][3][5]f32, // Fortran: XOCFHS(0:4,3,JD,JV,JH)
    xonfhs: [jh][jv][jd][3][5]f32, // Fortran: XONFHS(0:4,3,JD,JV,JH)
    xopfhs: [jh][jv][jd][3][5]f32, // Fortran: XOPFHS(0:4,3,JD,JV,JH)
    xoafhs: [jh][jv][jd][3][5]f32, // Fortran: XOAFHS(0:4,3,JD,JV,JH)
    xnxfhb: [jh][jv][jd + 1][3]f32, // Fortran: XNXFHB(3,0:JD,JV,JH)
    xcofhs: [jh][jv][jd][3]f32, // Fortran: XCOFHS(3,JD,JV,JH)
    xchfhs: [jh][jv][jd][3]f32, // Fortran: XCHFHS(3,JD,JV,JH)
    xoxfhs: [jh][jv][jd][3]f32, // Fortran: XOXFHS(3,JD,JV,JH)
    xngfhs: [jh][jv][jd][3]f32, // Fortran: XNGFHS(3,JD,JV,JH)
    xn2fhs: [jh][jv][jd][3]f32, // Fortran: XN2FHS(3,JD,JV,JH)
    xhgfhs: [jh][jv][jd][3]f32, // Fortran: XHGFHS(3,JD,JV,JH)
    xn4fhw: [jh][jv][jd][3]f32, // Fortran: XN4FHW(3,JD,JV,JH)
    xn3fhw: [jh][jv][jd][3]f32, // Fortran: XN3FHW(3,JD,JV,JH)
    xnofhw: [jh][jv][jd][3]f32, // Fortran: XNOFHW(3,JD,JV,JH)
    xh2phs: [jh][jv][jd][3]f32, // Fortran: XH2PHS(3,JD,JV,JH)
    xnxfhs: [jh][jv][jd][3]f32, // Fortran: XNXFHS(3,JD,JV,JH)
    xn4fhb: [jh][jv][jd][3]f32, // Fortran: XN4FHB(3,JD,JV,JH)
    xn3fhb: [jh][jv][jd][3]f32, // Fortran: XN3FHB(3,JD,JV,JH)
    xnofhb: [jh][jv][jd][3]f32, // Fortran: XNOFHB(3,JD,JV,JH)
    xh2bhb: [jh][jv][jd][3]f32, // Fortran: XH2BHB(3,JD,JV,JH)
    flwx: [jh][jv][jd][3]f32, // Fortran: FLWX(3,JD,JV,JH)
    xh1phs: [jh][jv][jd][3]f32, // Fortran: XH1PHS(3,JD,JV,JH)
    xh1bhb: [jh][jv][jd][3]f32, // Fortran: XH1BHB(3,JD,JV,JH)

    pub fn init() Blk15b {
        return std.mem.zeroInit(Blk15b, .{});
    }
};
