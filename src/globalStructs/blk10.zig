const std = @import("std");

pub const Blk10 = struct {
    parr: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    parg: comptime [jx][jy][60]f32 = std.mem.zeroes([jx][jy][60]f32),
    flwm: comptime [jh][jv][jd][3][60]f32 = std.mem.zeroes([jh][jv][jd][3][60]f32),
    flwhm: comptime [jh][jv][jd][3][60]f32 = std.mem.zeroes([jh][jv][jd][3][60]f32),
    qrmn: comptime [jh][jv][2][2][60]f32 = std.mem.zeroes([jh][jv][2][2][60]f32),
    qsm: comptime [jh][jv][2][60]f32 = std.mem.zeroes([jh][jv][2][60]f32),
    volwm: comptime [jx][jy][jz + 1][60]f32 = std.mem.zeroes([jx][jy][jz + 1][60]f32),
    volwhm: comptime [jx][jy][jz][60]f32 = std.mem.zeroes([jx][jy][jz][60]f32),
    volpm: comptime [jx][jy][jz + 1][60]f32 = std.mem.zeroes([jx][jy][jz + 1][60]f32),
    film: comptime [jx][jy][jz + 1][60]f32 = std.mem.zeroes([jx][jy][jz + 1][60]f32),
    engypm: comptime [jx][jy][60]f32 = std.mem.zeroes([jx][jy][60]f32),
    xvoltm: comptime [jx][jy][60]f32 = std.mem.zeroes([jx][jy][60]f32),
    xvolwm: comptime [jx][jy][60]f32 = std.mem.zeroes([jx][jy][60]f32),
    xvolim: comptime [jx][jy][60]f32 = std.mem.zeroes([jx][jy][60]f32),
    roxsk: comptime [jx][jy][jz + 1][60]f32 = std.mem.zeroes([jx][jy][jz + 1][60]f32),
    flwrm: comptime [jx][jy][60]f32 = std.mem.zeroes([jx][jy][60]f32),
    flpm: comptime [jx][jy][jz][60]f32 = std.mem.zeroes([jx][jy][jz][60]f32),
    finhm: comptime [jx][jy][jz][60]f32 = std.mem.zeroes([jx][jy][jz][60]f32),
    thetpm: comptime [jx][jy][jz + 1][60]f32 = std.mem.zeroes([jx][jy][jz + 1][60]f32),
    tort: comptime [jx][jy][jz + 1][60]f32 = std.mem.zeroes([jx][jy][jz + 1][60]f32),
    torth: comptime [jx][jy][jz][60]f32 = std.mem.zeroes([jx][jy][jz][60]f32),
    flqrm: comptime [jx][jy][60]f32 = std.mem.zeroes([jx][jy][60]f32),
    flqsm: comptime [jx][jy][60]f32 = std.mem.zeroes([jx][jy][60]f32),
    flqhm: comptime [jx][jy][60]f32 = std.mem.zeroes([jx][jy][60]f32),
    flqwm: comptime [jx][jy][js][60]f32 = std.mem.zeroes([jx][jy][js][60]f32),
    vhcpwm: comptime [jx][jy][js][60]f32 = std.mem.zeroes([jx][jy][js][60]f32),
    dfgs: comptime [jx][jy][jz + 1][60]f32 = std.mem.zeroes([jx][jy][jz + 1][60]f32),
    qrm: comptime [jh][jv][60]f32 = std.mem.zeroes([jh][jv][60]f32),
    qrv: comptime [jx][jy][60]f32 = std.mem.zeroes([jx][jy][60]f32),
    iflbm: comptime [jx][jy][2][2][60]i32 = std.mem.zeroes([jx][jy][2][2][60]i32),

    pub fn init() Blk10 {
        return .{};
    }
};
