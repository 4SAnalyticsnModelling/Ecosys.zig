const std = @import("std");

pub const Blk1s = struct {
    rczlx: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    rcplx: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    rcclx: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wglfx: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wglfnx: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wglfpx: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    arlfz: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    rczsx: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    rcpsx: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    rccsx: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wgshex: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wgshnx: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wgshpx: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    htshex: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wtstxb: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wtstxn: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),
    wtstxp: comptime [jx][jy][jp][jc]f32 = std.mem.zeroes([jx][jy][jp][jc]f32),

    pub fn init() Blk1s {
        return .{};
    }
};
