const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jh = jx + 1;
const jv = jy + 1;
const jd = jz + 1;

pub const Blk20c = struct {
    xalfhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xfeehs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xhyfhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xcafhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xmgfhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xnafhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xkafhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xohfhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xsofhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xclfhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xc3fhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xhcfhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xal1hs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xal2hs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xal3hs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xal4hs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xalshs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xfe1hs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xfe2hs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xfe3hs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xfe4hs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xfeshs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xcaohs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xcachs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xcahhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xcashs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xmgoofs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xmgchs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xmghhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xmgshs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xnachs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xnashs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xkashs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xh0phs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xh3phs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xf1phs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xf2phs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xc0phs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xc1phs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xc2phs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xm1phs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xh0bhb: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xh3bhb: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xf1bhb: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xf2bhb: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xc0bhb: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xc1bhb: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xc2bhb: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    xm1bhb: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),

    pub fn init() Blk20c {
        return .{};
    }
};
