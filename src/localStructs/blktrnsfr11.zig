const std = @import("std");

pub const Blktrnsfr11 = struct {
    rfloc: [5]f32, // Fortran: RFLOC(0:4)
    rflon: [5]f32, // Fortran: RFLON(0:4)
    rflop: [5]f32, // Fortran: RFLOP(0:4)
    rfloa: [5]f32, // Fortran: RFLOA(0:4)
    rfhoc: [5]f32, // Fortran: RFHOC(0:4)
    rfhon: [5]f32, // Fortran: RFHON(0:4)
    rfhop: [5]f32, // Fortran: RFHOP(0:4)
    rfhoa: [5]f32, // Fortran: RFHOA(0:4)
    coqc1: [5]f32, // Fortran: COQC1(0:4)
    coqc2: [5]f32, // Fortran: COQC2(0:4)
    coqn1: [5]f32, // Fortran: COQN1(0:4)
    coqn2: [5]f32, // Fortran: COQN2(0:4)
    coqp1: [5]f32, // Fortran: COQP1(0:4)
    coqp2: [5]f32, // Fortran: COQP2(0:4)
    coqa1: [5]f32, // Fortran: COQA1(0:4)
    coqa2: [5]f32, // Fortran: COQA2(0:4)
    coqch1: [5]f32, // Fortran: COQCH1(0:4)
    coqch2: [5]f32, // Fortran: COQCH2(0:4)
    coqnh1: [5]f32, // Fortran: COQNH1(0:4)
    coqnh2: [5]f32, // Fortran: COQNH2(0:4)
    coqph1: [5]f32, // Fortran: COQPH1(0:4)
    coqph2: [5]f32, // Fortran: COQPH2(0:4)
    coqah1: [5]f32, // Fortran: COQAH1(0:4)
    coqah2: [5]f32, // Fortran: COQAH2(0:4)
    dfvoc: [5]f32, // Fortran: DFVOC(0:4)
    dfvon: [5]f32, // Fortran: DFVON(0:4)
    dfvop: [5]f32, // Fortran: DFVOP(0:4)
    dfvoa: [5]f32, // Fortran: DFVOA(0:4)
    dfhoc: [5]f32, // Fortran: DFHOC(0:4)
    dfhon: [5]f32, // Fortran: DFHON(0:4)
    dfhop: [5]f32, // Fortran: DFHOP(0:4)
    dfhoa: [5]f32, // Fortran: DFHOA(0:4)

    pub fn init() Blktrnsfr11 {
        return std.mem.zeroInit(Blktrnsfr11, .{});
    }
};
