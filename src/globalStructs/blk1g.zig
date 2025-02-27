const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jp = config.pftmax;
const jc = config.canopymax;

pub const Blk1g = struct {
    surfb: [jx][jy][jp][jc][4][jz]f32, // Fortran: SURFB(4,JZ,JC,JP,JY,JX)
    surfx: [jx][jy][jp][jc][4][jz]f32, // Fortran: SURFX(4,JZ,JC,JP,JY,JX)
    vcgro: [jx][jy][jp][jc][25]f32, // Fortran: VCGRO(25,JC,JP,JY,JX)
    vgro: [jx][jy][jp][jc][25]f32, // Fortran: VGRO(25,JC,JP,JY,JX)
    compl: [jx][jy][jp][jc][25]f32, // Fortran: COMPL(25,JC,JP,JY,JX)
    etgro: [jx][jy][jp][jc][25]f32, // Fortran: ETGRO(25,JC,JP,JY,JX)
    cbxn: [jx][jy][jp][jc][25]f32, // Fortran: CBXN(25,JC,JP,JY,JX)
    cpool3: [jx][jy][jp][jc][25]f32, // Fortran: CPOOL3(25,JC,JP,JY,JX)
    co2b: [jx][jy][jp][jc][25]f32, // Fortran: CO2B(25,JC,JP,JY,JX)
    vcgr4: [jx][jy][jp][jc][25]f32, // Fortran: VCGR4(25,JC,JP,JY,JX)
    vgro4: [jx][jy][jp][jc][25]f32, // Fortran: VGRO4(25,JC,JP,JY,JX)
    etgr4: [jx][jy][jp][jc][25]f32, // Fortran: ETGR4(25,JC,JP,JY,JX)
    cbxn4: [jx][jy][jp][jc][25]f32, // Fortran: CBXN4(25,JC,JP,JY,JX)
    cpool4: [jx][jy][jp][jc][25]f32, // Fortran: CPOOL4(25,JC,JP,JY,JX)
    hcob: [jx][jy][jp][jc][25]f32, // Fortran: HCOB(25,JC,JP,JY,JX)
    fdbk4: [jx][jy][jp][jc][25]f32, // Fortran: FDBK4(25,JC,JP,JY,JX)
    tfn4: [jx][jy][jp][jz]f32, // Fortran: TFN4(JZ,JP,JY,JX)
    fdbk: [jx][jy][jp][jc]f32, // Fortran: FDBK(JC,JP,JY,JX)
    fdbkx: [jx][jy][jp][jc]f32, // Fortran: FDBKX(JC,JP,JY,JX)
    o2i: [jx][jy][jp]f32, // Fortran: O2I(JP,JY,JX)
    co2i: [jx][jy][jp]f32, // Fortran: CO2I(JP,JY,JX)
    dco2: [jx][jy][jp]f32, // Fortran: DCO2(JP,JY,JX)
    co2q: [jx][jy][jp]f32, // Fortran: CO2Q(JP,JY,JX)
    co2l: [jx][jy][jp]f32, // Fortran: CO2L(JP,JY,JX)
    o2l: [jx][jy][jp]f32, // Fortran: O2L(JP,JY,JX)
    sco2: [jx][jy][jp]f32, // Fortran: SCO2(JP,JY,JX)
    so2: [jx][jy][jp]f32, // Fortran: SO2(JP,JY,JX)
    xkco2l: [jx][jy][jp]f32, // Fortran: XKCO2L(JP,JY,JX)
    xkco2o: [jx][jy][jp]f32, // Fortran: XKCO2O(JP,JY,JX)
    tfn3: [jx][jy][jp]f32, // Fortran: TFN3(JP,JY,JX)
    tcc: [jx][jy][jp]f32, // Fortran: TCC(JP,JY,JX)
    tcg: [jx][jy][jp]f32, // Fortran: TCG(JP,JY,JX)
    tkc: [jx][jy][jp]f32, // Fortran: TKC(JP,JY,JX)
    tkg: [jx][jy][jp]f32, // Fortran: TKG(JP,JY,JX)
    dtkc: [jx][jy][jp]f32, // Fortran: DTKC(JP,JY,JX)
    chill: [jx][jy][jp]f32, // Fortran: CHILL(JP,JY,JX)
    fmol: [jx][jy][jp]f32, // Fortran: FMOL(JP,JY,JX)
    zc: [jx][jy][jp]f32, // Fortran: ZC(JP,JY,JX)
    arlfp: [jx][jy][jp]f32, // Fortran: ARLFP(JP,JY,JX)
    arstp: [jx][jy][jp]f32, // Fortran: ARSTP(JP,JY,JX)
    arlfs: [jx][jy][jp]f32, // Fortran: ARLFS(JP,JY,JX)

    pub fn init() Blk1g {
        return std.mem.zeroInit(Blk1g, .{});
    }
};
