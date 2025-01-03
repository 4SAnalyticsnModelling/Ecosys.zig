const std = @import("std");

pub const Blk9c = struct {
    hvst: comptime [jx][jy][366][5]f32 = std.mem.zeroes([jx][jy][366][5]f32),
    groupi: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    ppi: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    groupx: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    rtfq: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    sdpth: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    sdvl: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    sdlg: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    sdar: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    angbr: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    angsh: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    cnws: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    cpws: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    cwsrt: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    wtstdi: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    ppx: comptime [jx][jy][jp]f32 = std.mem.zeroes([jx][jy][jp]f32),
    thin: comptime [jx][jy][366][5]f32 = std.mem.zeroes([jx][jy][366][5]f32),
    ehvst: comptime [jx][jy][366][5][4][2]f32 = std.mem.zeroes([jx][jy][366][5][4][2]f32),
    portx: comptime [jx][jy][jp][2]f32 = std.mem.zeroes([jx][jy][jp][2]f32),
    iyr0: comptime [jx][jy][jp]i32 = std.mem.zeroes([jx][jy][jp]i32),
    iyrh: comptime [jx][jy][jp]i32 = std.mem.zeroes([jx][jy][jp]i32),
    iday0: comptime [jx][jy][jp]i32 = std.mem.zeroes([jx][jy][jp]i32),
    idayh: comptime [jx][jy][jp]i32 = std.mem.zeroes([jx][jy][jp]i32),
    ihvst: comptime [jx][jy][366][5]i32 = std.mem.zeroes([jx][jy][366][5]i32),
    jhvst: comptime [jx][jy][366][5]i32 = std.mem.zeroes([jx][jy][366][5]i32),
    idth: comptime [jx][jy][jp]i32 = std.mem.zeroes([jx][jy][jp]i32),
    iyrx: comptime [jx][jy][jp]i32 = std.mem.zeroes([jx][jy][jp]i32),
    idayx: comptime [jx][jy][jp]i32 = std.mem.zeroes([jx][jy][jp]i32),
    iyry: comptime [jx][jy][jp]i32 = std.mem.zeroes([jx][jy][jp]i32),
    idayy: comptime [jx][jy][jp]i32 = std.mem.zeroes([jx][jy][jp]i32),

    pub fn init() Blk9c {
        return .{};
    }
};
