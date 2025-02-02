const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jp = config.pftmax;
const jc = config.canopymax;

pub const Blk9a = struct {
    vrnl: [jx][jy][jp][jc]f32,
    vrnx: [jx][jy][jp][jc]f32,
    class4: [jx][jy][jp][4]f32,
    vcmx: [jx][jy][jp]f32,
    vomx: [jx][jy][jp]f32,
    vcmx4: [jx][jy][jp]f32,
    xkco2: [jx][jy][jp]f32,
    xko2: [jx][jy][jp]f32,
    xkco24: [jx][jy][jp]f32,
    rubp: [jx][jy][jp]f32,
    pepc: [jx][jy][jp]f32,
    etmx: [jx][jy][jp]f32,
    chl: [jx][jy][jp]f32,
    chl4: [jx][jy][jp]f32,
    xrni: [jx][jy][jp]f32,
    xrla: [jx][jy][jp]f32,
    ctc: [jx][jy][jp]f32,
    fco2: [jx][jy][jp]f32,
    wdlf: [jx][jy][jp]f32,
    pb: [jx][jy][jp]f32,
    sla1: [jx][jy][jp]f32,
    ssl1: [jx][jy][jp]f32,
    snl1: [jx][jy][jp]f32,
    htc: [jx][jy][jp]f32,
    sstx: [jx][jy][jp]f32,
    fnod: [jx][jy][jp]f32,
    dmlf: [jx][jy][jp]f32,
    dmshe: [jx][jy][jp]f32,
    dmstk: [jx][jy][jp]f32,
    dmrs: [jx][jy][jp]f32,
    dmhs: [jx][jy][jp]f32,
    dmea: [jx][jy][jp]f32,
    dmgr: [jx][jy][jp]f32,
    dmrt: [jx][jy][jp]f32,
    dmnd: [jx][jy][jp]f32,
    rsmx: [jx][jy][jp]f32,
    rcmx: [jx][jy][jp]f32,
    rsmh: [jx][jy][jp]f32,
    cnlf: [jx][jy][jp]f32,
    cnshe: [jx][jy][jp]f32,
    cnstk: [jx][jy][jp]f32,
    cnrsv: [jx][jy][jp]f32,
    cnhsk: [jx][jy][jp]f32,
    cnear: [jx][jy][jp]f32,
    cngr: [jx][jy][jp]f32,
    cnrt: [jx][jy][jp]f32,
    cnnd: [jx][jy][jp]f32,
    cplf: [jx][jy][jp]f32,
    cpshe: [jx][jy][jp]f32,
    cpstk: [jx][jy][jp]f32,
    cprsv: [jx][jy][jp]f32,
    cphsk: [jx][jy][jp]f32,
    cpear: [jx][jy][jp]f32,
    cpgr: [jx][jy][jp]f32,
    cprt: [jx][jy][jp]f32,
    cpnd: [jx][jy][jp]f32,
    cf: [jx][jy][jp]f32,
    xdl: [jx][jy][jp]f32,
    xppd: [jx][jy][jp]f32,
    cfi: [jx][jy][jp]f32,
    xtli: [jx][jy][jp]f32,
    osmo: [jx][jy][jp]f32,
    rcs: [jx][jy][jp]f32,
    stmx: [jx][jy][jp]f32,
    sdmx: [jx][jy][jp]f32,
    grmx: [jx][jy][jp]f32,
    ppz: [jx][jy][jp]f32,
    grdm: [jx][jy][jp]f32,
    gfill: [jx][jy][jp]f32,
    sdpthi: [jx][jy][jp]f32,
    cfx: [jx][jy][jp]f32,

    pub fn init() Blk9a {
        return std.mem.zeroInit(Blk9a, .{});
    }
};
