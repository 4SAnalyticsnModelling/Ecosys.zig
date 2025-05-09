const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blk21a = struct {
    trn4s: [jx][jy][jz + 1]f32, // Fortran: TRN4S(0:JZ,JY,JX)
    trn3s: [jx][jy][jz + 1]f32, // Fortran: TRN3S(0:JZ,JY,JX)
    trno3: [jx][jy][jz + 1]f32, // Fortran: TRNO3(0:JZ,JY,JX)
    trh2o: [jx][jy][jz + 1]f32, // Fortran: TRH2O(0:JZ,JY,JX)
    trh1p: [jx][jy][jz + 1]f32, // Fortran: TRH1P(0:JZ,JY,JX)
    trh2p: [jx][jy][jz + 1]f32, // Fortran: TRH2P(0:JZ,JY,JX)
    trxn4: [jx][jy][jz + 1]f32, // Fortran: TRXN4(0:JZ,JY,JX)
    trn4b: [jx][jy][jz]f32, // Fortran: TRN4B(JZ,JY,JX)
    trn3b: [jx][jy][jz]f32, // Fortran: TRN3B(JZ,JY,JX)
    trnob: [jx][jy][jz]f32, // Fortran: TRNOB(JZ,JY,JX)
    tral: [jx][jy][jz]f32, // Fortran: TRAL(JZ,JY,JX)
    trfe: [jx][jy][jz]f32, // Fortran: TRFE(JZ,JY,JX)
    trhy: [jx][jy][jz]f32, // Fortran: TRHY(JZ,JY,JX)
    trca: [jx][jy][jz]f32, // Fortran: TRCA(JZ,JY,JX)
    trmg: [jx][jy][jz]f32, // Fortran: TRMG(JZ,JY,JX)
    trna: [jx][jy][jz]f32, // Fortran: TRNA(JZ,JY,JX)
    trka: [jx][jy][jz]f32, // Fortran: TRKA(JZ,JY,JX)
    troh: [jx][jy][jz]f32, // Fortran: TROH(JZ,JY,JX)
    trso4: [jx][jy][jz]f32, // Fortran: TRSO4(JZ,JY,JX)
    trco3: [jx][jy][jz]f32, // Fortran: TRCO3(JZ,JY,JX)
    trhco: [jx][jy][jz]f32, // Fortran: TRHCO(JZ,JY,JX)
    trco2: [jx][jy][jz]f32, // Fortran: TRCO2(JZ,JY,JX)
    tral1: [jx][jy][jz]f32, // Fortran: TRAL1(JZ,JY,JX)
    tral2: [jx][jy][jz]f32, // Fortran: TRAL2(JZ,JY,JX)
    tral3: [jx][jy][jz]f32, // Fortran: TRAL3(JZ,JY,JX)
    tral4: [jx][jy][jz]f32, // Fortran: TRAL4(JZ,JY,JX)
    trals: [jx][jy][jz]f32, // Fortran: TRALS(JZ,JY,JX)
    trfe1: [jx][jy][jz]f32, // Fortran: TRFE1(JZ,JY,JX)
    trfe2: [jx][jy][jz]f32, // Fortran: TRFE2(JZ,JY,JX)
    trfe3: [jx][jy][jz]f32, // Fortran: TRFE3(JZ,JY,JX)
    trfe4: [jx][jy][jz]f32, // Fortran: TRFE4(JZ,JY,JX)
    trfes: [jx][jy][jz]f32, // Fortran: TRFES(JZ,JY,JX)
    trcao: [jx][jy][jz]f32, // Fortran: TRCAO(JZ,JY,JX)
    trcac: [jx][jy][jz]f32, // Fortran: TRCAC(JZ,JY,JX)
    trcah: [jx][jy][jz]f32, // Fortran: TRCAH(JZ,JY,JX)
    trcas: [jx][jy][jz]f32, // Fortran: TRCAS(JZ,JY,JX)
    trmgo: [jx][jy][jz]f32, // Fortran: TRMGO(JZ,JY,JX)
    trmgc: [jx][jy][jz]f32, // Fortran: TRMGC(JZ,JY,JX)
    trmgh: [jx][jy][jz]f32, // Fortran: TRMGH(JZ,JY,JX)
    trmgs: [jx][jy][jz]f32, // Fortran: TRMGS(JZ,JY,JX)
    trnac: [jx][jy][jz]f32, // Fortran: TRNAC(JZ,JY,JX)
    trnas: [jx][jy][jz]f32, // Fortran: TRNAS(JZ,JY,JX)
    trh0p: [jx][jy][jz]f32, // Fortran: TRH0P(JZ,JY,JX)
    trh3p: [jx][jy][jz]f32, // Fortran: TRH3P(JZ,JY,JX)
    trf1p: [jx][jy][jz]f32, // Fortran: TRF1P(JZ,JY,JX)
    trf2p: [jx][jy][jz]f32, // Fortran: TRF2P(JZ,JY,JX)
    trc0p: [jx][jy][jz]f32, // Fortran: TRC0P(JZ,JY,JX)
    trc1p: [jx][jy][jz]f32, // Fortran: TRC1P(JZ,JY,JX)
    trc2p: [jx][jy][jz]f32, // Fortran: TRC2P(JZ,JY,JX)
    trm1p: [jx][jy][jz]f32, // Fortran: TRM1P(JZ,JY,JX)
    trh0b: [jx][jy][jz]f32, // Fortran: TRH0B(JZ,JY,JX)
    trh1b: [jx][jy][jz]f32, // Fortran: TRH1B(JZ,JY,JX)
    trh2b: [jx][jy][jz]f32, // Fortran: TRH2B(JZ,JY,JX)
    trh3b: [jx][jy][jz]f32, // Fortran: TRH3B(JZ,JY,JX)
    trf1b: [jx][jy][jz]f32, // Fortran: TRF1B(JZ,JY,JX)
    trf2b: [jx][jy][jz]f32, // Fortran: TRF2B(JZ,JY,JX)
    trc0b: [jx][jy][jz]f32, // Fortran: TRC0B(JZ,JY,JX)
    trc1b: [jx][jy][jz]f32, // Fortran: TRC1B(JZ,JY,JX)
    trc2b: [jx][jy][jz]f32, // Fortran: TRC2B(JZ,JY,JX)
    trm1b: [jx][jy][jz]f32, // Fortran: TRM1B(JZ,JY,JX)
    trxnb: [jx][jy][jz]f32, // Fortran: TRXNB(JZ,JY,JX)
    trxhy: [jx][jy][jz]f32, // Fortran: TRXHY(JZ,JY,JX)
    trxal: [jx][jy][jz]f32, // Fortran: TRXAL(JZ,JY,JX)
    trxca: [jx][jy][jz]f32, // Fortran: TRXCA(JZ,JY,JX)
    trxmg: [jx][jy][jz]f32, // Fortran: TRXMG(JZ,JY,JX)
    trxna: [jx][jy][jz]f32, // Fortran: TRXNA(JZ,JY,JX)
    trxka: [jx][jy][jz]f32, // Fortran: TRXKA(JZ,JY,JX)
    trxhc: [jx][jy][jz]f32, // Fortran: TRXHC(JZ,JY,JX)
    trxal2: [jx][jy][jz]f32, // Fortran: TRXAL2(JZ,JY,JX)
    trkas: [jx][jy][jz]f32, // Fortran: TRKAS(JZ,JY,JX)
    trxfe: [jx][jy][jz]f32, // Fortran: TRXFE(JZ,JY,JX)
    trxfe2: [jx][jy][jz]f32, // Fortran: TRXFE2(JZ,JY,JX)

    pub fn init() Blk21a {
        return std.mem.zeroInit(Blk21a, .{});
    }
};
