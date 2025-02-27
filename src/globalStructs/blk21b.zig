const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blk21b = struct {
    trxh0: [jx][jy][jz + 1]f32, // Fortran: TRXH0(0:JZ,JY,JX)
    trxh1: [jx][jy][jz + 1]f32, // Fortran: TRXH1(0:JZ,JY,JX)
    trxh2: [jx][jy][jz + 1]f32, // Fortran: TRXH2(0:JZ,JY,JX)
    trx1p: [jx][jy][jz + 1]f32, // Fortran: TRX1P(0:JZ,JY,JX)
    trx2p: [jx][jy][jz + 1]f32, // Fortran: TRX2P(0:JZ,JY,JX)
    tralpo: [jx][jy][jz + 1]f32, // Fortran: TRALPO(0:JZ,JY,JX)
    trfepo: [jx][jy][jz + 1]f32, // Fortran: TRFEPO(0:JZ,JY,JX)
    trcapd: [jx][jy][jz + 1]f32, // Fortran: TRCAPD(0:JZ,JY,JX)
    trcaph: [jx][jy][jz + 1]f32, // Fortran: TRCAPH(0:JZ,JY,JX)
    trcapm: [jx][jy][jz + 1]f32, // Fortran: TRCAPM(0:JZ,JY,JX)
    tbion: [jx][jy][jz + 1]f32, // Fortran: TBION(0:JZ,JY,JX)
    trno2: [jx][jy][jz + 1]f32, // Fortran: TRNO2(0:JZ,JY,JX)
    trn3g: [jx][jy][jz + 1]f32, // Fortran: TRN3G(0:JZ,JY,JX)
    trbh0: [jx][jy][jz]f32, // Fortran: TRBH0(JZ,JY,JX)
    trbh1: [jx][jy][jz]f32, // Fortran: TRBH1(JZ,JY,JX)
    trbh2: [jx][jy][jz]f32, // Fortran: TRBH2(JZ,JY,JX)
    trb1p: [jx][jy][jz]f32, // Fortran: TRB1P(JZ,JY,JX)
    trb2p: [jx][jy][jz]f32, // Fortran: TRB2P(JZ,JY,JX)
    traloh: [jx][jy][jz]f32, // Fortran: TRALOH(JZ,JY,JX)
    trfeoh: [jx][jy][jz]f32, // Fortran: TRFEOH(JZ,JY,JX)
    trcaco: [jx][jy][jz]f32, // Fortran: TRCACO(JZ,JY,JX)
    trcaso: [jx][jy][jz]f32, // Fortran: TRCASO(JZ,JY,JX)
    tralpb: [jx][jy][jz]f32, // Fortran: TRALPB(JZ,JY,JX)
    trfepb: [jx][jy][jz]f32, // Fortran: TRFEPB(JZ,JY,JX)
    trcpdb: [jx][jy][jz]f32, // Fortran: TRCPDB(JZ,JY,JX)
    trcphb: [jx][jy][jz]f32, // Fortran: TRCPHB(JZ,JY,JX)
    trcpmb: [jx][jy][jz]f32, // Fortran: TRCPMB(JZ,JY,JX)
    tbco2: [jx][jy][jz]f32, // Fortran: TBCO2(JZ,JY,JX)
    trn2b: [jx][jy][jz]f32, // Fortran: TRN2B(JZ,JY,JX)

    pub fn init() Blk21b {
        return std.mem.zeroInit(Blk21b, .{});
    }
};
