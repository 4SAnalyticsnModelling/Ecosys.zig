const std = @import("std");

pub const Blk22a = struct {
    flu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    hwflu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rcoflu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rchflu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    roxflu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rngflu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rn2flu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rn4flu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rn3flu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rnoflu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rh2pfu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rn4fbu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rn3fbu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rnofbu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rh2bbu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    ralflu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rfeflu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rhyflu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rcaflu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rmgflu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rnaflu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rkaflu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rohflu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rsoflu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rclflu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rc3flu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rhcflu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    ral1fu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    ral2fu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    ral3fu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    ral4fu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    ralsfu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rfe1fu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rfe2fu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rfe3fu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rfe4fu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rfesfu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rcaofu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rcacfu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rcahfu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rcasfu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rmgoffu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rmgcfu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rmghfu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rmgsfu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rnacfu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rnasfu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rkafu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rh0pfu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rh1pfu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rh3pfu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rf1pfu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rf2pfu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rc0pfu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rc1pfu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rhgflu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rh1bbu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),

    pub fn init() Blk22a {
        return .{};
    }
};
