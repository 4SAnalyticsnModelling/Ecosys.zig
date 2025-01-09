const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const jh = jx + 1;
const jv = jy + 1;

pub const Blktrnsfr3 = struct {
    cls2gl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    cqs2gl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    ols2gl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    zns2gl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    zls2gl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    zvs2gl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    hls2gl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    zos2gl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    pos2gl: [jx][jy][jz + 1]f32 = std.mem.zeroes([jx][jy][jz + 1]f32),
    rcodfs: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rchdfs: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    roxdfs: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rngdfs: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rn2dfs: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rn3dfs: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rnbdfs: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rhgdfs: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rcodfr: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rchdfr: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    roxdfr: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rngdfr: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rn2dfr: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rn3dfr: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    rhgdfr: [jx][jy]f32 = std.mem.zeroes([jx][jy]f32),
    r1bs2k: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rqroc: [jh][jv][2][2][5]f32 = std.mem.zeroes([jh][jv][2][2][5]f32),
    rqron: [jh][jv][2][2][5]f32 = std.mem.zeroes([jh][jv][2][2][5]f32),
    rqrop: [jh][jv][2][2][5]f32 = std.mem.zeroes([jh][jv][2][2][5]f32),
    rqroa: [jh][jv][2][2][5]f32 = std.mem.zeroes([jh][jv][2][2][5]f32),
    rqrcos: [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    rqrchs: [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    rqroxs: [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    rqrngs: [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    rqrn2s: [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    rqrhgs: [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    rqrnh4: [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    rqrnh3: [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    rqrno3: [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    rqrno2: [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    rqrh2p: [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    rqrh1p: [jh][jv][2][2]f32 = std.mem.zeroes([jh][jv][2][2]f32),
    flwu: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    rqscos: [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    rqschs: [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    rqsoxs: [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    rqsngs: [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    rqsn2s: [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    rqsn3: [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    rqsnh4: [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    rqsnh3: [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    rqsno3: [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    rqsh2p: [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),
    rqsh1p: [jh][jv][2]f32 = std.mem.zeroes([jh][jv][2]f32),

    pub fn init() Blktrnsfr3 {
        return .{};
    }
};
