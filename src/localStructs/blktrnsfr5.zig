const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blktrnsfr5 = struct {
    tocfls: [jx][jy][jz + 1][5]f32, // Fortran: TOCFLS(0:4,JZ,JY,JX)
    tonfls: [jx][jy][jz + 1][5]f32, // Fortran: TONFLS(0:4,JZ,JY,JX)
    topfls: [jx][jy][jz + 1][5]f32, // Fortran: TOPFLS(0:4,JZ,JY,JX)
    toafls: [jx][jy][jz + 1][5]f32, // Fortran: TOAFLS(0:4,JZ,JY,JX)
    rcodfg: [jx][jy][jz + 1]f32, // Fortran: RCODFG(0:JZ,JY,JX)
    rchdfg: [jx][jy][jz + 1]f32, // Fortran: RCHDFG(0:JZ,JY,JX)
    roxdfg: [jx][jy][jz + 1]f32, // Fortran: ROXDFG(0:JZ,JY,JX)
    rngdfg: [jx][jy][jz + 1]f32, // Fortran: RNGDFG(0:JZ,JY,JX)
    rn2dfg: [jx][jy][jz + 1]f32, // Fortran: RN2DFG(0:JZ,JY,JX)
    rn3dfg: [jx][jy][jz + 1]f32, // Fortran: RN3DFG(0:JZ,JY,JX)
    rnbdfg: [jx][jy][jz + 1]f32, // Fortran: RNBDFG(0:JZ,JY,JX)
    tcofls: [jx][jy][jz]f32, // Fortran: TCOFLS(JZ,JY,JX)
    tchfls: [jx][jy][jz]f32, // Fortran: TCHFLS(JZ,JY,JX)
    toxfls: [jx][jy][jz]f32, // Fortran: TOXFLS(JZ,JY,JX)
    tngfls: [jx][jy][jz]f32, // Fortran: TNGFLS(JZ,JY,JX)
    tn2fls: [jx][jy][jz]f32, // Fortran: TN2FLS(JZ,JY,JX)
    tn4flw: [jx][jy][jz]f32, // Fortran: TN4FLW(JZ,JY,JX)
    tn3flw: [jx][jy][jz]f32, // Fortran: TN3FLW(JZ,JY,JX)
    tnoflw: [jx][jy][jz]f32, // Fortran: TNOFLW(JZ,JY,JX)
    th2pfs: [jx][jy][jz]f32, // Fortran: TH2PFS(JZ,JY,JX)
    tn4flb: [jx][jy][jz]f32, // Fortran: TN4FLB(JZ,JY,JX)
    tn3flb: [jx][jy][jz]f32, // Fortran: TN3FLB(JZ,JY,JX)
    tnoflb: [jx][jy][jz]f32, // Fortran: TNOFLB(JZ,JY,JX)
    th2bfb: [jx][jy][jz]f32, // Fortran: TH2BFB(JZ,JY,JX)
    tnxfls: [jx][jy][jz]f32, // Fortran: TNXFLS(JZ,JY,JX)
    tcoflg: [jx][jy][jz]f32, // Fortran: TCOFLG(JZ,JY,JX)
    tchflg: [jx][jy][jz]f32, // Fortran: TCHFLG(JZ,JY,JX)
    toxflg: [jx][jy][jz]f32, // Fortran: TOXFLG(JZ,JY,JX)
    tngflg: [jx][jy][jz]f32, // Fortran: TNGFLG(JZ,JY,JX)
    tn2flg: [jx][jy][jz]f32, // Fortran: TN2FLG(JZ,JY,JX)
    th1pfs: [jx][jy][jz]f32, // Fortran: TH1PFS(JZ,JY,JX)
    th1bfb: [jx][jy][jz]f32, // Fortran: TH1BFB(JZ,JY,JX)
    tqroc: [jx][jy][5]f32, // Fortran: TQROC(0:4,JY,JX)
    tqron: [jx][jy][5]f32, // Fortran: TQRON(0:4,JY,JX)
    tqrop: [jx][jy][5]f32, // Fortran: TQROP(0:4,JY,JX)
    tqroa: [jx][jy][5]f32, // Fortran: TQROA(0:4,JY,JX)
    tqrchs: [jx][jy]f32, // Fortran: TQRCHS(JY,JX)
    tqroxs: [jx][jy]f32, // Fortran: TQROXS(JY,JX)
    tqrngs: [jx][jy]f32, // Fortran: TQRNGS(JY,JX)
    tqrn2s: [jx][jy]f32, // Fortran: TQRN2S(JY,JX)
    tqrnh4: [jx][jy]f32, // Fortran: TQRNH4(JY,JX)
    tqrnh3: [jx][jy]f32, // Fortran: TQRNH3(JY,JX)
    tqrno3: [jx][jy]f32, // Fortran: TQRNO3(JY,JX)
    tqrh2p: [jx][jy]f32, // Fortran: TQRH2P(JY,JX)
    tqrno2: [jx][jy]f32, // Fortran: TQRNO2(JY,JX)
    tqrhgs: [jx][jy]f32, // Fortran: TQRHGS(JY,JX)
    tqscos: [jx][jy]f32, // Fortran: TQSCOS(JY,JX)
    tqrcos: [jx][jy]f32, // Fortran: TQRCOS(JY,JX)
    tqschs: [jx][jy]f32, // Fortran: TQSCHS(JY,JX)
    tqsoxs: [jx][jy]f32, // Fortran: TQSOXS(JY,JX)
    tqsngs: [jx][jy]f32, // Fortran: TQSNGS(JY,JX)
    tqsn2s: [jx][jy]f32, // Fortran: TQSN2S(JY,JX)
    tqsnh4: [jx][jy]f32, // Fortran: TQSNH4(JY,JX)
    tqsnh3: [jx][jy]f32, // Fortran: TQSNH3(JY,JX)
    tqsno3: [jx][jy]f32, // Fortran: TQSNO3(JY,JX)
    tqsh1p: [jx][jy]f32, // Fortran: TQSH1P(JY,JX)
    tqsh2p: [jx][jy]f32, // Fortran: TQSH2P(JY,JX)
    tqrh1p: [jx][jy]f32, // Fortran: TQRH1P(JY,JX)

    pub fn init() Blktrnsfr5 {
        return std.mem.zeroInit(Blktrnsfr5, .{});
    }
};
