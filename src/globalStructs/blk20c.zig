const std = @import("std");

pub const Blk20c = struct {
    xalfhs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xfeehs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xhyfhs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xcafhs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xmgfhs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xnafhs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xkafhs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xohfhs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xsofhs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xclfhs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xc3fhs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xhcfhs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xal1hs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xal2hs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xal3hs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xal4hs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xalshs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xfe1hs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xfe2hs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xfe3hs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xfe4hs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xfeshs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xcaohs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xcachs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xcahhs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xcashs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xmgoofs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xmgchs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xmghhs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xmgshs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xnachs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xnashs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xkashs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xh0phs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xh3phs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xf1phs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xf2phs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xc0phs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xc1phs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xc2phs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xm1phs: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xh0bhb: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xh3bhb: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xf1bhb: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xf2bhb: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xc0bhb: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xc1bhb: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xc2bhb: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xm1bhb: comptime [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),

    pub fn init() Blk20c {
        return .{};
    }
};
