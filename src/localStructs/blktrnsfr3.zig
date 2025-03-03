const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jh = jx + 1;
const jv = jy + 1;

pub const Blktrnsfr3 = struct {
    rqroc: [jh][jv][2][2][5]f32, // Fortran: RQROC(0:4,2,2,JV,JH)
    rqron: [jh][jv][2][2][5]f32, // Fortran: RQRON(0:4,2,2,JV,JH)
    rqrop: [jh][jv][2][2][5]f32, // Fortran: RQROP(0:4,2,2,JV,JH)
    rqroa: [jh][jv][2][2][5]f32, // Fortran: RQROA(0:4,2,2,JV,JH)
    rqrcos: [jh][jv][2][2]f32, // Fortran: RQRCOS(2,2,JV,JH)
    rqrchs: [jh][jv][2][2]f32, // Fortran: RQRCHS(2,2,JV,JH)
    rqroxs: [jh][jv][2][2]f32, // Fortran: RQROXS(2,2,JV,JH)
    rqrngs: [jh][jv][2][2]f32, // Fortran: RQRNGS(2,2,JV,JH)
    rqrn2s: [jh][jv][2][2]f32, // Fortran: RQRN2S(2,2,JV,JH)
    rqrhgs: [jh][jv][2][2]f32, // Fortran: RQRHGS(2,2,JV,JH)
    rqrnh4: [jh][jv][2][2]f32, // Fortran: RQRNH4(2,2,JV,JH)
    rqrnh3: [jh][jv][2][2]f32, // Fortran: RQRNH3(2,2,JV,JH)
    rqrno3: [jh][jv][2][2]f32, // Fortran: RQRNO3(2,2,JV,JH)
    rqrno2: [jh][jv][2][2]f32, // Fortran: RQRNO2(2,2,JV,JH)
    rqrh2p: [jh][jv][2][2]f32, // Fortran: RQRH2P(2,2,JV,JH)
    rqrh1p: [jh][jv][2][2]f32, // Fortran: RQRH1P(2,2,JV,JH)
    clsgl2: [jx][jy][jz + 1]f32, // Fortran: CLSGL2(0:JZ,JY,JX)
    cqsgl2: [jx][jy][jz + 1]f32, // Fortran: CQSGL2(0:JZ,JY,JX)
    olsgl2: [jx][jy][jz + 1]f32, // Fortran: OLSGL2(0:JZ,JY,JX)
    znsgl2: [jx][jy][jz + 1]f32, // Fortran: ZNSGL2(0:JZ,JY,JX)
    zlsgl2: [jx][jy][jz + 1]f32, // Fortran: ZLSGL2(0:JZ,JY,JX)
    zvsgl2: [jx][jy][jz + 1]f32, // Fortran: ZVSGL2(0:JZ,JY,JX)
    hlsgl2: [jx][jy][jz + 1]f32, // Fortran: HLSGL2(0:JZ,JY,JX)
    zosgl2: [jx][jy][jz + 1]f32, // Fortran: ZOSGL2(0:JZ,JY,JX)
    posgl2: [jx][jy][jz + 1]f32, // Fortran: POSGL2(0:JZ,JY,JX)
    r1bsk2: [jx][jy][jz]f32, // Fortran: R1BSK2(JZ,JY,JX)
    flwu: [jx][jy][jz]f32, // Fortran: FLWU(JZ,JY,JX)
    rqscos: [jh][jv][2]f32, // Fortran: RQSCOS(2,JV,JH)
    rqschs: [jh][jv][2]f32, // Fortran: RQSCHS(2,JV,JH)
    rqsoxs: [jh][jv][2]f32, // Fortran: RQSOXS(2,JV,JH)
    rqsngs: [jh][jv][2]f32, // Fortran: RQSNGS(2,JV,JH)
    rqsn2s: [jh][jv][2]f32, // Fortran: RQSN2S(2,JV,JH)
    rqsnh4: [jh][jv][2]f32, // Fortran: RQSNH4(2,JV,JH)
    rqsnh3: [jh][jv][2]f32, // Fortran: RQSNH3(2,JV,JH)
    rqsno3: [jh][jv][2]f32, // Fortran: RQSNO3(2,JV,JH)
    rqsh2p: [jh][jv][2]f32, // Fortran: RQSH2P(2,JV,JH)
    rqsh1p: [jh][jv][2]f32, // Fortran: RQSH1P(2,JV,JH)
    rcodfs: [jx][jy]f32, // Fortran: RCODFS(JY,JX)
    rchdfs: [jx][jy]f32, // Fortran: RCHDFS(JY,JX)
    roxdfs: [jx][jy]f32, // Fortran: ROXDFS(JY,JX)
    rngdfs: [jx][jy]f32, // Fortran: RNGDFS(JY,JX)
    rn2dfs: [jx][jy]f32, // Fortran: RN2DFS(JY,JX)
    rn3dfs: [jx][jy]f32, // Fortran: RN3DFS(JY,JX)
    rnbdfs: [jx][jy]f32, // Fortran: RNBDFS(JY,JX)
    rhgdfs: [jx][jy]f32, // Fortran: RHGDFS(JY,JX)
    rcodfr: [jx][jy]f32, // Fortran: RCODFR(JY,JX)
    rchdfr: [jx][jy]f32, // Fortran: RCHDFR(JY,JX)
    roxdfr: [jx][jy]f32, // Fortran: ROXDFR(JY,JX)
    rngdfr: [jx][jy]f32, // Fortran: RNGDFR(JY,JX)
    rn2dfr: [jx][jy]f32, // Fortran: RN2DFR(JY,JX)
    rn3dfr: [jx][jy]f32, // Fortran: RN3DFR(JY,JX)
    rhgdfr: [jx][jy]f32, // Fortran: RHGDFR(JY,JX)

    pub fn init() Blktrnsfr3 {
        return std.mem.zeroInit(Blktrnsfr3, .{});
    }
};
