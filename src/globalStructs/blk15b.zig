const std = @import("std");

pub const Blk15b = struct {
    xcofhs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xchfhs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xoxfhs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xngfhs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xn2fhs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xhgfhs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xn4fhw: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xn3fhw: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xnofhw: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xh2phs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xnxfhs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xn4fhb: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xn3fhb: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xnofhb: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xnxfhb: comptime [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    xh2bhb: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xocfhs: comptime [jh][jv][jd][3][5]f32 = std.mem.zeroes([jh][jv][jd][3][5]f32),
    xonfhs: comptime [jh][jv][jd][3][5]f32 = std.mem.zeroes([jh][jv][jd][3][5]f32),
    xopfhs: comptime [jh][jv][jd][3][5]f32 = std.mem.zeroes([jh][jv][jd][3][5]f32),
    xoafhs: comptime [jh][jv][jd][3][5]f32 = std.mem.zeroes([jh][jv][jd][3][5]f32),
    flwx: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xh1phs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xh1bhb: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),

    pub fn init() Blk15b {
        return .{};
    }
};
