const std = @import("std");

pub const Blktrnsfr11 = struct {
    rfloc: [5]f32,
    rflon: [5]f32,
    rflop: [5]f32,
    rfloa: [5]f32,
    rfhoc: [5]f32,
    rfhon: [5]f32,
    rfhop: [5]f32,
    rfhoa: [5]f32,
    coqc1: [5]f32,
    coqc2: [5]f32,
    coqn1: [5]f32,
    coqn2: [5]f32,
    coqp1: [5]f32,
    coqp2: [5]f32,
    coqa1: [5]f32,
    coqa2: [5]f32,
    coqch1: [5]f32,
    coqch2: [5]f32,
    coqnh1: [5]f32,
    coqnh2: [5]f32,
    coqph1: [5]f32,
    coqph2: [5]f32,
    coqah1: [5]f32,
    coqah2: [5]f32,
    dfvoc: [5]f32,
    dfvon: [5]f32,
    dfvop: [5]f32,
    dfvoa: [5]f32,
    dfhoc: [5]f32,
    dfhon: [5]f32,
    dfhop: [5]f32,
    dfhoa: [5]f32,

    pub fn init() Blktrnsfr11 {
        return std.mem.zeroInit(Blktrnsfr11, .{});
    }
};
