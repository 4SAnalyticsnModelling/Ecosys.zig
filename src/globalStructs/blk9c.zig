const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jp = config.pftmax;

pub const Blk9c = struct {
    ehvst: [jx][jy][366][5][4][2]f32,
    hvst: [jx][jy][366][5]f32,
    thin: [jx][jy][366][5]f32,
    groupi: [jx][jy][jp]f32,
    ppi: [jx][jy][jp]f32,
    groupx: [jx][jy][jp]f32,
    rtfq: [jx][jy][jp]f32,
    sdpth: [jx][jy][jp]f32,
    sdvl: [jx][jy][jp]f32,
    sdlg: [jx][jy][jp]f32,
    sdar: [jx][jy][jp]f32,
    angbr: [jx][jy][jp]f32,
    angsh: [jx][jy][jp]f32,
    cnws: [jx][jy][jp]f32,
    cpws: [jx][jy][jp]f32,
    cwsrt: [jx][jy][jp]f32,
    wtstdi: [jx][jy][jp]f32,
    ppx: [jx][jy][jp]f32,
    portx: [jx][jy][jp][2]f32,
    iyr0: [jx][jy][jp]i32,
    iyrh: [jx][jy][jp]i32,
    iday0: [jx][jy][jp]i32,
    idayh: [jx][jy][jp]i32,
    ihvst: [jx][jy][366][5]i32,
    jhvst: [jx][jy][366][5]i32,
    idth: [jx][jy][jp]i32,
    iyrx: [jx][jy][jp]i32,
    idayx: [jx][jy][jp]i32,
    iyry: [jx][jy][jp]i32,
    idayy: [jx][jy][jp]i32,

    pub fn init() Blk9c {
        return std.mem.zeroInit(Blk9c, .{});
    }
};
