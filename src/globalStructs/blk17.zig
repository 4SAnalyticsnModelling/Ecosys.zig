const std = @import("std");

pub const Blk17 = struct {
    icor: [12]i32,

    pub fn init() Blk17 {
        return std.mem.zeroInit(Blk17, .{});
    }
};
