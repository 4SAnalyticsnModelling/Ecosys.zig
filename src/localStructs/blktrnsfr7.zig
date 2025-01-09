const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;

pub const Blktrnsfr7 = struct {
    co2sh2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    ch4sh2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    oxysh2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    z2gsh2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    z2osh2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    znh4h2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zn4bh2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    znh3h2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zn3bh2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zno3h2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    znobh2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    h2p4h2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    h2pbh2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zno2h2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    oqch2: [jx][jy][jz][5]f32 = std.mem.zeroes([jx][jy][jz][5]f32),
    oqnh2: [jx][jy][jz][5]f32 = std.mem.zeroes([jx][jy][jz][5]f32),
    oqph2: [jx][jy][jz][5]f32 = std.mem.zeroes([jx][jy][jz][5]f32),
    oqah2: [jx][jy][jz][5]f32 = std.mem.zeroes([jx][jy][jz][5]f32),
    tocfhs: [jx][jy][jz][5]f32 = std.mem.zeroes([jx][jy][jz][5]f32),
    tonfhs: [jx][jy][jz][5]f32 = std.mem.zeroes([jx][jy][jz][5]f32),
    topfhs: [jx][jy][jz][5]f32 = std.mem.zeroes([jx][jy][jz][5]f32),
    toafhs: [jx][jy][jz][5]f32 = std.mem.zeroes([jx][jy][jz][5]f32),
    tcofhs: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tchfhs: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    toxfhs: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tngfhs: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tn2fhs: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tn4fhw: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tn3fhw: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tnofhw: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    th2phs: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tn4fhb: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tn3fhb: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tnofhb: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    th2bhb: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tnxfhs: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zno2b2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    zn2bh2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tnxflb: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    tnxfhb: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    h1p4h2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    h1pbh2: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    th1phs: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),
    th1bhb: [jx][jy][jz]f32 = std.mem.zeroes([jx][jy][jz]f32),

    pub fn init() Blktrnsfr7 {
        return .{};
    }
};
