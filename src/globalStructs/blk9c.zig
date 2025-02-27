const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jp = config.pftmax;

pub const Blk9c = struct {
    ehvst: [jx][jy][366][5][4][2]f32, // Fortran: EHVST(2,4,05,366,JY,JX)
    hvst: [jx][jy][366][5]f32, // Fortran: HVST(05,366,JY,JX)
    thin: [jx][jy][366][5]f32, // Fortran: THIN(05,366,JY,JX)
    portx: [jx][jy][jp][2]f32, // Fortran: PORTX(2,JP,JY,JX)
    ihvst: [jx][jy][366][5]i32, // Fortran: IHVST(05,366,JY,JX)
    jhvst: [jx][jy][366][5]i32, // Fortran: JHVST(05,366,JY,JX)
    groupi: [jx][jy][jp]f32, // Fortran: GROUPI(JP,JY,JX)
    ppi: [jx][jy][jp]f32, // Fortran: PPI(JP,JY,JX)
    groupx: [jx][jy][jp]f32, // Fortran: GROUPX(JP,JY,JX)
    rtfq: [jx][jy][jp]f32, // Fortran: RTFQ(JP,JY,JX)
    sdpth: [jx][jy][jp]f32, // Fortran: SDPTH(JP,JY,JX)
    sdvl: [jx][jy][jp]f32, // Fortran: SDVL(JP,JY,JX)
    sdlg: [jx][jy][jp]f32, // Fortran: SDLG(JP,JY,JX)
    sdar: [jx][jy][jp]f32, // Fortran: SDAR(JP,JY,JX)
    angbr: [jx][jy][jp]f32, // Fortran: ANGBR(JP,JY,JX)
    angsh: [jx][jy][jp]f32, // Fortran: ANGSH(JP,JY,JX)
    cnws: [jx][jy][jp]f32, // Fortran: CNWS(JP,JY,JX)
    cpws: [jx][jy][jp]f32, // Fortran: CPWS(JP,JY,JX)
    cwsrt: [jx][jy][jp]f32, // Fortran: CWSRT(JP,JY,JX)
    wtstdi: [jx][jy][jp]f32, // Fortran: WTSTDI(JP,JY,JX)
    ppx: [jx][jy][jp]f32, // Fortran: PPX(JP,JY,JX)
    iyr0: [jx][jy][jp]i32, // Fortran: IYR0(JP,JY,JX)
    iyrh: [jx][jy][jp]i32, // Fortran: IYRH(JP,JY,JX)
    iday0: [jx][jy][jp]i32, // Fortran: IDAY0(JP,JY,JX)
    idayh: [jx][jy][jp]i32, // Fortran: IDAYH(JP,JY,JX)
    idth: [jx][jy][jp]i32, // Fortran: IDTH(JP,JY,JX)
    iyrx: [jx][jy][jp]i32, // Fortran: IYRX(JP,JY,JX)
    idayx: [jx][jy][jp]i32, // Fortran: IDAYX(JP,JY,JX)
    iyry: [jx][jy][jp]i32, // Fortran: IYRY(JP,JY,JX)
    idayy: [jx][jy][jp]i32, // Fortran: IDAYY(JP,JY,JX)

    pub fn init() Blk9c {
        return std.mem.zeroInit(Blk9c, .{});
    }
};
