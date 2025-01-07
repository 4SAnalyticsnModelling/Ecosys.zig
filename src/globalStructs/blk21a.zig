const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blk21a = struct {
    trn4s: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    trn3s: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    trn4b: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trno3: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    trn3b: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trnob: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tral: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trfe: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trhy: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trca: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trmg: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trna: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trka: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    troh: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trso4: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trco3: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trhco: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trco2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trh2o: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    tral1: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tral2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tral3: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tral4: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trals: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trfe1: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trfe2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trfe3: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trfe4: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trfes: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trcao: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trcac: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trcah: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trcas: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trmgo: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trmgc: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trmgh: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trmgs: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trnac: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trnas: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trh0p: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trh1p: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    trh2p: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    trh3p: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trf1p: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trf2p: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trc0p: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trc1p: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trc2p: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trm1p: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trh0b: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trh1b: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trh2b: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trh3b: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trf1b: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trf2b: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trc0b: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trc1b: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trc2b: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trm1b: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trxn4: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    trxnb: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trxhy: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trxal: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trxca: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trxmg: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trxna: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trxka: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trxfe: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    trxfe2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),

    pub fn init() Blk21a {
        return .{};
    }
};
