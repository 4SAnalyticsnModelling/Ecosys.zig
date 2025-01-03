const std = @import("std");

pub const Blk6 = struct {
    azi: comptime f32 = 0,
    rmax: comptime f32 = 0,
    dec: comptime f32 = 0,
    tavg1: comptime f32 = 0,
    tavg2: comptime f32 = 0,
    tavg3: comptime f32 = 0,
    amp1: comptime f32 = 0,
    amp2: comptime f32 = 0,
    amp3: comptime f32 = 0,
    vavg1: comptime f32 = 0,
    vavg2: comptime f32 = 0,
    vavg3: comptime f32 = 0,
    vmp1: comptime f32 = 0,
    vmp2: comptime f32 = 0,
    vmp3: comptime f32 = 0,

    pub fn init() Blk6 {
        return .{};
    }
};
