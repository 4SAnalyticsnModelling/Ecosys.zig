const std = @import("std");

pub const Blk6 = struct {
    azi: f32,
    rmax: f32,
    dec: f32,
    tavg1: f32,
    tavg2: f32,
    tavg3: f32,
    amp1: f32,
    amp2: f32,
    amp3: f32,
    vavg1: f32,
    vavg2: f32,
    vavg3: f32,
    vmp1: f32,
    vmp2: f32,
    vmp3: f32,

    pub fn init() Blk6 {
        return std.mem.zeroInit(Blk6, .{});
    }
};
