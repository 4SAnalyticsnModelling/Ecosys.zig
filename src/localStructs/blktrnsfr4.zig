const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jh = jx + 1;
const jv = jy + 1;
const jd = jz + 1;

pub const Blktrnsfr4 = struct {
    rcofls: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    rchfls: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    roxfls: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    rngfls: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    rn2fls: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    rhgfls: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    rn4flw: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    rn3flw: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    rnoflw: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    rnxfls: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    rh2pfs: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    rn4flb: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    rn3flb: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    rnoflb: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    rnxflb: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    rh2bfb: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    rcofhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    rchfhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    roxfhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    rngfhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    rn2fhs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    rn4fhw: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    rn3fhw: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    rnofhw: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    rh2phs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    rn4fhb: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    rn3fhb: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    rnofhb: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    rh2bhb: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    rocfls: [jh][jv][jd + 1][3][5]f32 = std.mem.zeroes([jh][jv][jd + 1][3][5]f32),
    ronfls: [jh][jv][jd + 1][3][5]f32 = std.mem.zeroes([jh][jv][jd + 1][3][5]f32),
    ropfls: [jh][jv][jd + 1][3][5]f32 = std.mem.zeroes([jh][jv][jd + 1][3][5]f32),
    roafls: [jh][jv][jd + 1][3][5]f32 = std.mem.zeroes([jh][jv][jd + 1][3][5]f32),
    rocfhs: [jh][jv][jd][3][5]f32 = std.mem.zeroes([jh][jv][jd][3][5]f32),
    ronfhs: [jh][jv][jd][3][5]f32 = std.mem.zeroes([jh][jv][jd][3][5]f32),
    ropfhs: [jh][jv][jd][3][5]f32 = std.mem.zeroes([jh][jv][jd][3][5]f32),
    roafhs: [jh][jv][jd][3][5]f32 = std.mem.zeroes([jh][jv][jd][3][5]f32),
    roxflg: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    rn3flg: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    rcoflg: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    rchflg: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    rngflg: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    rn2flg: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    rnxfhb: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    rh1pfs: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    rh1bfb: [jh][jv][jd + 1][3]f32 = std.mem.zeroes([jh][jv][jd + 1][3]f32),
    rh1phs: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),
    rh1bhb: [jh][jv][jd][3]f32 = std.mem.zeroes([jh][jv][jd][3]f32),

    pub fn init() Blktrnsfr4 {
        return .{};
    }
};
