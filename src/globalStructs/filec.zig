const std = @import("std");

pub const Filec = struct {
    cdate: [10]u8, // Fortran: CDATE
    prefix: [10]u8, // Fortran: PREFIX
    data: f32, // Fortran: DATA
    datac: f32, // Fortran: DATAC
    datap: f32, // Fortran: DATAP
    datam: f32, // Fortran: DATAM
    datax: f32, // Fortran: DATAX
    datay: f32, // Fortran: DATAY
    dataz: f32, // Fortran: DATAZ
    outs: i32, // Fortran: OUTS
    outp: i32, // Fortran: OUTP
    outfils: i32, // Fortran: OUTFILS
    outfilp: i32, // Fortran: OUTFILP
    choice: i32, // Fortran: CHOICE
    idispq: i32, // Fortran: idispq

    pub fn init() Filec {
        return std.mem.zeroInit(Filec, .{});
    }
};
