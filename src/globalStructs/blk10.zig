const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const js = config.snowlayersmax;
const nphx = config.subhrwtrcymax; // Fortran: 60  (here nphx ≡ user defined, any integer)
const jh = jx + 1;
const jv = jy + 1;
const jd = jz + 1;
const offset: u32 = 1;

pub const Blk10 = struct {
    iflbm: [jx][jy][2][2][nphx]i32, // Fortran: IFLBM(60,2,2,JY,JX)
    flwm: [jh][jv][jd][3][nphx]f32, // Fortran: FLWM(60,3,JD,JV,JH)
    flwhm: [jh][jv][jd][3][nphx]f32, // Fortran: FLWHM(60,3,JD,JV,JH)
    qrmn: [jh][jv][2][2][nphx]f32, // Fortran: QRMN(60,2,2,JV,JH)
    vhcpwm: [jx][jy][js][nphx]f32, // Fortran: VHCPWM(60,JS,JY,JX)
    flqwm: [jx][jy][js][nphx]f32, // Fortran: FLQWM(60,JS,JY,JX)
    volwm: [jx][jy][jz + offset][nphx]f32, // Fortran: VOLWM(60,0:JZ,JY,JX)
    volpm: [jx][jy][jz + offset][nphx]f32, // Fortran: VOLPM(60,0:JZ,JY,JX)
    film: [jx][jy][jz + offset][nphx]f32, // Fortran: FILM(60,0:JZ,JY,JX)
    roxsk: [jx][jy][jz + offset][nphx]f32, // Fortran: ROXSK(60,0:JZ,JY,JX)
    thetpm: [jx][jy][jz + offset][nphx]f32, // Fortran: THETPM(60,0:JZ,JY,JX)
    tort: [jx][jy][jz + offset][nphx]f32, // Fortran: TORT(60,0:JZ,JY,JX)
    dfgs: [jx][jy][jz + offset][nphx]f32, // Fortran: DFGS(60,0:JZ,JY,JX)
    volwhm: [jx][jy][jz][nphx]f32, // Fortran: VOLWHM(60,JZ,JY,JX)
    flpm: [jx][jy][jz][nphx]f32, // Fortran: FLPM(60,JZ,JY,JX)
    finhm: [jx][jy][jz][nphx]f32, // Fortran: FINHM(60,JZ,JY,JX)
    torth: [jx][jy][jz][nphx]f32, // Fortran: TORTH(60,JZ,JY,JX)
    qsm: [jh][jv][2][nphx]f32, // Fortran: QSM(60,2,JV,JH)
    parg: [jx][jy][nphx]f32, // Fortran: PARG(60,JY,JX)
    engypm: [jx][jy][nphx]f32, // Fortran: ENGYPM(60,JY,JX)
    xvoltm: [jx][jy][nphx]f32, // Fortran: XVOLTM(60,JY,JX)
    xvolwm: [jx][jy][nphx]f32, // Fortran: XVOLWM(60,JY,JX)
    xvolim: [jx][jy][nphx]f32, // Fortran: XVOLIM(60,JY,JX)
    flwrm: [jx][jy][nphx]f32, // Fortran: FLWRM(60,JY,JX)
    flqrm: [jx][jy][nphx]f32, // Fortran: FLQRM(60,JY,JX)
    flqsm: [jx][jy][nphx]f32, // Fortran: FLQSM(60,JY,JX)
    flqhm: [jx][jy][nphx]f32, // Fortran: FLQHM(60,JY,JX)
    qrv: [jx][jy][nphx]f32, // Fortran: QRV(60,JY,JX)
    qrm: [jh][jv][nphx]f32, // Fortran: QRM(60,JV,JH)
    parr: [jx][jy]f32, // Fortran: PARR(JY,JX)

    pub fn init() Blk10 {
        return std.mem.zeroInit(Blk10, .{});
    }
};
