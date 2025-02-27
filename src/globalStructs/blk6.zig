const std = @import("std");

pub const Blk6 = struct {
    azi: f32, // Fortran: AZI
    rmax: f32, // Fortran: RMAX
    dec: f32, // Fortran: DEC
    tavg1: f32, // Fortran: TAVG1
    tavg2: f32, // Fortran: TAVG2
    tavg3: f32, // Fortran: TAVG3
    amp1: f32, // Fortran: AMP1
    amp2: f32, // Fortran: AMP2
    amp3: f32, // Fortran: AMP3
    vavg1: f32, // Fortran: VAVG1
    vavg2: f32, // Fortran: VAVG2
    vavg3: f32, // Fortran: VAVG3
    vmp1: f32, // Fortran: VMP1
    vmp2: f32, // Fortran: VMP2
    vmp3: f32, // Fortran: VMP3

    pub fn init() Blk6 {
        return std.mem.zeroInit(Blk6, .{});
    }
};
