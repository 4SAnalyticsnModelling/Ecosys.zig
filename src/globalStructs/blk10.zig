const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const js = config.snowlayersmax;
const nphx = config.subhrwtrcymax;
const jh = jx + 1;
const jv = jy + 1;
const jd = jz + 1;

pub const Blk10 = struct {
    iflbm: [jx][jy][2][2][nphx]i32,
    parr: [jx][jy]f32,
    parg: [jx][jy][nphx]f32,
    engypm: [jx][jy][nphx]f32,
    xvoltm: [jx][jy][nphx]f32,
    xvolwm: [jx][jy][nphx]f32,
    xvolim: [jx][jy][nphx]f32,
    flwrm: [jx][jy][nphx]f32,
    flqrm: [jx][jy][nphx]f32,
    flqsm: [jx][jy][nphx]f32,
    flqhm: [jx][jy][nphx]f32,
    qrv: [jx][jy][nphx]f32,
    vhcpwm: [jx][jy][js][nphx]f32,
    flqwm: [jx][jy][js][nphx]f32,
    volwm: [jx][jy][jz + 1][nphx]f32,
    volpm: [jx][jy][jz + 1][nphx]f32,
    film: [jx][jy][jz + 1][nphx]f32,
    roxsk: [jx][jy][jz + 1][nphx]f32,
    thetpm: [jx][jy][jz + 1][nphx]f32,
    tort: [jx][jy][jz + 1][nphx]f32,
    dfgs: [jx][jy][jz + 1][nphx]f32,
    volti: [jx][jy][jz + 1][nphx]f32,
    volwhm: [jx][jy][jz][nphx]f32,
    flpm: [jx][jy][jz][nphx]f32,
    finhm: [jx][jy][jz][nphx]f32,
    torth: [jx][jy][jz][nphx]f32,
    flwm: [jh][jv][jd][3][nphx]f32,
    flwhm: [jh][jv][jd][3][nphx]f32,
    qrmn: [jh][jv][2][2][nphx]f32,
    qsm: [jh][jv][2][nphx]f32,
    qrm: [jh][jv][nphx]f32,

    pub fn init() Blk10 {
        return std.mem.zeroInit(Blk10, .{});
    }
};
