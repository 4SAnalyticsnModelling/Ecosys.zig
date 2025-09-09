const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;

pub const Blkwthr = struct {
    vars: [jx][jy][20]u8 = undefined,
    typ: [jx][jy][20]u8 = undefined,
    ivars: [jx][jy][10]u8 = undefined,
    ttype: [jx][jy]u8 = undefined,
    ctype: [jx][jy]u8 = undefined,
    ni: [jx][jy]u32 = undefined,
    nn: [jx][jy]u32 = undefined,

    pub fn init() Blkwthr {
        return .{};
    }
};
