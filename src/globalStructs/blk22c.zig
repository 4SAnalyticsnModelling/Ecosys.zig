const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const js = config.snowlayersmax;

pub const Blk22c = struct {
    xmghbs: [jx][jy][js]f32, // Fortran: XMGHBS(JS,JY,JX)
    xmgsbs: [jx][jy][js]f32, // Fortran: XMGSBS(JS,JY,JX)
    xnacbs: [jx][jy][js]f32, // Fortran: XNACBS(JS,JY,JX)
    xnasbs: [jx][jy][js]f32, // Fortran: XNASBS(JS,JY,JX)
    xkasbs: [jx][jy][js]f32, // Fortran: XKASBS(JS,JY,JX)
    xh0pbs: [jx][jy][js]f32, // Fortran: XH0PBS(JS,JY,JX)
    xh3pbs: [jx][jy][js]f32, // Fortran: XH3PBS(JS,JY,JX)
    xf1pbs: [jx][jy][js]f32, // Fortran: XF1PBS(JS,JY,JX)
    xf2pbs: [jx][jy][js]f32, // Fortran: XF2PBS(JS,JY,JX)
    xc0pbs: [jx][jy][js]f32, // Fortran: XC0PBS(JS,JY,JX)
    xc1pbs: [jx][jy][js]f32, // Fortran: XC1PBS(JS,JY,JX)
    xc2pbs: [jx][jy][js]f32, // Fortran: XC2PBS(JS,JY,JX)
    xm1pbs: [jx][jy][js]f32, // Fortran: XM1PBS(JS,JY,JX)

    pub fn init() Blk22c {
        return std.mem.zeroInit(Blk22c, .{});
    }
};
