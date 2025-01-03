const std = @import("std");

pub const Blk1p = struct {
    wtshp: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    ppoolp: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtlfp: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtshep: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtstkp: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtrsvp: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wthskp: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtearp: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtgrnp: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtshtp: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wtlfbp: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wtshbp: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wtstbp: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wtrsbp: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wthsbp: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wteabp: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wtgrbp: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    ppool: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wglfp: comptime [jx][jy][jp][jc][26]f32 = std.mem.zeroes([jx][jy][jp][jc][26]f32),
    wgshp: comptime [jx][jy][jp][jc][26]f32 = std.mem.zeroes([jx][jy][jp][jc][26]f32),
    wgnodp: comptime [jx][jy][jp][jc][26]f32 = std.mem.zeroes([jx][jy][jp][jc][26]f32),
    wglflp: comptime [jx][jy][jp][jc][26][jz]f32 = std.mem.zeroes([jx][jy][jp][jc][26][jz]f32),
    ppoolr: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    cppolr: comptime [jx][jy][jp][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jz][2]f32),
    ppooln: comptime [jx][jy][jp][jz]f32 = std.mem.zeroes([jx][jy][jp][jz]f32),
    psnc: comptime [jx][jy][jp][jz][2][4]f32 = std.mem.zeroes([jx][jy][jp][jz][2][4]f32),
    cfopp: comptime [jx][jy][jp][4][6]f32 = std.mem.zeroes([jx][jy][jp][4][6]f32),
    wtrtp: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtrt1p: comptime [jx][jy][jp][jc][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jc][jz][2]f32),
    wtrt2p: comptime [jx][jy][jp][jc][jz][2]f32 = std.mem.zeroes([jx][jy][jp][jc][jz][2]f32),
    wtndp: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtndlp: comptime [jx][jy][jp][jz]f32 = std.mem.zeroes([jx][jy][jp][jz]f32),
    cppolp: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    cppolb: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    rtwt1p: comptime [jx][jy][jp][jc][2]f32 = std.mem.zeroes([jx][jy][jp][jc][2]f32),
    wtstdp: comptime [jx][jy][jp][4]f32 = std.mem.zeroes([jx][jy][jp][4]f32),
    wtstgp: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    ppolnb: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    ppolnp: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtndbp: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),

    pub fn init() Blk1p {
        return .{};
    }
};