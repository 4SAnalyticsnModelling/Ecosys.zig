const std = @import("std");

pub const Blk15a = struct {
    qr: [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    hqr: [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    qs: [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    qw: [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    qi: [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    hqs: [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    flw: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    flwh: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    hflw: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xcofls: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xchfls: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xoxfls: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xngfls: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xn2fls: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xhgfls: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xn4flw: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xn3flw: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xnoflw: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xh2pfs: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xnxfb: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xocfls: [jh][jv][jd + 1][3][5]f32 = std.mem.zeroes([jh][jv][jd + 1][3][5]f32),
    xonfls: [jh][jv][jd + 1][3][5]f32 = std.mem.zeroes([jh][jv][jd + 1][3][5]f32),
    xchflg: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xh1pfs: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    flqrq: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    flqri: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    flqgq: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    flqgi: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    flwnu: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    flwxnu: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    flwhnu: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    hflwnu: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),

    pub fn init() Blk15a {
        return .{};
    }
};
