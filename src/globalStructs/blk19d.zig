const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jz = config.soillayersmax;
const js = config.snowlayersmax;

pub const Blk19d = struct {
    co2w: [jx][jy][js]f32,
    ch4w: [jx][jy][js]f32,
    oxyw: [jx][jy][js]f32,
    zn2w: [jx][jy][js]f32,
    zngw: [jx][jy][js]f32,
    zn4w: [jx][jy][js]f32,
    zn3w: [jx][jy][js]f32,
    znow: [jx][jy][js]f32,
    z1pw: [jx][jy][js]f32,
    zhpw: [jx][jy][js]f32,
    zalw: [jx][jy][js]f32,
    zfew: [jx][jy][js]f32,
    zhyw: [jx][jy][js]f32,
    zcaw: [jx][jy][js]f32,
    zmgw: [jx][jy][js]f32,
    znaw: [jx][jy][js]f32,
    zohw: [jx][jy][js]f32,
    zso4w: [jx][jy][js]f32,
    zclw: [jx][jy][js]f32,
    zco3w: [jx][jy][js]f32,
    zhco3w: [jx][jy][js]f32,
    zalh1w: [jx][jy][js]f32,
    zalh2w: [jx][jy][js]f32,
    zalh3w: [jx][jy][js]f32,
    zalh4w: [jx][jy][js]f32,
    zalsw: [jx][jy][js]f32,
    zfeh1w: [jx][jy][js]f32,
    zfeh2w: [jx][jy][js]f32,
    zfeh3w: [jx][jy][js]f32,
    zfeh4w: [jx][jy][js]f32,
    zfesw: [jx][jy][js]f32,
    zcaow: [jx][jy][js]f32,
    zcacw: [jx][jy][js]f32,
    zcahw: [jx][jy][js]f32,
    zcasw: [jx][jy][js]f32,
    zmgow: [jx][jy][js]f32,
    zmgcw: [jx][jy][js]f32,
    zmghw: [jx][jy][js]f32,
    zmgsw: [jx][jy][js]f32,
    znacw: [jx][jy][js]f32,
    znasw: [jx][jy][js]f32,
    zkaw: [jx][jy][js]f32,
    h0po4w: [jx][jy][js]f32,
    h3po4w: [jx][jy][js]f32,
    zfe1pw: [jx][jy][js]f32,
    zfe2pw: [jx][jy][js]f32,
    zca0pw: [jx][jy][js]f32,
    zca1pw: [jx][jy][js]f32,
    zca2pw: [jx][jy][js]f32,
    zmg1pw: [jx][jy][js]f32,

    pub fn init() Blk19d {
        return std.mem.zeroInit(Blk19d, .{});
    }
};
