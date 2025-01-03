const std = @import("std");

pub const Blk2c = struct {
    ccoq: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    cchq: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    coxq: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    cnnq: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    cn2q: comptime [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    cocu: comptime [jx][jy][jz][5]f32 = std.mem.zeroes([jx][jy][jz][5]f32),
    conu: comptime [jx][jy][jz][5]f32 = std.mem.zeroes([jx][jy][jz][5]f32),
    coau: comptime [jx][jy][jz][5]f32 = std.mem.zeroes([jx][jy][jz][5]f32),
    cn4u: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cn3u: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cnou: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    ch2pu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cnzu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    calu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cfeu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    chyu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    ccau: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cmgu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cnau: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    ckau: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cohu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    csou: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cclu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cc3u: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    chcu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cal1u: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cal2u: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cal3u: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cal4u: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    calsu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cfe1u: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cfe2u: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cfe3u: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cfe4u: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cfesu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    ccaou: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    ccacu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    ccahu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    ccasu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cmgou: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cmgcu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cmghu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cmgsu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cnacu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cnasu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    ckasu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    ch0pu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    ch1pu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    ch3pu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cf1pu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cf2pu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cc0pu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cc1pu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cc2pu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    cm1pu: comptime [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    copu: comptime [jx][jy][jz][5]f32 = std.mem.zeroes([jx][jy][jz][5]f32),
    ccou: comptime f32 = 0,
    cchu: comptime f32 = 0,
    coxu: comptime f32 = 0,
    cnnu: comptime f32 = 0,
    cn2u: comptime f32 = 0,
    bkrs: comptime [3]f32 = std.mem.zeroes([3]f32),

    pub fn init() Blk2c {
        return .{};
    }
};
