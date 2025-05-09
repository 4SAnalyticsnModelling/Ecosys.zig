const std = @import("std");
const config = @import("config");

pub const Blkmain = struct {
    datac: [250][250][30][]const u8 = undefined,
    data: [30][]const u8 = undefined,
    na: [250]u32 = [_]u32{0} ** 250,
    nd: [250]u32 = [_]u32{0} ** 250,

    pub fn init() Blkmain {
        return .{};
    }
};
