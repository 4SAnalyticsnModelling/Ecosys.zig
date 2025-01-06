const std = @import("std");

pub const Blk6 = struct {
    azi: f32 = 0.0,
    rmax: f32 = 0.0,
    dec: f32 = 0.0,
    tavg1: f32 = 0.0,
    tavg2: f32 = 0.0,
    tavg3: f32 = 0.0,
    amp1: f32 = 0.0,
    amp2: f32 = 0.0,
    amp3: f32 = 0.0,
    vavg1: f32 = 0.0,
    vavg2: f32 = 0.0,
    vavg3: f32 = 0.0,
    vmp1: f32 = 0.0,
    vmp2: f32 = 0.0,
    vmp3: f32 = 0.0,

    pub fn init() Blk6 {
        return .{};
    }
};
