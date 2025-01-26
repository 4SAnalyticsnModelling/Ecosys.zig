const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jp = config.pftmax;
const jc = config.canopymax;

pub const Blk1cp = struct {
    wglfl: [jx][jy][jp][jc][26][jz]f32,
    arlfl: [jx][jy][jp][jc][26][jz]f32,
    csnc: [jx][jy][jp][jz][2][4]f32,
    wglfv: [jx][jy][jp][jz]f32,
    arlfv: [jx][jy][jp][jz]f32,
    arstv: [jx][jy][jp][jz]f32,
    wtstdg: [jx][jy][jp][4]f32,
    wvstkb: [jx][jy][jp][jc]f32,
    cpool: [jx][jy][jp][jc]f32,
    wtlsb: [jx][jy][jp][jc]f32,
    wtshtb: [jx][jy][jp][jc]f32,
    wtlfb: [jx][jy][jp][jc]f32,
    wtsheb: [jx][jy][jp][jc]f32,
    wtstkb: [jx][jy][jp][jc]f32,
    wtrsvb: [jx][jy][jp][jc]f32,
    wthskb: [jx][jy][jp][jc]f32,
    wtearb: [jx][jy][jp][jc]f32,
    wtgrb: [jx][jy][jp][jc]f32,
    arlfb: [jx][jy][jp][jc]f32,
    grnob: [jx][jy][jp][jc]f32,
    grnxb: [jx][jy][jp][jc]f32,
    grwtb: [jx][jy][jp][jc]f32,
    wglf: [jx][jy][jp][jc][26]f32,
    wgshe: [jx][jy][jp][jc][26]f32,
    wgnode: [jx][jy][jp][jc][26]f32,
    htnodx: [jx][jy][jp][jc][26]f32,
    htshe: [jx][jy][jp][jc][26]f32,
    htnode: [jx][jy][jp][jc][26]f32,
    wslf: [jx][jy][jp][jc][26]f32,
    wsshe: [jx][jy][jp][jc][26]f32,
    ccpolb: [jx][jy][jp][jc]f32,
    wtndb: [jx][jy][jp][jc]f32,
    cpolnb: [jx][jy][jp][jc]f32,
    wtstg: [jx][jy][jp]f32,
    wtsht: [jx][jy][jp]f32,
    wtlf: [jx][jy][jp]f32,
    wtshe: [jx][jy][jp]f32,
    wtstk: [jx][jy][jp]f32,
    wvstk: [jx][jy][jp]f32,
    wtrsv: [jx][jy][jp]f32,
    wthsk: [jx][jy][jp]f32,
    wtear: [jx][jy][jp]f32,
    wtgr: [jx][jy][jp]f32,
    wtls: [jx][jy][jp]f32,
    wrtra: [jx][jy][jp]f32,
    htstz: [jx][jy][jp]f32,
    ccplnp: [jx][jy][jp]f32,
    grno: [jx][jy][jp]f32,
    cnet: [jx][jy][jp]f32,
    pp: [jx][jy][jp]f32,
    cpoolp: [jx][jy][jp]f32,
    ccpolp: [jx][jy][jp]f32,
    cpolnp: [jx][jy][jp]f32,

    pub fn init() Blk1cp {
        return std.mem.zeroInit(Blk1cp, .{});
    }
};
