const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jh = jx + 1;
const jv = jy + 1;

pub const Blk20f = struct {
    omcer: [jh][jv][2][2][6][7][3]f32, // Fortran: OMCER(3,7,0:5,2,2,JV,JH)
    omner: [jh][jv][2][2][6][7][3]f32, // Fortran: OMNER(3,7,0:5,2,2,JV,JH)
    omper: [jh][jv][2][2][6][7][3]f32, // Fortran: OMPER(3,7,0:5,2,2,JV,JH)
    orcer: [jh][jv][2][2][5][4]f32, // Fortran: ORCER(2,0:4,2,2,JV,JH)
    orner: [jh][jv][2][2][5][4]f32, // Fortran: ORNER(2,0:4,2,2,JV,JH)
    orper: [jh][jv][2][2][5][4]f32, // Fortran: ORPER(2,0:4,2,2,JV,JH)
    oscer: [jh][jv][2][2][5][4]f32, // Fortran: OSCER(4,0:4,2,2,JV,JH)
    osaer: [jh][jv][2][2][5][4]f32, // Fortran: OSAER(4,0:4,2,2,JV,JH)
    osner: [jh][jv][2][2][5][4]f32, // Fortran: OSNER(4,0:4,2,2,JV,JH)
    osper: [jh][jv][2][2][5][4]f32, // Fortran: OSPER(4,0:4,2,2,JV,JH)
    ohcer: [jh][jv][2][2][5]f32, // Fortran: OHCER(0:4,2,2,JV,JH)
    ohner: [jh][jv][2][2][5]f32, // Fortran: OHNER(0:4,2,2,JV,JH)
    ohper: [jh][jv][2][2][5]f32, // Fortran: OHPER(0:4,2,2,JV,JH)
    ohaer: [jh][jv][2][2][5]f32, // Fortran: OHAER(0:4,2,2,JV,JH)
    xsaner: [jh][jv][2][2]f32, // Fortran: XSANER(2,2,JV,JH)
    xsiler: [jh][jv][2][2]f32, // Fortran: XSILER(2,2,JV,JH)
    xclaer: [jh][jv][2][2]f32, // Fortran: XCLAER(2,2,JV,JH)
    xcecer: [jh][jv][2][2]f32, // Fortran: XCECER(2,2,JV,JH)
    xaecer: [jh][jv][2][2]f32, // Fortran: XAECER(2,2,JV,JH)
    xnh4er: [jh][jv][2][2]f32, // Fortran: XNH4ER(2,2,JV,JH)
    xnh3er: [jh][jv][2][2]f32, // Fortran: XNH3ER(2,2,JV,JH)
    xnhuer: [jh][jv][2][2]f32, // Fortran: XNHUER(2,2,JV,JH)
    xno3er: [jh][jv][2][2]f32, // Fortran: XNO3ER(2,2,JV,JH)
    xnh4eb: [jh][jv][2][2]f32, // Fortran: XNH4EB(2,2,JV,JH)
    xnh3eb: [jh][jv][2][2]f32, // Fortran: XNH3EB(2,2,JV,JH)
    xnhueb: [jh][jv][2][2]f32, // Fortran: XNHUEB(2,2,JV,JH)
    xno3eb: [jh][jv][2][2]f32, // Fortran: XNO3EB(2,2,JV,JH)
    xn4er: [jh][jv][2][2]f32, // Fortran: XN4ER(2,2,JV,JH)
    xnber: [jh][jv][2][2]f32, // Fortran: XNBER(2,2,JV,JH)
    xhyer: [jh][jv][2][2]f32, // Fortran: XHYER(2,2,JV,JH)
    xaler: [jh][jv][2][2]f32, // Fortran: XALER(2,2,JV,JH)
    xcaer: [jh][jv][2][2]f32, // Fortran: XCAER(2,2,JV,JH)
    xmger: [jh][jv][2][2]f32, // Fortran: XMGER(2,2,JV,JH)
    xnaer: [jh][jv][2][2]f32, // Fortran: XNAER(2,2,JV,JH)
    xkaer: [jh][jv][2][2]f32, // Fortran: XKAER(2,2,JV,JH)
    xhcer: [jh][jv][2][2]f32, // Fortran: XHCER(2,2,JV,JH)
    xal2er: [jh][jv][2][2]f32, // Fortran: XAL2ER(2,2,JV,JH)
    xoh0er: [jh][jv][2][2]f32, // Fortran: XOH0ER(2,2,JV,JH)
    xoh1er: [jh][jv][2][2]f32, // Fortran: XOH1ER(2,2,JV,JH)
    xoh2er: [jh][jv][2][2]f32, // Fortran: XOH2ER(2,2,JV,JH)
    xh1per: [jh][jv][2][2]f32, // Fortran: XH1PER(2,2,JV,JH)
    xh2per: [jh][jv][2][2]f32, // Fortran: XH2PER(2,2,JV,JH)
    xoh0eb: [jh][jv][2][2]f32, // Fortran: XOH0EB(2,2,JV,JH)
    xoh1eb: [jh][jv][2][2]f32, // Fortran: XOH1EB(2,2,JV,JH)
    xoh2eb: [jh][jv][2][2]f32, // Fortran: XOH2EB(2,2,JV,JH)
    xh1peb: [jh][jv][2][2]f32, // Fortran: XH1PEB(2,2,JV,JH)
    xh2peb: [jh][jv][2][2]f32, // Fortran: XH2PEB(2,2,JV,JH)
    paloer: [jh][jv][2][2]f32, // Fortran: PALOER(2,2,JV,JH)
    pfeoer: [jh][jv][2][2]f32, // Fortran: PFEOER(2,2,JV,JH)
    pcacer: [jh][jv][2][2]f32, // Fortran: PCACER(2,2,JV,JH)
    pcaser: [jh][jv][2][2]f32, // Fortran: PCASER(2,2,JV,JH)
    palper: [jh][jv][2][2]f32, // Fortran: PALPER(2,2,JV,JH)
    pfeper: [jh][jv][2][2]f32, // Fortran: PFEPER(2,2,JV,JH)
    pcpder: [jh][jv][2][2]f32, // Fortran: PCPDER(2,2,JV,JH)
    pcpherb: [jh][jv][2][2]f32, // Fortran: PCPHERB(2,2,JV,JH)
    pcpmer: [jh][jv][2][2]f32, // Fortran: PCPMER(2,2,JV,JH)
    palpeb: [jh][jv][2][2]f32, // Fortran: PALPEB(2,2,JV,JH)
    pfepeb: [jh][jv][2][2]f32, // Fortran: PFEPEB(2,2,JV,JH)
    pcpdeb: [jh][jv][2][2]f32, // Fortran: PCPDEB(2,2,JV,JH)
    pcpmeb: [jh][jv][2][2]f32, // Fortran: PCPMEB(2,2,JV,JH)
    xfe2er: [jh][jv][2][2]f32, // Fortran: XFE2ER(2,2,JV,JH)
    xseder: [jh][jv][2][2]f32, // Fortran: XSEDER(2,2,JV,JH)
    xfeer: [jh][jv][2][2]f32, // Fortran: XFEER(2,2,JV,JH)

    pub fn init() Blk20f {
        return std.mem.zeroInit(Blk20f, .{});
    }
};
