const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blk18b = struct {
    roqcx: [jx][jy][jz + 1][5]f32,
    roqcy: [jx][jy][jz + 1][5]f32,
    roqax: [jx][jy][jz + 1][5]f32,
    roqay: [jx][jy][jz + 1][5]f32,
    roxyx: [jx][jy][jz + 1]f32,
    roxyy: [jx][jy][jz + 1]f32,
    rnh4x: [jx][jy][jz + 1]f32,
    rnh4y: [jx][jy][jz + 1]f32,
    rno3x: [jx][jy][jz + 1]f32,
    rno3y: [jx][jy][jz + 1]f32,
    rno2x: [jx][jy][jz + 1]f32,
    rno2y: [jx][jy][jz + 1]f32,
    rpo4x: [jx][jy][jz + 1]f32,
    rpo4y: [jx][jy][jz + 1]f32,
    rn2ox: [jx][jy][jz + 1]f32,
    rn2oy: [jx][jy][jz + 1]f32,
    rnhbx: [jx][jy][jz + 1]f32,
    rnhby: [jx][jy][jz + 1]f32,
    rn3bx: [jx][jy][jz + 1]f32,
    rn3by: [jx][jy][jz + 1]f32,
    rn2bx: [jx][jy][jz + 1]f32,
    rn2by: [jx][jy][jz + 1]f32,
    rpobx: [jx][jy][jz + 1]f32,
    rpoby: [jx][jy][jz + 1]f32,
    rp14x: [jx][jy][jz + 1]f32,
    rp14y: [jx][jy][jz + 1]f32,
    rp1bx: [jx][jy][jz + 1]f32,
    rp1by: [jx][jy][jz + 1]f32,
    tuphgs: [jx][jy][jz]f32,
    thgfla: [jx][jy][jz]f32,
    tlh2gp: [jx][jy][jz]f32,
    th2gz: [jx][jy]f32,
    tcan: [jx][jy]f32,
    trn: [jx][jy]f32,
    tle: [jx][jy]f32,
    tsh: [jx][jy]f32,
    tgh: [jx][jy]f32,
    tgpp: [jx][jy]f32,
    trau: [jx][jy]f32,
    tnpp: [jx][jy]f32,
    thre: [jx][jy]f32,
    xhvstc: [jx][jy]f32,
    xhvstn: [jx][jy]f32,
    xhvstp: [jx][jy]f32,
    iflgt: [jx][jy]f32,
    trinh4: [jx][jy]f32,
    tripo4: [jx][jy]f32,

    pub fn init() Blk18b {
        return std.mem.zeroInit(Blk18b, .{});
    }
};
