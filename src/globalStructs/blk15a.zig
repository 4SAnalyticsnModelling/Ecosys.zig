const std = @import("std");

pub const Blk15a = struct {
    qr: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    hqr: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    qs: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    qw: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    qi: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    hqs: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    flw: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    flwh: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    hflw: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xcofls: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xchfls: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xoxfls: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xngfls: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xn2fls: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xhgfls: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xn4flw: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xn3flw: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xnoflw: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xh2pfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xnxfb: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xocfls: comptime [jh][jv][jd + 1][3][5]f32 = std.mem.zeroes([jh][jv][jd + 1][3][5]f32),
    xonfls: comptime [jh][jv][jd + 1][3][5]f32 = std.mem.zeroes([jh][jv][jd + 1][3][5]f32),
    xchflg: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xh1pfs: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    flqrq: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    flqri: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    flqgq: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    flqgi: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    flwnu: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    flwxnu: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    flwhnu: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    hflwnu: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),

    pub fn init() Blk15a {
        return .{};
    }
};
