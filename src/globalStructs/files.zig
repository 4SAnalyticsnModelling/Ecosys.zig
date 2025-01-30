const std = @import("std");

const Files = struct {
    idata: [60]i32,
    nouts: [10]i32,
    noutp: [10]i32,
    outdir: [256]u8,

    pub fn init() Files {
        return std.mem.zeroInit(Files, .{});
    }
};
