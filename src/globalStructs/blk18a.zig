const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jc = config.canopymax;
const offset: u32 = 1;

pub const Blk18a = struct {
    csnt: [jx][jy][jz + offset][2][4]f32, // Fortran: CSNT(4,0:1,0:JZ,JY,JX)
    zsnt: [jx][jy][jz + offset][2][4]f32, // Fortran: ZSNT(4,0:1,0:JZ,JY,JX)
    psnt: [jx][jy][jz + offset][2][4]f32, // Fortran: PSNT(4,0:1,0:JZ,JY,JX)
    tdfomc: [jx][jy][jz][5]f32, // Fortran: TDFOMC(0:4,JZ,JY,JX)
    tdfomn: [jx][jy][jz][5]f32, // Fortran: TDFOMN(0:4,JZ,JY,JX)
    tdfomp: [jx][jy][jz][5]f32, // Fortran: TDFOMP(0:4,JZ,JY,JX)
    tupwtr: [jx][jy][jz + offset]f32, // Fortran: TUPWTR(0:JZ,JY,JX)
    tupht: [jx][jy][jz + offset]f32, // Fortran: TUPHT(0:JZ,JY,JX)
    tcofla: [jx][jy][jz]f32, // Fortran: TCOFLA(JZ,JY,JX)
    toxfla: [jx][jy][jz]f32, // Fortran: TOXFLA(JZ,JY,JX)
    tchfla: [jx][jy][jz]f32, // Fortran: TCHFLA(JZ,JY,JX)
    tn2fla: [jx][jy][jz]f32, // Fortran: TN2FLA(JZ,JY,JX)
    tnhfla: [jx][jy][jz]f32, // Fortran: TNHFLA(JZ,JY,JX)
    tlco2p: [jx][jy][jz]f32, // Fortran: TLCO2P(JZ,JY,JX)
    tloxyp: [jx][jy][jz]f32, // Fortran: TLOXYP(JZ,JY,JX)
    tlch4p: [jx][jy][jz]f32, // Fortran: TLCH4P(JZ,JY,JX)
    tln2op: [jx][jy][jz]f32, // Fortran: TLN2OP(JZ,JY,JX)
    tlnh3p: [jx][jy][jz]f32, // Fortran: TLNH3P(JZ,JY,JX)
    tco2s: [jx][jy][jz]f32, // Fortran: TCO2S(JZ,JY,JX)
    tupoxs: [jx][jy][jz]f32, // Fortran: TUPOXS(JZ,JY,JX)
    tupchs: [jx][jy][jz]f32, // Fortran: TUPCHS(JZ,JY,JX)
    tupn2s: [jx][jy][jz]f32, // Fortran: TUPN2S(JZ,JY,JX)
    tupn3s: [jx][jy][jz]f32, // Fortran: TUPN3S(JZ,JY,JX)
    tupnh4: [jx][jy][jz]f32, // Fortran: TUPNH4(JZ,JY,JX)
    tupno3: [jx][jy][jz]f32, // Fortran: TUPNO3(JZ,JY,JX)
    tuph2p: [jx][jy][jz]f32, // Fortran: TUPH2P(JZ,JY,JX)
    tupn3b: [jx][jy][jz]f32, // Fortran: TUPN3B(JZ,JY,JX)
    tupnhb: [jx][jy][jz]f32, // Fortran: TUPNHB(JZ,JY,JX)
    tupnob: [jx][jy][jz]f32, // Fortran: TUPNOB(JZ,JY,JX)
    tuph2b: [jx][jy][jz]f32, // Fortran: TUPH2B(JZ,JY,JX)
    tupnf: [jx][jy][jz]f32, // Fortran: TUPNF(JZ,JY,JX)
    tco2p: [jx][jy][jz]f32, // Fortran: TCO2P(JZ,JY,JX)
    tupoxp: [jx][jy][jz]f32, // Fortran: TUPOXP(JZ,JY,JX)
    rtdnt: [jx][jy][jz]f32, // Fortran: RTDNT(JZ,JY,JX)
    tuph1p: [jx][jy][jz]f32, // Fortran: TUPH1P(JZ,JY,JX)
    tuph1b: [jx][jy][jz]f32, // Fortran: TUPH1B(JZ,JY,JX)
    wglft: [jx][jy][jc]f32, // Fortran: WGLFT(JC,JY,JX)
    arlft: [jx][jy][jc]f32, // Fortran: ARLFT(JC,JY,JX)
    arstt: [jx][jy][jc]f32, // Fortran: ARSTT(JC,JY,JX)
    arlfc: [jx][jy]f32, // Fortran: ARLFC(JY,JX)
    arstc: [jx][jy]f32, // Fortran: ARSTC(JY,JX)
    tevapp: [jx][jy]f32, // Fortran: TEVAPP(JY,JX)
    tevapc: [jx][jy]f32, // Fortran: TEVAPC(JY,JX)
    tengyc: [jx][jy]f32, // Fortran: TENGYC(JY,JX)
    thflxc: [jx][jy]f32, // Fortran: THFLXC(JY,JX)
    tvolwp: [jx][jy]f32, // Fortran: TVOLWP(JY,JX)
    gpp: [jx][jy]f32, // Fortran: GPP(JY,JX)
    reco: [jx][jy]f32, // Fortran: RECO(JY,JX)
    tco2z: [jx][jy]f32, // Fortran: TCO2Z(JY,JX)
    toxyz: [jx][jy]f32, // Fortran: TOXYZ(JY,JX)
    tch4z: [jx][jy]f32, // Fortran: TCH4Z(JY,JX)
    tn2oz: [jx][jy]f32, // Fortran: TN2OZ(JY,JX)
    tnh3z: [jx][jy]f32, // Fortran: TNH3Z(JY,JX)
    thrmc: [jx][jy]f32, // Fortran: THRMC(JY,JX)
    tcnet: [jx][jy]f32, // Fortran: TCNET(JY,JX)
    zcsnc: [jx][jy]f32, // Fortran: ZCSNC(JY,JX)
    zzsnc: [jx][jy]f32, // Fortran: ZZSNC(JY,JX)
    zpsnc: [jx][jy]f32, // Fortran: ZPSNC(JY,JX)
    arlss: [jx][jy]f32, // Fortran: ARLSS(JY,JX)
    tccan: [jx][jy]f32, // Fortran: TCCAN(JY,JX)

    pub fn init() Blk18a {
        return std.mem.zeroInit(Blk18a, .{});
    }
};
