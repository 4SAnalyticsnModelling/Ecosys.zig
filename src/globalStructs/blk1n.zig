const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jp = config.pftmax;
const jc = config.canopymax;

pub const Blk1n = struct {
    wglfln: [jx][jy][jp][jc][26][jz]f32,
    zsnc: [jx][jy][jp][jz][2][4]f32,
    cfopn: [jx][jy][jp][4][6]f32,
    zpoolr: [jx][jy][jp][jz][2]f32,
    czpolr: [jx][jy][jp][jz][2]f32,
    wtrt1n: [jx][jy][jp][jc][jz][2]f32,
    wtrt2n: [jx][jy][jp][jc][jz][2]f32,
    rtwt1n: [jx][jy][jp][jc][2]f32,
    wtstdn: [jx][jy][jp][4]f32,
    wglfn: [jx][jy][jp][jc][26]f32,
    wgshn: [jx][jy][jp][jc][26]f32,
    wgnodn: [jx][jy][jp][jc][26]f32,
    wtlfbn: [jx][jy][jp][jc]f32,
    wtshbn: [jx][jy][jp][jc]f32,
    wtstbn: [jx][jy][jp][jc]f32,
    wtrsbn: [jx][jy][jp][jc]f32,
    wthsbn: [jx][jy][jp][jc]f32,
    wteabn: [jx][jy][jp][jc]f32,
    wtgrbn: [jx][jy][jp][jc]f32,
    zpool: [jx][jy][jp][jc]f32,
    czpolb: [jx][jy][jp][jc]f32,
    zpolnb: [jx][jy][jp][jc]f32,
    wtndbn: [jx][jy][jp][jc]f32,
    zpooln: [jx][jy][jp][jz]f32,
    wtndln: [jx][jy][jp][jz]f32,
    wtshn: [jx][jy][jp]f32,
    zpoolp: [jx][jy][jp]f32,
    wtlfn: [jx][jy][jp]f32,
    wtshen: [jx][jy][jp]f32,
    wtstkn: [jx][jy][jp]f32,
    wtrsvn: [jx][jy][jp]f32,
    wthskn: [jx][jy][jp]f32,
    wtearn: [jx][jy][jp]f32,
    wtgrnn: [jx][jy][jp]f32,
    wtrtn: [jx][jy][jp]f32,
    wtndn: [jx][jy][jp]f32,
    czpolp: [jx][jy][jp]f32,
    wtstgn: [jx][jy][jp]f32,
    zpolnp: [jx][jy][jp]f32,

    pub fn init() Blk1n {
        return std.mem.zeroInit(Blk1n, .{});
    }
};
