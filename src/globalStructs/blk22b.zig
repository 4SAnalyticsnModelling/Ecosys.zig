const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const js = config.snowlayersmax;

pub const Blk22b = struct {
    rc2pfu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rm1pfu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rh0bbu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rh3bbu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rf1bbu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rf2bbu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rc0bbu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rc1bbu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rc2bbu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rm1bbu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xcobls: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xchbls: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xoxbls: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xngbls: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xn2bls: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xn4blw: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xn3blw: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xnoblw: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xh1pbs: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xh2pbs: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xalbls: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xfebls: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xhybls: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xcabls: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xmgbls: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xnabls: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xkabls: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xohbls: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xsobls: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xclbls: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xc3bls: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xhcbls: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xal1bs: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xal2bs: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xal3bs: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xal4bs: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xalsbs: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xfe1bs: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xfe2bs: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xfe3bs: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xfe4bs: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xfesbs: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xcaobs: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xcacbs: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xcahbs: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xcasbs: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xmgobs: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xmgcbs: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),
    xhgbls: [jx][jy][js]f32 = std.mem.zeroes([jx][jy][js]f32),

    pub fn init() Blk22b {
        return .{};
    }
};
