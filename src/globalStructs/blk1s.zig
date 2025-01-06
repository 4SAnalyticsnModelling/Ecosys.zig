const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jp = config.pftmax;
const jc = config.canopymax;

pub const Blk1s = struct {
    rczlx: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    rcplx: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    rcclx: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wglfx: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wglfnx: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wglfpx: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    arlfz: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    rczsx: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    rcpsx: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    rccsx: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wgshex: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wgshnx: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wgshpx: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    htshex: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wtstxb: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wtstxn: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wtstxp: [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),

    pub fn init() Blk1s {
        return .{};
    }
};
