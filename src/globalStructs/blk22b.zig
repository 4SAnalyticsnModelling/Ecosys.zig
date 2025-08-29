const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const js = config.snowlayersmax;

pub const Blk22b = struct {
    rc2pfu: [jx][jy][jz]f32, // Fortran: RC2PFU(JZ,JY,JX)
    rm1pfu: [jx][jy][jz]f32, // Fortran: RM1PFU(JZ,JY,JX)
    rh0bbu: [jx][jy][jz]f32, // Fortran: RH0BBU(JZ,JY,JX)
    rh3bbu: [jx][jy][jz]f32, // Fortran: RH3BBU(JZ,JY,JX)
    rf1bbu: [jx][jy][jz]f32, // Fortran: RF1BBU(JZ,JY,JX)
    rf2bbu: [jx][jy][jz]f32, // Fortran: RF2BBU(JZ,JY,JX)
    rc0bbu: [jx][jy][jz]f32, // Fortran: RC0BBU(JZ,JY,JX)
    rc1bbu: [jx][jy][jz]f32, // Fortran: RC1BBU(JZ,JY,JX)
    rc2bbu: [jx][jy][jz]f32, // Fortran: RC2BBU(JZ,JY,JX)
    rm1bbu: [jx][jy][jz]f32, // Fortran: RM1BBU(JZ,JY,JX)
    xcobls: [jx][jy][js]f32, // Fortran: XCOBLS(JS,JY,JX)
    xchbls: [jx][jy][js]f32, // Fortran: XCHBLS(JS,JY,JX)
    xoxbls: [jx][jy][js]f32, // Fortran: XOXBLS(JS,JY,JX)
    xngbls: [jx][jy][js]f32, // Fortran: XNGBLS(JS,JY,JX)
    xn2bls: [jx][jy][js]f32, // Fortran: XN2BLS(JS,JY,JX)
    xn4blw: [jx][jy][js]f32, // Fortran: XN4BLW(JS,JY,JX)
    xn3blw: [jx][jy][js]f32, // Fortran: XN3BLW(JS,JY,JX)
    xnoblw: [jx][jy][js]f32, // Fortran: XNOBLW(JS,JY,JX)
    xh1pbs: [jx][jy][js]f32, // Fortran: XH1PBS(JS,JY,JX)
    xh2pbs: [jx][jy][js]f32, // Fortran: XH2PBS(JS,JY,JX)
    xalbls: [jx][jy][js]f32, // Fortran: XALBLS(JS,JY,JX)
    xfebls: [jx][jy][js]f32, // Fortran: XFEBLS(JS,JY,JX)
    xhybls: [jx][jy][js]f32, // Fortran: XHYBLS(JS,JY,JX)
    xcabls: [jx][jy][js]f32, // Fortran: XCABLS(JS,JY,JX)
    xmgbls: [jx][jy][js]f32, // Fortran: XMGBLS(JS,JY,JX)
    xnabls: [jx][jy][js]f32, // Fortran: XNABLS(JS,JY,JX)
    xkabls: [jx][jy][js]f32, // Fortran: XKABLS(JS,JY,JX)
    xohbls: [jx][jy][js]f32, // Fortran: XOHBLS(JS,JY,JX)
    xsobls: [jx][jy][js]f32, // Fortran: XSOBLS(JS,JY,JX)
    xclbls: [jx][jy][js]f32, // Fortran: XCLBLS(JS,JY,JX)
    xc3bls: [jx][jy][js]f32, // Fortran: XC3BLS(JS,JY,JX)
    xhcbls: [jx][jy][js]f32, // Fortran: XHCBLS(JS,JY,JX)
    xal1bs: [jx][jy][js]f32, // Fortran: XAL1BS(JS,JY,JX)
    xal2bs: [jx][jy][js]f32, // Fortran: XAL2BS(JS,JY,JX)
    xal3bs: [jx][jy][js]f32, // Fortran: XAL3BS(JS,JY,JX)
    xal4bs: [jx][jy][js]f32, // Fortran: XAL4BS(JS,JY,JX)
    xalsbs: [jx][jy][js]f32, // Fortran: XALSBS(JS,JY,JX)
    xfe1bs: [jx][jy][js]f32, // Fortran: XFE1BS(JS,JY,JX)
    xfe2bs: [jx][jy][js]f32, // Fortran: XFE2BS(JS,JY,JX)
    xfe3bs: [jx][jy][js]f32, // Fortran: XFE3BS(JS,JY,JX)
    xfe4bs: [jx][jy][js]f32, // Fortran: XFE4BS(JS,JY,JX)
    xfesbs: [jx][jy][js]f32, // Fortran: XFESBS(JS,JY,JX)
    xcaobs: [jx][jy][js]f32, // Fortran: XCAOBS(JS,JY,JX)
    xcacbs: [jx][jy][js]f32, // Fortran: XCACBS(JS,JY,JX)
    xcahbs: [jx][jy][js]f32, // Fortran: XCAHBS(JS,JY,JX)
    xcasbs: [jx][jy][js]f32, // Fortran: XCASBS(JS,JY,JX)
    xmgobs: [jx][jy][js]f32, // Fortran: XMGOBS(JS,JY,JX)
    xmgcbs: [jx][jy][js]f32, // Fortran: XMGCBS(JS,JY,JX)
    xhgbls: [jx][jy][js]f32, // Fortran: XHGBLS(JS,JY,JX)

    pub fn init() Blk22b {
        return std.mem.zeroInit(Blk22b, .{});
    }
};
