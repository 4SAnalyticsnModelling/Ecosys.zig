const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jp = config.pftmax;
const jc = config.canopymax;

pub const Blk1p = struct {
    wtshp: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    ppoolp: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtlfp: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtshep: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtstkp: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtrsvp: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wthskp: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtearp: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtgrnp: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtshtp: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wtlfbp: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wtshbp: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wtstbp: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wtrsbp: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wthsbp: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wteabp: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wtgrbp: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    ppool: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wglfp: [jx][jy][jp][jc][26]f32 = std.mem.zeroes([jx][jy][jp][jc][26]f32),
    wgshp: [jx][jy][jp][jc][26]f32 = std.mem.zeroes([jx][jy][jp][jc][26]f32),
    wgnodp: [jx][jy][jp][jc][26]f32 = std.mem.zeroes([jx][jy][jp][jc][26]f32),
    wglflp: [jx][jy][jp][jc][26][jz]f32 = std.mem.zeroes([jx][jy][jp][jc][26][jz]f32),
    ppoolr: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    cppolr: [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ppooln: [jx][jy][jp][jz]f32 = std.mem.zeroes([jx][jy][jp][jz]f32),
    psnc: [jx][jy][jp][jz][2][4]f32 = std.mem.zeroes([jx][jy][jp][jz][2][4]f32),
    cfopp: [jx][jy][jp][4][6]f32 = std.mem.zeroes([jx][jy][jp][4][6]f32),
    wtrtp: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtrt1p: [jx][jy][jp][jc][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jc][jz][2]f32),
    wtrt2p: [jx][jy][jp][jc][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jc][jz][2]f32),
    wtndp: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtndlp: [jx][jy][jp][jz]f32 = std.mem.zeroes([jx][jy][jp][jz]f32),
    cppolp: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    cppolb: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    rtwt1p: [jx][jy][jp][jc][2]f32 = std.mem.zeroes([jx][jy][jp][jc][2]f32),
    wtstdp: [jx][jy][jp][4]f32 = std.mem.zeroes([jx][jy][jp][4]f32),
    wtstgp: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    ppolnb: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    ppolnp: [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtndbp: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),

    pub fn init() Blk1p {
        return .{};
    }
};
