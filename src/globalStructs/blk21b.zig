const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blk21b = struct {
    trxh0: [jx][jy][jz + 1]f32,
    trxh1: [jx][jy][jz + 1]f32,
    trxh2: [jx][jy][jz + 1]f32,
    trx1p: [jx][jy][jz + 1]f32,
    trx2p: [jx][jy][jz + 1]f32,
    tralpo: [jx][jy][jz + 1]f32,
    trfepo: [jx][jy][jz + 1]f32,
    trcapd: [jx][jy][jz + 1]f32,
    trcaph: [jx][jy][jz + 1]f32,
    trcapm: [jx][jy][jz + 1]f32,
    tbion: [jx][jy][jz + 1]f32,
    trno2: [jx][jy][jz + 1]f32,
    trn3g: [jx][jy][jz + 1]f32,
    trbh0: [jx][jy][jz]f32,
    trbh1: [jx][jy][jz]f32,
    trbh2: [jx][jy][jz]f32,
    trb1p: [jx][jy][jz]f32,
    trb2p: [jx][jy][jz]f32,
    traloh: [jx][jy][jz]f32,
    trfeoh: [jx][jy][jz]f32,
    trcaco: [jx][jy][jz]f32,
    trcaso: [jx][jy][jz]f32,
    tralpb: [jx][jy][jz]f32,
    trfepb: [jx][jy][jz]f32,
    trcpdb: [jx][jy][jz]f32,
    trcphb: [jx][jy][jz]f32,
    trcpmb: [jx][jy][jz]f32,
    tbco2: [jx][jy][jz]f32,
    trn2b: [jx][jy][jz]f32,

    pub fn init() Blk21b {
        return std.mem.zeroInit(Blk21b, .{});
    }
};
