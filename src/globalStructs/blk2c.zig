const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blk2c = struct {
    cocu: [jx][jy][jz][5]f32, // Fortran: COCU(0:4,JZ,JY,JX)
    conu: [jx][jy][jz][5]f32, // Fortran: CONU(0:4,JZ,JY,JX)
    coau: [jx][jy][jz][5]f32, // Fortran: COAU(0:4,JZ,JY,JX)
    copu: [jx][jy][jz][5]f32, // Fortran: COPU(0:4,JZ,JY,JX)
    cn4u: [jx][jy][jz]f32, // Fortran: CN4U(JZ,JY,JX)
    cn3u: [jx][jy][jz]f32, // Fortran: CN3U(JZ,JY,JX)
    cnou: [jx][jy][jz]f32, // Fortran: CNOU(JZ,JY,JX)
    ch2pu: [jx][jy][jz]f32, // Fortran: CH2PU(JZ,JY,JX)
    cnzu: [jx][jy][jz]f32, // Fortran: CNZU(JZ,JY,JX)
    calu: [jx][jy][jz]f32, // Fortran: CALU(JZ,JY,JX)
    cfeu: [jx][jy][jz]f32, // Fortran: CFEU(JZ,JY,JX)
    chyu: [jx][jy][jz]f32, // Fortran: CHYU(JZ,JY,JX)
    ccau: [jx][jy][jz]f32, // Fortran: CCAU(JZ,JY,JX)
    cmgu: [jx][jy][jz]f32, // Fortran: CMGU(JZ,JY,JX)
    cnau: [jx][jy][jz]f32, // Fortran: CNAU(JZ,JY,JX)
    ckau: [jx][jy][jz]f32, // Fortran: CKAU(JZ,JY,JX)
    cohu: [jx][jy][jz]f32, // Fortran: COHU(JZ,JY,JX)
    csou: [jx][jy][jz]f32, // Fortran: CSOU(JZ,JY,JX)
    cclu: [jx][jy][jz]f32, // Fortran: CCLU(JZ,JY,JX)
    cc3u: [jx][jy][jz]f32, // Fortran: CC3U(JZ,JY,JX)
    chcu: [jx][jy][jz]f32, // Fortran: CHCU(JZ,JY,JX)
    cal1u: [jx][jy][jz]f32, // Fortran: CAL1U(JZ,JY,JX)
    cal2u: [jx][jy][jz]f32, // Fortran: CAL2U(JZ,JY,JX)
    cal3u: [jx][jy][jz]f32, // Fortran: CAL3U(JZ,JY,JX)
    cal4u: [jx][jy][jz]f32, // Fortran: CAL4U(JZ,JY,JX)
    calsu: [jx][jy][jz]f32, // Fortran: CALSU(JZ,JY,JX)
    cfe1u: [jx][jy][jz]f32, // Fortran: CFE1U(JZ,JY,JX)
    cfe2u: [jx][jy][jz]f32, // Fortran: CFE2U(JZ,JY,JX)
    cfe3u: [jx][jy][jz]f32, // Fortran: CFE3U(JZ,JY,JX)
    cfe4u: [jx][jy][jz]f32, // Fortran: CFE4U(JZ,JY,JX)
    cfesu: [jx][jy][jz]f32, // Fortran: CFESU(JZ,JY,JX)
    ccaou: [jx][jy][jz]f32, // Fortran: CCAOU(JZ,JY,JX)
    ccacu: [jx][jy][jz]f32, // Fortran: CCACU(JZ,JY,JX)
    ccahu: [jx][jy][jz]f32, // Fortran: CCAHU(JZ,JY,JX)
    ccasu: [jx][jy][jz]f32, // Fortran: CCASU(JZ,JY,JX)
    cmgou: [jx][jy][jz]f32, // Fortran: CMGOU(JZ,JY,JX)
    cmgcu: [jx][jy][jz]f32, // Fortran: CMGCU(JZ,JY,JX)
    cmghu: [jx][jy][jz]f32, // Fortran: CMGHU(JZ,JY,JX)
    cmgsu: [jx][jy][jz]f32, // Fortran: CMGSU(JZ,JY,JX)
    cnacu: [jx][jy][jz]f32, // Fortran: CNACU(JZ,JY,JX)
    cnasu: [jx][jy][jz]f32, // Fortran: CNASU(JZ,JY,JX)
    ckasu: [jx][jy][jz]f32, // Fortran: CKASU(JZ,JY,JX)
    ch0pu: [jx][jy][jz]f32, // Fortran: CH0PU(JZ,JY,JX)
    ch1pu: [jx][jy][jz]f32, // Fortran: CH1PU(JZ,JY,JX)
    ch3pu: [jx][jy][jz]f32, // Fortran: CH3PU(JZ,JY,JX)
    cf1pu: [jx][jy][jz]f32, // Fortran: CF1PU(JZ,JY,JX)
    cf2pu: [jx][jy][jz]f32, // Fortran: CF2PU(JZ,JY,JX)
    cc0pu: [jx][jy][jz]f32, // Fortran: CC0PU(JZ,JY,JX)
    cc1pu: [jx][jy][jz]f32, // Fortran: CC1PU(JZ,JY,JX)
    cc2pu: [jx][jy][jz]f32, // Fortran: CC2PU(JZ,JY,JX)
    cm1pu: [jx][jy][jz]f32, // Fortran: CM1PU(JZ,JY,JX)
    ccoq: [jx][jy]f32, // Fortran: CCOQ(JY,JX)
    cchq: [jx][jy]f32, // Fortran: CCHQ(JY,JX)
    coxq: [jx][jy]f32, // Fortran: COXQ(JY,JX)
    cnnq: [jx][jy]f32, // Fortran: CNNQ(JY,JX)
    cn2q: [jx][jy]f32, // Fortran: CN2Q(JY,JX)
    bkrs: [3]f32, // Fortran: BKRS(0:2)
    ccou: f32, // Fortran: CCOU
    cchu: f32, // Fortran: CCHU
    coxu: f32, // Fortran: COXU
    cnnu: f32, // Fortran: CNNU
    cn2u: f32, // Fortran: CN2U

    pub fn init() Blk2c {
        return std.mem.zeroInit(Blk2c, .{});
    }
};
