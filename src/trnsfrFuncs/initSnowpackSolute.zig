const std = @import("std");
const config = @import("config");
const js = config.snowlayersmax;
const Blk19d = @import("../globalStructs/blk19d.zig").Blk19d;
const Blktrnsfr1 = @import("../localStructs/blktrnsfr1.zig").Blktrnsfr1;

///Initial solutes in snowpack
pub inline fn initSnowpackSolute(blk19d: *Blk19d, blktrnsfr1: *Blktrnsfr1, nhw: u32, nhe: u32, nvn: u32, nvs: u32) anyerror!void {
    // co2w, ch4w, oxyw, zngw, zn2w, zn4w, zn3w, znow, z1pw, zhpw = co2, ch4, o2, n2, n2o, h2 content in snowpack
    for (nhw..nhe) |nx| {
        for (nvn..nvs) |ny| {
            inline for (0..js) |l| {
                blktrnsfr1.co2w2[nx][ny][l] = blk19d.co2w[nx][ny][l];
                blktrnsfr1.ch4w2[nx][ny][l] = blk19d.ch4w[nx][ny][l];
                blktrnsfr1.oxyw2[nx][ny][l] = blk19d.oxyw[nx][ny][l];
                blktrnsfr1.zngw2[nx][ny][l] = blk19d.zngw[nx][ny][l];
                blktrnsfr1.zn2w2[nx][ny][l] = blk19d.zn2w[nx][ny][l];
                blktrnsfr1.zn4w2[nx][ny][l] = blk19d.zn4w[nx][ny][l];
                blktrnsfr1.zn3w2[nx][ny][l] = blk19d.zn3w[nx][ny][l];
                blktrnsfr1.znow2[nx][ny][l] = blk19d.znow[nx][ny][l];
                blktrnsfr1.z1pw2[nx][ny][l] = blk19d.z1pw[nx][ny][l];
                blktrnsfr1.zhpw2[nx][ny][l] = blk19d.zhpw[nx][ny][l];
            }
        }
    }
}
