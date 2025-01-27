const std = @import("std");
const config = @import("config");

const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const js = config.snowlayersmax;

pub const Blktrnsfr1 = struct {
    ioqc2: [jx][jy][jz + 1][5]i32,
    ioqn2: [jx][jy][jz + 1][5]i32,
    ioqp2: [jx][jy][jz + 1][5]i32,
    ioqa2: [jx][jy][jz + 1][5]i32,
    ico2s2: [jx][jy][jz + 1]i32,
    ich4s2: [jx][jy][jz + 1]i32,
    ioxys2: [jx][jy][jz + 1]i32,
    iz2gs2: [jx][jy][jz + 1]i32,
    iz2os2: [jx][jy][jz + 1]i32,
    izn3g2: [jx][jy][jz + 1]i32,
    iznh4s2: [jx][jy][jz + 1]i32,
    iznh4b2: [jx][jy][jz + 1]i32,
    iznh3s2: [jx][jy][jz + 1]i32,
    iznh3b2: [jx][jy][jz + 1]i32,
    izno3s2: [jx][jy][jz + 1]i32,
    izno3b2: [jx][jy][jz + 1]i32,
    ih2po42: [jx][jy][jz + 1]i32,
    ih2pob2: [jx][jy][jz + 1]i32,
    izno2s2: [jx][jy][jz + 1]i32,
    iocsgl2: [jx][jy][jz + 1]i32,
    ionsgl2: [jx][jy][jz + 1]i32,
    iopsgl2: [jx][jy][jz + 1]i32,
    ioasgl2: [jx][jy][jz + 1]i32,
    ichy0: [jx][jy][jz + 1]i32,
    ih1po42: [jx][jy][jz + 1]i32,
    ih1pob2: [jx][jy][jz + 1]i32,
    ico2g2: [jx][jy][jz]i32,
    ich4g2: [jx][jy][jz]i32,
    ioxyg2: [jx][jy][jz]i32,
    iz2gg2: [jx][jy][jz]i32,
    iz2og2: [jx][jy][jz]i32,
    icgsgl2: [jx][jy][jz]i32,
    ichsgl2: [jx][jy][jz]i32,
    iogsgl2: [jx][jy][jz]i32,
    izgsgl2: [jx][jy][jz]i32,
    iz2sgl2: [jx][jy][jz]i32,
    izhsgl2: [jx][jy][jz]i32,
    ico2w2: [jx][jy][js]i32,
    ich4w2: [jx][jy][js]i32,
    ioxyw2: [jx][jy][js]i32,
    izngw2: [jx][jy][js]i32,
    izn2w2: [jx][jy][js]i32,
    izn4w2: [jx][jy][js]i32,
    izn3w2: [jx][jy][js]i32,
    iznow2: [jx][jy][js]i32,
    izhpw2: [jx][jy][js]i32,
    iz1pw2: [jx][jy][js]i32,

    pub fn init() Blktrnsfr1 {
        return std.mem.zeroInit(Blktrnsfr1, .{});
    }
};
