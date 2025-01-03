const std = @import("std");

pub const Blk20a = struct {
    xqral: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrfe: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrhy: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrca: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrmg: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrna: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrka: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqroh: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrso: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrcl: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrc3: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrhc: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqral1: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqral2: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqral3: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqral4: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrals: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrfe1: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrfe2: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrfe3: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrfe4: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrfes: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrcao: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrcac: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrcah: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrcas: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrmgo: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrmgc: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrmgh: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrmgs: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrnac: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrnas: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrkas: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrh0p: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrh3p: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrf1p: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrf2p: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrc0p: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrc1p: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrc2p: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqrm1p: comptime [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    xqsal: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsfe: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqshy: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsca: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsmg: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsna: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqska: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsoh: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsso: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqscl: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsc3: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqshc: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsal1: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsal2: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsal3: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsal4: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsals: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsfe1: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsfe2: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsfe3: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsfe4: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsfes: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqscao: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqscac: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqscah: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqscas: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsmgo: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsmgc: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsmgh: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsmgs: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsnac: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsnas: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqskas: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsh0p: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsh1p: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsh3p: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsf1p: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsf2p: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsc0p: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsc1p: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsc2p: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    xqsm1p: comptime [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),

    pub fn init() Blk20a {
        return .{};
    }
};
