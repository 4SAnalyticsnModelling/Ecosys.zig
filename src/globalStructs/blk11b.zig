const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const js = config.snowlayersmax;
const offset: u32 = 1;

pub const Blk11b = struct {
    zlsgl: [jx][jy][jz + offset]f32, // Fortran: ZLSGL(0:JZ,JY,JX)
    znsgl: [jx][jy][jz + offset]f32, // Fortran: ZNSGL(0:JZ,JY,JX)
    zosgl: [jx][jy][jz + offset]f32, // Fortran: ZOSGL(0:JZ,JY,JX)
    posgl: [jx][jy][jz + offset]f32, // Fortran: POSGL(0:JZ,JY,JX)
    ocsgl: [jx][jy][jz + offset]f32, // Fortran: OCSGL(0:JZ,JY,JX)
    onsgl: [jx][jy][jz + offset]f32, // Fortran: ONSGL(0:JZ,JY,JX)
    opsgl: [jx][jy][jz + offset]f32, // Fortran: OPSGL(0:JZ,JY,JX)
    oasgl: [jx][jy][jz + offset]f32, // Fortran: OASGL(0:JZ,JY,JX)
    zvsgl: [jx][jy][jz + offset]f32, // Fortran: ZVSGL(0:JZ,JY,JX)
    sco2l: [jx][jy][jz + offset]f32, // Fortran: SCO2L(0:JZ,JY,JX)
    soxyl: [jx][jy][jz + offset]f32, // Fortran: SOXYL(0:JZ,JY,JX)
    sch4l: [jx][jy][jz + offset]f32, // Fortran: SCH4L(0:JZ,JY,JX)
    sn2ol: [jx][jy][jz + offset]f32, // Fortran: SN2OL(0:JZ,JY,JX)
    sn2gl: [jx][jy][jz + offset]f32, // Fortran: SN2GL(0:JZ,JY,JX)
    snh3l: [jx][jy][jz + offset]f32, // Fortran: SNH3L(0:JZ,JY,JX)
    sh2gl: [jx][jy][jz + offset]f32, // Fortran: SH2GL(0:JZ,JY,JX)
    psise: [jx][jy][jz + offset]f32, // Fortran: PSISE(0:JZ,JY,JX)
    psisa: [jx][jy][jz + offset]f32, // Fortran: PSISA(0:JZ,JY,JX)
    psiso: [jx][jy][jz + offset]f32, // Fortran: PSISO(0:JZ,JY,JX)
    psish: [jx][jy][jz + offset]f32, // Fortran: PSISH(0:JZ,JY,JX)
    thety: [jx][jy][jz + offset]f32, // Fortran: THETY(0:JZ,JY,JX)
    thets: [jx][jy][jz + offset]f32, // Fortran: THETS(0:JZ,JY,JX)
    volq: [jx][jy][jz + offset]f32, // Fortran: VOLQ(0:JZ,JY,JX)
    tfnq: [jx][jy][jz + offset]f32, // Fortran: TFNQ(0:JZ,JY,JX)
    hlsgl: [jx][jy][jz + offset]f32, // Fortran: HLSGL(0:JZ,JY,JX)
    zhsgl: [jx][jy][jz]f32, // Fortran: ZHSGL(JZ,JY,JX)
    z2sgl: [jx][jy][jz]f32, // Fortran: Z2SGL(JZ,JY,JX)
    wgsgl: [jx][jy][jz]f32, // Fortran: WGSGL(JZ,JY,JX)
    hgsgl: [jx][jy][jz]f32, // Fortran: HGSGL(JZ,JY,JX)
    wgsgw: [jx][jy][js]f32, // Fortran: WGSGW(JS,JY,JX)
    flsw: [jx][jy][js]f32, // Fortran: FLSW(JS,JY,JX)
    flswh: [jx][jy][js]f32, // Fortran: FLSWH(JS,JY,JX)
    hflsw: [jx][jy][js]f32, // Fortran: HFLSW(JS,JY,JX)
    flswr: [jx][jy][js]f32, // Fortran: FLSWR(JS,JY,JX)
    hflswr: [jx][jy][js]f32, // Fortran: HFLSWR(JS,JY,JX)
    wgsgr: [jx][jy]f32, // Fortran: WGSGR(JY,JX)
    wgsga: [jx][jy]f32, // Fortran: WGSGA(JY,JX)
    thawr: [jx][jy]f32, // Fortran: THAWR(JY,JX)
    hthawr: [jx][jy]f32, // Fortran: HTHAWR(JY,JX)
    thetx: f32, // Fortran: THETX
    thetpi: f32, // Fortran: THETPI
    densi: f32, // Fortran: DENSI
    densj: f32, // Fortran: DENSJ

    pub fn init() Blk11b {
        return std.mem.zeroInit(Blk11b, .{});
    }
};
