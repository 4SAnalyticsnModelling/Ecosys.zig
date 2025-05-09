const std = @import("std");

pub const Blk17 = struct {
    icor: [12]i32,

    pub fn init() Blk17 {
        return .{ 1, -1, 0, 0, 1, 1, 2, 3, 3, 4, 4, 5 };
    }
};
