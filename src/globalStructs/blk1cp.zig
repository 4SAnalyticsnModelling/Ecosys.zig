const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jp = config.pftmax;
const jc = config.canopymax;
const offset: u32 = 1;

pub const Blk1cp = struct {
    wglfl: [jx][jy][jp][jc][26][jz]f32, // Fortran: WGLFL(JZ,0:25,JC,JP,JY,JX)
    arlfl: [jx][jy][jp][jc][26][jz]f32, // Fortran: ARLFL(JZ,0:25,JC,JP,JY,JX)
    csnc: [jx][jy][jp][jz + offset][2][4]f32, // Fortran: CSNC(4,0:1,0:JZ,JP,JY,JX)
    wglf: [jx][jy][jp][jc][26]f32, // Fortran: WGLF(0:25,JC,JP,JY,JX)
    wgshe: [jx][jy][jp][jc][26]f32, // Fortran: WGSHE(0:25,JC,JP,JY,JX)
    wgnode: [jx][jy][jp][jc][26]f32, // Fortran: WGNODE(0:25,JC,JP,JY,JX)
    htnodx: [jx][jy][jp][jc][26]f32, // Fortran: HTNODX(0:25,JC,JP,JY,JX)
    htshe: [jx][jy][jp][jc][26]f32, // Fortran: HTSHE(0:25,JC,JP,JY,JX)
    htnode: [jx][jy][jp][jc][26]f32, // Fortran: HTNODE(0:25,JC,JP,JY,JX)
    wslf: [jx][jy][jp][jc][26]f32, // Fortran: WSLF(0:25,JC,JP,JY,JX)
    wsshe: [jx][jy][jp][jc][26]f32, // Fortran: WSSHE(0:25,JC,JP,JY,JX)
    arlf: [jx][jy][jp][jc][26]f32, // Fortran: ARLF(0:25,JC,JP,JY,JX)
    wglfv: [jx][jy][jp][jz]f32, // Fortran: WGLFV(JZ,JP,JY,JX)
    arlfv: [jx][jy][jp][jz]f32, // Fortran: ARLFV(JZ,JP,JY,JX)
    arstv: [jx][jy][jp][jz]f32, // Fortran: ARSTV(JZ,JP,JY,JX)
    wtstdg: [jx][jy][jp][4]f32, // Fortran: WTSTDG(4,JP,JY,JX)
    wvstkb: [jx][jy][jp][jc]f32, // Fortran: WVSTKB(JC,JP,JY,JX)
    cpool: [jx][jy][jp][jc]f32, // Fortran: CPOOL(JC,JP,JY,JX)
    wtlsb: [jx][jy][jp][jc]f32, // Fortran: WTLSB(JC,JP,JY,JX)
    wtshtb: [jx][jy][jp][jc]f32, // Fortran: WTSHTB(JC,JP,JY,JX)
    wtlfb: [jx][jy][jp][jc]f32, // Fortran: WTLFB(JC,JP,JY,JX)
    wtsheb: [jx][jy][jp][jc]f32, // Fortran: WTSHEB(JC,JP,JY,JX)
    wtstkb: [jx][jy][jp][jc]f32, // Fortran: WTSTKB(JC,JP,JY,JX)
    wtrsvb: [jx][jy][jp][jc]f32, // Fortran: WTRSVB(JC,JP,JY,JX)
    wthskb: [jx][jy][jp][jc]f32, // Fortran: WTHSKB(JC,JP,JY,JX)
    wtearb: [jx][jy][jp][jc]f32, // Fortran: WTEARB(JC,JP,JY,JX)
    wtgrb: [jx][jy][jp][jc]f32, // Fortran: WTGRB(JC,JP,JY,JX)
    arlfb: [jx][jy][jp][jc]f32, // Fortran: ARLFB(JC,JP,JY,JX)
    grnob: [jx][jy][jp][jc]f32, // Fortran: GRNOB(JC,JP,JY,JX)
    grnxb: [jx][jy][jp][jc]f32, // Fortran: GRNXB(JC,JP,JY,JX)
    grwtb: [jx][jy][jp][jc]f32, // Fortran: GRWTB(JC,JP,JY,JX)
    ccpolb: [jx][jy][jp][jc]f32, // Fortran: CCPOLB(JC,JP,JY,JX)
    wtndb: [jx][jy][jp][jc]f32, // Fortran: WTNDB(JC,JP,JY,JX)
    wtsht: [jx][jy][jp]f32, // Fortran: WTSHT(JP,JY,JX)
    wtlf: [jx][jy][jp]f32, // Fortran: WTLF(JP,JY,JX)
    wtshe: [jx][jy][jp]f32, // Fortran: WTSHE(JP,JY,JX)
    wtstk: [jx][jy][jp]f32, // Fortran: WTSTK(JP,JY,JX)
    wvstk: [jx][jy][jp]f32, // Fortran: WVSTK(JP,JY,JX)
    wtrsv: [jx][jy][jp]f32, // Fortran: WTRSV(JP,JY,JX)
    wthsk: [jx][jy][jp]f32, // Fortran: WTHSK(JP,JY,JX)
    wtear: [jx][jy][jp]f32, // Fortran: WTEAR(JP,JY,JX)
    wtgr: [jx][jy][jp]f32, // Fortran: WTGR(JP,JY,JX)
    wtls: [jx][jy][jp]f32, // Fortran: WTLS(JP,JY,JX)
    wtrta: [jx][jy][jp]f32, // Fortran: WTRTA(JP,JY,JX)
    htstz: [jx][jy][jp]f32, // Fortran: HTSTZ(JP,JY,JX)
    ccplnp: [jx][jy][jp]f32, // Fortran: CCPLNP(JP,JY,JX)
    grno: [jx][jy][jp]f32, // Fortran: GRNO(JP,JY,JX)
    cnet: [jx][jy][jp]f32, // Fortran: CNET(JP,JY,JX)
    pp: [jx][jy][jp]f32, // Fortran: PP(JP,JY,JX)
    cpoolp: [jx][jy][jp]f32, // Fortran: CPOOLP(JP,JY,JX)
    ccpolp: [jx][jy][jp]f32, // Fortran: CCPOLP(JP,JY,JX)
    cpolnp: [jx][jy][jp]f32, // Fortran: CPOLNP(JP,JY,JX)
    wtstg: [jx][jy][jp]f32, // Fortran: WTSTG(JP,JY,JX)

    pub fn init() Blk1cp {
        return std.mem.zeroInit(Blk1cp, .{});
    }
};
