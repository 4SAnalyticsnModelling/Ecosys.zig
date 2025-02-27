const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jp = config.pftmax;
const jc = config.canopymax;

pub const Blk12b = struct {
    rdfomc: [jx][jy][jp][jz][5][2]f32, // Fortran: RDFOMC(2,0:4,JZ,JP,JY,JX)
    rdfomn: [jx][jy][jp][jz][5][2]f32, // Fortran: RDFOMN(2,0:4,JZ,JP,JY,JX)
    rdfomp: [jx][jy][jp][jz][5][2]f32, // Fortran: RDFOMP(2,0:4,JZ,JP,JY,JX)
    rupnh4: [jx][jy][jp][jz][2]f32, // Fortran: RUPNH4(2,JZ,JP,JY,JX)
    rupnhb: [jx][jy][jp][jz][2]f32, // Fortran: RUPNHB(2,JZ,JP,JY,JX)
    rupno3: [jx][jy][jp][jz][2]f32, // Fortran: RUPNO3(2,JZ,JP,JY,JX)
    rupnob: [jx][jy][jp][jz][2]f32, // Fortran: RUPNOB(2,JZ,JP,JY,JX)
    ruph2p: [jx][jy][jp][jz][2]f32, // Fortran: RUPH2P(2,JZ,JP,JY,JX)
    ruph2b: [jx][jy][jp][jz][2]f32, // Fortran: RUPH2B(2,JZ,JP,JY,JX)
    ruonh4: [jx][jy][jp][jz][2]f32, // Fortran: RUONH4(2,JZ,JP,JY,JX)
    ruonhb: [jx][jy][jp][jz][2]f32, // Fortran: RUONHB(2,JZ,JP,JY,JX)
    ruono3: [jx][jy][jp][jz][2]f32, // Fortran: RUONO3(2,JZ,JP,JY,JX)
    ruonob: [jx][jy][jp][jz][2]f32, // Fortran: RUONOB(2,JZ,JP,JY,JX)
    ruoh2p: [jx][jy][jp][jz][2]f32, // Fortran: RUOH2P(2,JZ,JP,JY,JX)
    ruoh2b: [jx][jy][jp][jz][2]f32, // Fortran: RUOH2B(2,JZ,JP,JY,JX)
    rucnh4: [jx][jy][jp][jz][2]f32, // Fortran: RUCNH4(2,JZ,JP,JY,JX)
    rucnhb: [jx][jy][jp][jz][2]f32, // Fortran: RUCNHB(2,JZ,JP,JY,JX)
    rucno3: [jx][jy][jp][jz][2]f32, // Fortran: RUCNO3(2,JZ,JP,JY,JX)
    rucnob: [jx][jy][jp][jz][2]f32, // Fortran: RUCNOB(2,JZ,JP,JY,JX)
    ruch2p: [jx][jy][jp][jz][2]f32, // Fortran: RUCH2P(2,JZ,JP,JY,JX)
    ruch2b: [jx][jy][jp][jz][2]f32, // Fortran: RUCH2B(2,JZ,JP,JY,JX)
    ruphgs: [jx][jy][jp][jz][2]f32, // Fortran: RUPHGS(2,JZ,JP,JY,JX)
    ruph1p: [jx][jy][jp][jz][2]f32, // Fortran: RUPH1P(2,JZ,JP,JY,JX)
    ruph1b: [jx][jy][jp][jz][2]f32, // Fortran: RUPH1B(2,JZ,JP,JY,JX)
    ruoh1p: [jx][jy][jp][jz][2]f32, // Fortran: RUOH1P(2,JZ,JP,JY,JX)
    ruoh1b: [jx][jy][jp][jz][2]f32, // Fortran: RUOH1B(2,JZ,JP,JY,JX)
    ruch1p: [jx][jy][jp][jz][2]f32, // Fortran: RUCH1P(2,JZ,JP,JY,JX)
    ruch1b: [jx][jy][jp][jz][2]f32, // Fortran: RUCH1B(2,JZ,JP,JY,JX)
    runnhp: [jx][jy][jp][jz][2]f32, // Fortran: RUNNHP(2,JZ,JP,JY,JX)
    runnop: [jx][jy][jp][jz][2]f32, // Fortran: RUNNOP(2,JZ,JP,JY,JX)
    rupp2p: [jx][jy][jp][jz][2]f32, // Fortran: RUPP2P(2,JZ,JP,JY,JX)
    runnbp: [jx][jy][jp][jz][2]f32, // Fortran: RUNNBP(2,JZ,JP,JY,JX)
    runnxp: [jx][jy][jp][jz][2]f32, // Fortran: RUNNXP(2,JZ,JP,JY,JX)
    rupp2b: [jx][jy][jp][jz][2]f32, // Fortran: RUPP2B(2,JZ,JP,JY,JX)
    rco2n: [jx][jy][jp][jz][2]f32, // Fortran: RCO2N(2,JZ,JP,JY,JX)
    wfr: [jx][jy][jp][jz][2]f32, // Fortran: WFR(2,JZ,JP,JY,JX)
    rhgfla: [jx][jy][jp][jz][2]f32, // Fortran: RHGFLA(2,JZ,JP,JY,JX)
    rhgdfa: [jx][jy][jp][jz][2]f32, // Fortran: RHGDFA(2,JZ,JP,JY,JX)
    h2ga: [jx][jy][jp][jz][2]f32, // Fortran: H2GA(2,JZ,JP,JY,JX)
    h2gp: [jx][jy][jp][jz][2]f32, // Fortran: H2GP(2,JZ,JP,JY,JX)
    rupp1p: [jx][jy][jp][jz][2]f32, // Fortran: RUPP1P(2,JZ,JP,JY,JX)
    rupp1b: [jx][jy][jp][jz][2]f32, // Fortran: RUPP1B(2,JZ,JP,JY,JX)
    rupnf: [jx][jy][jp][jz]f32, // Fortran: RUPNF(JZ,JP,JY,JX)
    volwp: [jx][jy][jp]f32, // Fortran: VOLWP(JP,JY,JX)
    rnh3z: [jx][jy][jp]f32, // Fortran: RNH3Z(JP,JY,JX)
    rh2gz: [jx][jy][jp]f32, // Fortran: RH2GZ(JP,JY,JX)
    rnh3b: [jx][jy][jc][jp]f32, // Fortran: RNH3B(JC,JP,JY,JX)

    pub fn init() Blk12b {
        return std.mem.zeroInit(Blk12b, .{});
    }
};
