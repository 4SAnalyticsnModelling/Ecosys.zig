const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blk13c = struct {
    cfosc: [jx][jy][jz + 1][6][4]f32 = std.mem.zeroes([jx][jy][jz + 1][6][4]f32),
    cnos: [jx][jy][jz + 1][6][4]f32 = std.mem.zeroes([jx][jy][jz + 1][6][4]f32),
    cposc: [jx][jy][jz + 1][6][4]f32 = std.mem.zeroes([jx][jy][jz + 1][6][4]f32),
    xoqcs: [jx][jy][jz + 1][6]f32 = std.mem.zeroes([jx][jy][jz + 1][6]f32),
    xoqns: [jx][jy][jz + 1][6]f32 = std.mem.zeroes([jx][jy][jz + 1][6]f32),
    xoqps: [jx][jy][jz + 1][6]f32 = std.mem.zeroes([jx][jy][jz + 1][6]f32),
    xoqas: [jx][jy][jz + 1][6]f32 = std.mem.zeroes([jx][jy][jz + 1][6]f32),
    cnomc: [6][7][3]f32 = std.mem.zeroes([6][7][3]f32),
    cpomc: [6][7][3]f32 = std.mem.zeroes([6][7][3]f32),
    xnh4s: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    xno3s: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    xh2ps: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    xnh4b: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    xno3b: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    xn2gs: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    xh2bs: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    vlnh4: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    vlnhb: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    vlno3: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    vlnob: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    vlpo4: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    vlpob: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    wdnhb: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    dpnhb: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    wdnob: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    dpnob: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    wdpo4: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    dppo4: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    dpnh4: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    dpno3: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    fl: [2]f32 = std.mem.zeroes([2]f32),
    rinho: [jx][jy][jz + 1][6][7]f32 = std.mem.zeroes([jx][jy][jz + 1][6][7]f32),
    rinoo: [jx][jy][jz + 1][6][7]f32 = std.mem.zeroes([jx][jy][jz + 1][6][7]f32),
    ripoo: [jx][jy][jz + 1][6][7]f32 = std.mem.zeroes([jx][jy][jz + 1][6][7]f32),
    h2gsh: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    xcodfr: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    xchdfr: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    xoxdfr: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    xngdfr: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    xn2dfr: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    xn3dfr: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    xhgfr: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rvmb2: [jx][jy][jz + 1][6][7]f32 = std.mem.zeroes([jx][jy][jz + 1][6][7]f32),
    rvmb3: [jx][jy][jz + 1][6][7]f32 = std.mem.zeroes([jx][jy][jz + 1][6][7]f32),
    rvmb4: [jx][jy][jz + 1][6][7]f32 = std.mem.zeroes([jx][jy][jz + 1][6][7]f32),
    rvmbc: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rvmxc: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    ch2gg: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    xzhys: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),

    pub fn init() Blk13c {
        return .{};
    }
};
