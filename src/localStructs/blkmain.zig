const std = @import("std");

pub const Blkmain = struct {
    datac: [20][20][30][]const u8 = undefined,
    data: [30][]const u8 = undefined,
    na: [20]u32 = [_]u32{0} ** 20,
    nd: [20]u32 = [_]u32{0} ** 20,

    pub fn init() Blkmain {
        return .{};
    }
};
