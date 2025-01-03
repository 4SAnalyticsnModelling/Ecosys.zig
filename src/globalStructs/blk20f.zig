const std = @import("std");

pub const Blk20f = struct {
    xsaner: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xsiler: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xclaer: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xcecer: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xaecer: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xnh4er: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xnh3er: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xnhuer: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xno3er: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xnh4eb: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xnh3eb: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xnhueb: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xno3eb: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xn4er: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xnber: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xhyer: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xaler: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xcaer: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xmger: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xnaer: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xkaer: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xhcer: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xal2er: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xoh0er: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xoh1er: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xoh2er: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xh1per: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xh2per: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xoh0eb: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xoh1eb: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xoh2eb: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xh1peb: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xh2peb: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    paloer: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    pfeoer: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    pcacer: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    pcaser: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    palper: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    pfeper: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    pcpder: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    pcpher: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    pcpmer: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    palpeb: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    pfepeb: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    pcpdeb: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    pcphe: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    pcmeb: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xfe2er: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xseder: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xfeer: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    omcer: comptime [jh][jv][2][2][6][7][3]f32 = std.mem.zeroes([jh][jv][2][2][6][7][3]f32),
    omner: comptime [jh][jv][2][2][6][7][3]f32 = std.mem.zeroes([jh][jv][2][2][6][7][3]f32),
    orcer: comptime [jh][jv][2][2][5][4]f32 = std.mem.zeroes([jh][jv][2][2][5][4]f32),
    orner: comptime [jh][jv][2][2][5][4]f32 = std.mem.zeroes([jh][jv][2][2][5][4]f32),
    orper: comptime [jh][jv][2][2][5][4]f32 = std.mem.zeroes([jh][jv][2][2][5][4]f32),
    ohcer: comptime [jh][jv][2][2][5]f32 = std.mem.zeroes([jh][jv][2][2][5]f32),
    ohner: comptime [jh][jv][2][2][5]f32 = std.mem.zeroes([jh][jv][2][2][5]f32),
    ohper: comptime [jh][jv][2][2][5]f32 = std.mem.zeroes([jh][jv][2][2][5]f32),
    ohaer: comptime [jh][jv][2][2][5]f32 = std.mem.zeroes([jh][jv][2][2][5]f32),
    oscer: comptime [jh][jv][2][2][5][5]f32 = std.mem.zeroes([jh][jv][2][2][5][5]f32),

    pub fn init() Blk20f {
        return .{};
    }
};
