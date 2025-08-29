const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blktrnsfr7 = struct {
    oqch2: [jx][jy][jz][5]f32, // Fortran: OQCH2(0:4,JZ,JY,JX)
    oqnh2: [jx][jy][jz][5]f32, // Fortran: OQNH2(0:4,JZ,JY,JX)
    oqph2: [jx][jy][jz][5]f32, // Fortran: OQPH2(0:4,JZ,JY,JX)
    oqah2: [jx][jy][jz][5]f32, // Fortran: OQAH2(0:4,JZ,JY,JX)
    tocfhs: [jx][jy][jz][5]f32, // Fortran: TOCFHS(0:4,JZ,JY,JX)
    tonfhs: [jx][jy][jz][5]f32, // Fortran: TONFHS(0:4,JZ,JY,JX)
    topfhs: [jx][jy][jz][5]f32, // Fortran: TOPFHS(0:4,JZ,JY,JX)
    toafhs: [jx][jy][jz][5]f32, // Fortran: TOAFHS(0:4,JZ,JY,JX)
    co2sh2: [jx][jy][jz]f32, // Fortran: CO2SH2(JZ,JY,JX)
    ch4sh2: [jx][jy][jz]f32, // Fortran: CH4SH2(JZ,JY,JX)
    oxysh2: [jx][jy][jz]f32, // Fortran: OXYSH2(JZ,JY,JX)
    z2gsh2: [jx][jy][jz]f32, // Fortran: Z2GSH2(JZ,JY,JX)
    z2osh2: [jx][jy][jz]f32, // Fortran: Z2OSH2(JZ,JY,JX)
    znh4h2: [jx][jy][jz]f32, // Fortran: ZNH4H2(JZ,JY,JX)
    zn4bh2: [jx][jy][jz]f32, // Fortran: ZN4BH2(JZ,JY,JX)
    znh3h2: [jx][jy][jz]f32, // Fortran: ZNH3H2(JZ,JY,JX)
    zn3bh2: [jx][jy][jz]f32, // Fortran: ZN3BH2(JZ,JY,JX)
    zno3h2: [jx][jy][jz]f32, // Fortran: ZNO3H2(JZ,JY,JX)
    znobh2: [jx][jy][jz]f32, // Fortran: ZNOBH2(JZ,JY,JX)
    h2p4h2: [jx][jy][jz]f32, // Fortran: H2P4H2(JZ,JY,JX)
    h2pbh2: [jx][jy][jz]f32, // Fortran: H2PBH2(JZ,JY,JX)
    zno2h2: [jx][jy][jz]f32, // Fortran: ZNO2H2(JZ,JY,JX)
    tcofhs: [jx][jy][jz]f32, // Fortran: TCOFHS(JZ,JY,JX)
    tchfhs: [jx][jy][jz]f32, // Fortran: TCHFHS(JZ,JY,JX)
    toxfhs: [jx][jy][jz]f32, // Fortran: TOXFHS(JZ,JY,JX)
    tngfhs: [jx][jy][jz]f32, // Fortran: TNGFHS(JZ,JY,JX)
    tn2fhs: [jx][jy][jz]f32, // Fortran: TN2FHS(JZ,JY,JX)
    tn4fhw: [jx][jy][jz]f32, // Fortran: TN4FHW(JZ,JY,JX)
    tn3fhw: [jx][jy][jz]f32, // Fortran: TN3FHW(JZ,JY,JX)
    tnofhw: [jx][jy][jz]f32, // Fortran: TNOFHW(JZ,JY,JX)
    th2phs: [jx][jy][jz]f32, // Fortran: TH2PHS(JZ,JY,JX)
    tn4fhb: [jx][jy][jz]f32, // Fortran: TN4FHB(JZ,JY,JX)
    tn3fhb: [jx][jy][jz]f32, // Fortran: TN3FHB(JZ,JY,JX)
    tnofhb: [jx][jy][jz]f32, // Fortran: TNOFHB(JZ,JY,JX)
    th2bhb: [jx][jy][jz]f32, // Fortran: TH2BHB(JZ,JY,JX)
    tnxfhs: [jx][jy][jz]f32, // Fortran: TNXFHS(JZ,JY,JX)
    zno2b2: [jx][jy][jz]f32, // Fortran: ZNO2B2(JZ,JY,JX)
    zn2bh2: [jx][jy][jz]f32, // Fortran: ZN2BH2(JZ,JY,JX)
    tnxflb: [jx][jy][jz]f32, // Fortran: TNXFLB(JZ,JY,JX)
    tnxfhb: [jx][jy][jz]f32, // Fortran: TNXFHB(JZ,JY,JX)
    h1p4h2: [jx][jy][jz]f32, // Fortran: H1P4H2(JZ,JY,JX)
    h1pbh2: [jx][jy][jz]f32, // Fortran: H1PBH2(JZ,JY,JX)
    th1phs: [jx][jy][jz]f32, // Fortran: TH1PHS(JZ,JY,JX)
    th1bhb: [jx][jy][jz]f32, // Fortran: TH1BHB(JZ,JY,JX)

    pub fn init() Blktrnsfr7 {
        return std.mem.zeroInit(Blktrnsfr7, .{});
    }
};
