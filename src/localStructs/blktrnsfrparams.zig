const std = @import("std");

pub const Blktrnsfrparams = struct {
    dpn4: f32 = 5.7e-7,
    vflwx: f32 = 0.5,
    xfrs: f32 = 0.05,

    pub fn init() Blktrnsfrparams {
        return .{};
    }
};
