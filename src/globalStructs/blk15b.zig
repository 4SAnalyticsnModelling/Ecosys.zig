const std = @import("std");

pub const Blk15b = struct {
    xcofhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xchfhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xoxfhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xngfhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xn2fhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xhgfhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xn4fhw: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xn3fhw: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xnofhw: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xh2phs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xnxfhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xn4fhb: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xn3fhb: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xnofhb: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xnxfhb: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xh2bhb: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xocfhs: [jh][jv][jd][3][5]f32 = std.mem.zeroes([jh][jv][jd][3][5]f32),
    xonfhs: [jh][jv][jd][3][5]f32 = std.mem.zeroes([jh][jv][jd][3][5]f32),
    xopfhs: [jh][jv][jd][3][5]f32 = std.mem.zeroes([jh][jv][jd][3][5]f32),
    xoafhs: [jh][jv][jd][3][5]f32 = std.mem.zeroes([jh][jv][jd][3][5]f32),
    flwx: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xh1phs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xh1bhb: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),

    pub fn init() Blk15b {
        return .{};
    }
};
