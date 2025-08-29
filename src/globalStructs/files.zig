const std = @import("std");

pub const Files = struct {
    outdir: [256]u8, // Fortran: CHARACTER*256 OUTDIR
    idata: [60]u32, // Fortran: IDATA(60)
    nouts: [10]u32, // Fortran: NOUTS(10)
    noutp: [10]u32, // Fortran: NOUTP(10)

    pub fn init() Files {
        return std.mem.zeroInit(Files, .{});
    }
};
