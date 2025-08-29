const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jh = jx + 1;
const jv = jy + 1;
const jd = jz + 1;

pub const Blktrnsfr4 = struct {
    rocfls: [jh][jv][jd + 1][3][5]f32, // Fortran: ROCFLS(0:4,3,0:JD,JV,JH)
    ronfls: [jh][jv][jd + 1][3][5]f32, // Fortran: RONFLS(0:4,3,0:JD,JV,JH)
    ropfls: [jh][jv][jd + 1][3][5]f32, // Fortran: ROPFLS(0:4,3,0:JD,JV,JH)
    roafls: [jh][jv][jd + 1][3][5]f32, // Fortran: ROAFLS(0:4,3,0:JD,JV,JH)
    rocfhs: [jh][jv][jd][3][5]f32, // Fortran: ROCFHS(0:4,3,JD,JV,JH)
    ronfhs: [jh][jv][jd][3][5]f32, // Fortran: RONFHS(0:4,3,JD,JV,JH)
    ropfhs: [jh][jv][jd][3][5]f32, // Fortran: ROPFHS(0:4,3,JD,JV,JH)
    roafhs: [jh][jv][jd][3][5]f32, // Fortran: ROAFHS(0:4,3,JD,JV,JH)
    rcofls: [jh][jv][jd + 1][3]f32, // Fortran: RCOFLS(3,0:JD,JV,JH)
    rchfls: [jh][jv][jd + 1][3]f32, // Fortran: RCHFLS(3,0:JD,JV,JH)
    roxfls: [jh][jv][jd + 1][3]f32, // Fortran: ROXFLS(3,0:JD,JV,JH)
    rngfls: [jh][jv][jd + 1][3]f32, // Fortran: RNGFLS(3,0:JD,JV,JH)
    rn2fls: [jh][jv][jd + 1][3]f32, // Fortran: RN2FLS(3,0:JD,JV,JH)
    rhgfls: [jh][jv][jd + 1][3]f32, // Fortran: RHGFLS(3,0:JD,JV,JH)
    rn4flw: [jh][jv][jd + 1][3]f32, // Fortran: RN4FLW(3,0:JD,JV,JH)
    rn3flw: [jh][jv][jd + 1][3]f32, // Fortran: RN3FLW(3,0:JD,JV,JH)
    rnoflw: [jh][jv][jd + 1][3]f32, // Fortran: RNOFLW(3,0:JD,JV,JH)
    rnxfls: [jh][jv][jd + 1][3]f32, // Fortran: RNXFLS(3,0:JD,JV,JH)
    rh2pfs: [jh][jv][jd + 1][3]f32, // Fortran: RH2PFS(3,0:JD,JV,JH)
    rn4flb: [jh][jv][jd + 1][3]f32, // Fortran: RN4FLB(3,0:JD,JV,JH)
    rn3flb: [jh][jv][jd + 1][3]f32, // Fortran: RN3FLB(3,0:JD,JV,JH)
    rnoflb: [jh][jv][jd + 1][3]f32, // Fortran: RNOFLB(3,0:JD,JV,JH)
    rnxflb: [jh][jv][jd + 1][3]f32, // Fortran: RNXFLB(3,0:JD,JV,JH)
    rh2bfb: [jh][jv][jd + 1][3]f32, // Fortran: RH2BFB(3,0:JD,JV,JH)
    rh1pfs: [jh][jv][jd + 1][3]f32, // Fortran: RH1PFS(3,0:JD,JV,JH)
    rh1bfb: [jh][jv][jd + 1][3]f32, // Fortran: RH1BFB(3,0:JD,JV,JH)
    rcofhs: [jh][jv][jd][3]f32, // Fortran: RCOFHS(3,JD,JV,JH)
    rchfhs: [jh][jv][jd][3]f32, // Fortran: RCHFHS(3,JD,JV,JH)
    roxfhs: [jh][jv][jd][3]f32, // Fortran: ROXFHS(3,JD,JV,JH)
    rngfhs: [jh][jv][jd][3]f32, // Fortran: RNGFHS(3,JD,JV,JH)
    rn2fhs: [jh][jv][jd][3]f32, // Fortran: RN2FHS(3,JD,JV,JH)
    rn4fhw: [jh][jv][jd][3]f32, // Fortran: RN4FHW(3,JD,JV,JH)
    rn3fhw: [jh][jv][jd][3]f32, // Fortran: RN3FHW(3,JD,JV,JH)
    rnofhw: [jh][jv][jd][3]f32, // Fortran: RNOFHW(3,JD,JV,JH)
    rh2phs: [jh][jv][jd][3]f32, // Fortran: RH2PHS(3,JD,JV,JH)
    rn4fhb: [jh][jv][jd][3]f32, // Fortran: RN4FHB(3,JD,JV,JH)
    rn3fhb: [jh][jv][jd][3]f32, // Fortran: RN3FHB(3,JD,JV,JH)
    rnofhb: [jh][jv][jd][3]f32, // Fortran: RNOFHB(3,JD,JV,JH)
    rh2bhb: [jh][jv][jd][3]f32, // Fortran: RH2BHB(3,JD,JV,JH)
    roxflg: [jh][jv][jd][3]f32, // Fortran: ROXFLG(3,JD,JV,JH)
    rn3flg: [jh][jv][jd][3]f32, // Fortran: RN3FLG(3,JD,JV,JH)
    rcoflg: [jh][jv][jd][3]f32, // Fortran: RCOFLG(3,JD,JV,JH)
    rchflg: [jh][jv][jd][3]f32, // Fortran: RCHFLG(3,JD,JV,JH)
    rngflg: [jh][jv][jd][3]f32, // Fortran: RNGFLG(3,JD,JV,JH)
    rn2flg: [jh][jv][jd][3]f32, // Fortran: RN2FLG(3,JD,JV,JH)
    rnxfhs: [jh][jv][jd][3]f32, // Fortran: RNXFHS(3,JD,JV,JH)
    rnxfhb: [jh][jv][jd][3]f32, // Fortran: RNXFHB(3,JD,JV,JH)
    rh1phs: [jh][jv][jd][3]f32, // Fortran: RH1PHS(3,JD,JV,JH)
    rh1bhb: [jh][jv][jd][3]f32, // Fortran: RH1BHB(3,JD,JV,JH)

    pub fn init() Blktrnsfr4 {
        return std.mem.zeroInit(Blktrnsfr4, .{});
    }
};
