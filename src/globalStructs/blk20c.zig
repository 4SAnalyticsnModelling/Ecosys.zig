const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jh = jx + 1;
const jv = jy + 1;
const jd = jz + 1;

pub const Blk20c = struct {
    xalfhs: [jh][jv][jd][3]f32, // Fortran: XALFHS(3,JD,JV,JH)
    xfeehs: [jh][jv][jd][3]f32, // Fortran: XFEFHS(3,JD,JV,JH)
    xhyfhs: [jh][jv][jd][3]f32, // Fortran: XHYFHS(3,JD,JV,JH)
    xcafhs: [jh][jv][jd][3]f32, // Fortran: XCAFHS(3,JD,JV,JH)
    xmgfhs: [jh][jv][jd][3]f32, // Fortran: XMGFHS(3,JD,JV,JH)
    xnafhs: [jh][jv][jd][3]f32, // Fortran: XNAFHS(3,JD,JV,JH)
    xkafhs: [jh][jv][jd][3]f32, // Fortran: XKAFHS(3,JD,JV,JH)
    xohfhs: [jh][jv][jd][3]f32, // Fortran: XOHFHS(3,JD,JV,JH)
    xsofhs: [jh][jv][jd][3]f32, // Fortran: XSOFHS(3,JD,JV,JH)
    xclfhs: [jh][jv][jd][3]f32, // Fortran: XCLFHS(3,JD,JV,JH)
    xc3fhs: [jh][jv][jd][3]f32, // Fortran: XC3FHS(3,JD,JV,JH)
    xhcfhs: [jh][jv][jd][3]f32, // Fortran: XHCFHS(3,JD,JV,JH)
    xal1hs: [jh][jv][jd][3]f32, // Fortran: XAL1HS(3,JD,JV,JH)
    xal2hs: [jh][jv][jd][3]f32, // Fortran: XAL2HS(3,JD,JV,JH)
    xal3hs: [jh][jv][jd][3]f32, // Fortran: XAL3HS(3,JD,JV,JH)
    xal4hs: [jh][jv][jd][3]f32, // Fortran: XAL4HS(3,JD,JV,JH)
    xalshs: [jh][jv][jd][3]f32, // Fortran: XALSHS(3,JD,JV,JH)
    xfe1hs: [jh][jv][jd][3]f32, // Fortran: XFE1HS(3,JD,JV,JH)
    xfe2hs: [jh][jv][jd][3]f32, // Fortran: XFE2HS(3,JD,JV,JH)
    xfe3hs: [jh][jv][jd][3]f32, // Fortran: XFE3HS(3,JD,JV,JH)
    xfe4hs: [jh][jv][jd][3]f32, // Fortran: XFE4HS(3,JD,JV,JH)
    xfeshs: [jh][jv][jd][3]f32, // Fortran: XFESHS(3,JD,JV,JH)
    xcaohs: [jh][jv][jd][3]f32, // Fortran: XCAOHS(3,JD,JV,JH)
    xcachs: [jh][jv][jd][3]f32, // Fortran: XCACHS(3,JD,JV,JH)
    xcahhs: [jh][jv][jd][3]f32, // Fortran: XCAHHS(3,JD,JV,JH)
    xcashs: [jh][jv][jd][3]f32, // Fortran: XCASHS(3,JD,JV,JH)
    xmgohs: [jh][jv][jd][3]f32, // Fortran: XMGOHS(3,JD,JV,JH)
    xmgchs: [jh][jv][jd][3]f32, // Fortran: XMGCHS(3,JD,JV,JH)
    xmghhs: [jh][jv][jd][3]f32, // Fortran: XMGHHS(3,JD,JV,JH)
    xmgshs: [jh][jv][jd][3]f32, // Fortran: XMGSHS(3,JD,JV,JH)
    xnachs: [jh][jv][jd][3]f32, // Fortran: XNACHS(3,JD,JV,JH)
    xnashs: [jh][jv][jd][3]f32, // Fortran: XNASHS(3,JD,JV,JH)
    xkashs: [jh][jv][jd][3]f32, // Fortran: XKASHS(3,JD,JV,JH)
    xh0phs: [jh][jv][jd][3]f32, // Fortran: XH0PHS(3,JD,JV,JH)
    xh3phs: [jh][jv][jd][3]f32, // Fortran: XH3PHS(3,JD,JV,JH)
    xf1phs: [jh][jv][jd][3]f32, // Fortran: XF1PHS(3,JD,JV,JH)
    xf2phs: [jh][jv][jd][3]f32, // Fortran: XF2PHS(3,JD,JV,JH)
    xc0phs: [jh][jv][jd][3]f32, // Fortran: XC0PHS(3,JD,JV,JH)
    xc1phs: [jh][jv][jd][3]f32, // Fortran: XC1PHS(3,JD,JV,JH)
    xc2phs: [jh][jv][jd][3]f32, // Fortran: XC2PHS(3,JD,JV,JH)
    xm1phs: [jh][jv][jd][3]f32, // Fortran: XM1PHS(3,JD,JV,JH)
    xh0bhb: [jh][jv][jd][3]f32, // Fortran: XH0BHB(3,JD,JV,JH)
    xh3bhb: [jh][jv][jd][3]f32, // Fortran: XH3BHB(3,JD,JV,JH)
    xf1bhb: [jh][jv][jd][3]f32, // Fortran: XF1BHB(3,JD,JV,JH)
    xf2bhb: [jh][jv][jd][3]f32, // Fortran: XF2BHB(3,JD,JV,JH)
    xc0bhb: [jh][jv][jd][3]f32, // Fortran: XC0BHB(3,JD,JV,JH)
    xc1bhb: [jh][jv][jd][3]f32, // Fortran: XC1BHB(3,JD,JV,JH)
    xc2bhb: [jh][jv][jd][3]f32, // Fortran: XC2BHB(3,JD,JV,JH)
    xm1bhb: [jh][jv][jd][3]f32, // Fortran: XM1BHB(3,JD,JV,JH)

    pub fn init() Blk20c {
        return std.mem.zeroInit(Blk20c, .{});
    }
};
