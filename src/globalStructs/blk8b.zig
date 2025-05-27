const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jh = jx + 1;
const jv = jy + 1;
const jd = jz + 1;
const offset: u32 = 1;

pub const Blk8b = struct {
    dist: [jh][jv][jd][3]f32, // Fortran: DIST(3,JD,JV,JH)
    disp: [jh][jv][jd][3]f32, // Fortran: DISP(3,JD,JV,JH)
    dlyr: [jx][jy][jz + offset][3]f32, // Fortran: DLYR(3,0:JZ,JY,JX)
    area: [jx][jy][jz + offset][3]f32, // Fortran: AREA(3,0:JZ,JY,JX)
    dlyri: [jx][jy][jz + offset][3]f32, // Fortran: DLYRI(3,0:JZ,JY,JX)
    iytyp: [jx][jy][366][3]i32, // Fortran: IYTYP(0:2,366,JY,JX)
    xdpth: [jx][jy][jz][3]f32, // Fortran: XDPTH(3,JZ,JY,JX)
    dpth: [jx][jy][jz + offset]f32, // Fortran: DPTH(JZ,JY,JX) with 0:JZ
    poros: [jx][jy][jz + offset]f32, // Fortran: POROS(0:JZ,JY,JX)
    psl: [jx][jy][jz + offset]f32, // Fortran: PSL(0:JZ,JY,JX)
    fcl: [jx][jy][jz + offset]f32, // Fortran: FCL(0:JZ,JY,JX)
    wpl: [jx][jy][jz + offset]f32, // Fortran: WPL(0:JZ,JY,JX)
    psd: [jx][jy][jz + offset]f32, // Fortran: PSD(0:JZ,JY,JX)
    fcd: [jx][jy][jz + offset]f32, // Fortran: FCD(0:JZ,JY,JX)
    volx: [jx][jy][jz + offset]f32, // Fortran: VOLX(0:JZ,JY,JX)
    voly: [jx][jy][jz + offset]f32, // Fortran: VOLY(0:JZ,JY,JX)
    bkvl: [jx][jy][jz + offset]f32, // Fortran: BKVL(0:JZ,JY,JX)
    srp: [jx][jy][jz + offset]f32, // Fortran: SRP(0:JZ,JY,JX)
    tfnd: [jx][jy][jz + offset]f32, // Fortran: TFND(0:JZ,JY,JX)
    volai: [jx][jy][jz + offset]f32, // Fortran: VOLAI(0:JZ,JY,JX)
    cdpthz: [jx][jy][jz + offset]f32, // Fortran: CDPTHZ(0:JZ,JY,JX)
    dpthz: [jx][jy][jz]f32, // Fortran: DPTHZ(JZ,JY,JX)
    sand: [jx][jy][jz]f32, // Fortran: SAND(JZ,JY,JX)
    silt: [jx][jy][jz]f32, // Fortran: SILT(JZ,JY,JX)
    clay: [jx][jy][jz]f32, // Fortran: CLAY(JZ,JY,JX)
    fslope: [jx][jy][2]f32, // Fortran: FSLOPE(2,JY,JX)
    ixtyp: [jx][jy][2]u32, // Fortran: IXTYP(2,JY,JX)
    albx: [jx][jy]f32, // Fortran: ALBX(JY,JX)
    poros0: [jx][jy]f32, // Fortran: POROS0(JY,JX)
    psims: [jx][jy]f32, // Fortran: PSIMS(JY,JX)
    psimx: [jx][jy]f32, // Fortran: PSIMX(JY,JX)
    psimn: [jx][jy]f32, // Fortran: PSIMN(JY,JX)
    psisd: [jx][jy]f32, // Fortran: PSISD(JY,JX)
    psimd: [jx][jy]f32, // Fortran: PSIMD(JY,JX)
    bkvlnm: [jx][jy]f32, // Fortran: BKVLNM(JY,JX)
    bkvlnu: [jx][jy]f32, // Fortran: BKVLNU(JY,JX)
    cdpthi: [jx][jy]f32, // Fortran: CDPTHI(JY,JX)
    iutyp: [jx][jy]i32, // Fortran: IUTYP(JY,JX)
    omci: [5][3]f32, // Fortran: OMCI(3,0:4)
    cnrh: [5]f32, // Fortran: CNRH(0:4)
    cprh: [5]f32, // Fortran: CPRH(0:4)
    omcf: [7]f32, // Fortran: OMCF(7)
    omca: [7]f32, // Fortran: OMCA(7)
    forgc: f32, // Fortran: FORGC
    fvlwb: f32, // Fortran: FVLWB
    fch4f: f32, // Fortran: FCH4F
    poroq: f32, // Fortran: POROQ
    fci: f32, // Fortran: FCI
    wpi: f32, // Fortran: WPI
    oxkm: f32, // Fortran: OXKM
    psihy: f32, // Fortran: PSIHY

    pub fn init() Blk8b {
        return std.mem.zeroInit(Blk8b, .{});
    }
};
