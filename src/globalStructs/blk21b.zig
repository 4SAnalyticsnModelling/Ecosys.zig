const std = @import("std");

pub const Blk21b = struct {
    trxh0: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    trxh1: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    trxh2: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    trx1p: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    trx2p: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    trbh0: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trbh1: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trbh2: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trb1p: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trb2p: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    traloh: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trfeoh: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trcaco: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trcaso: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tralpo: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    trfepo: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    trcapd: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    trcaph: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    trcapm: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    tralpb: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trfepb: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trcpdb: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trcphb: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trcpmb: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tbco2: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tbion: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    trno2: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    trn2b: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trn3g: comptime [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),

    pub fn init() Blk21b {
        return .{};
    }
};
