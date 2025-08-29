const std = @import("std");
const Blkc = @import("../globalStructs/blkc.zig").Blkc;

pub fn dylnFunc(blkc: *Blkc, xi: u32, nx: usize, ny: usize) !f32 {
    const xif32: f32 = @floatFromInt(xi);
    const decday: f32 = xif32 + 100.0;
    var dyln: f32 = 0.0;

    const declin: f32 = @sin(decday * 0.9863 * 1.7453e-02) * -23.47;
    const azi: f32 = @sin(blkc.alat[nx][ny] * 1.7453e-02) * @sin(declin * 1.7453e-02);
    const dec: f32 = @cos(blkc.alat[nx][ny] * 1.7453e-02) * @cos(declin * 1.7453e-02);

    const twilgt: f32 = 0.06976;

    if (azi / dec >= 1.0 - twilgt) {
        dyln = 24.0;
    } else if (azi / dec <= -1.0 + twilgt) {
        dyln = 0.0;
    } else {
        dyln = 12.0 * (1.0 + 2.0 / std.math.pi * std.math.asin(twilgt + azi / dec));
    }
    return dyln;
}
