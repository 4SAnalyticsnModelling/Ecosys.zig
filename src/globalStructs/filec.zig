const std = @import("std");

const Filec = struct {
    cdate: [10]u8,
    prefix: [10]u8,
    data: f64,
    datac: f64,
    datap: f64,
    datam: f64,
    datax: f64,
    datay: f64,
    dataz: f64,
    outs: i32,
    outp: i32,
    outfils: i32,
    outfilp: i32,
    choice: i32,
    idispq: i32,

    pub fn init() Filec {
        return std.mem.zeroInit(Filec, .{});
    }
};
