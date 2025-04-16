const std = @import("std");
const Blk11a = @import("../globalStructs/blk11a.zig").Blk11a;
const Blk11b = @import("../globalStructs/blk11b.zig").Blk11b;
const Blk8a = @import("../globalStructs/blk8a.zig").Blk8a;
const Blkc = @import("../globalStructs/blkc.zig").Blkc;
const Blktrnsfr1 = @import("../localStructs/blktrnsfr1.zig").Blktrnsfr1;
const Blktrnsfr3 = @import("../localStructs/blktrnsfr3.zig").Blktrnsfr3;
const Blktrnsfr12 = @import("../localStructs/blktrnsfr12.zig").Blktrnsfr12;

///Gas and solute diffusivities at sub-hourly time step.
pub inline fn subHourlyGasSoluteDiffusvty(blk8a: *Blk8a, blk11a: *Blk11a, blk11b: *Blk11b, blkc: *Blkc, blktrnsfr1: *Blktrnsfr1, blktrnsfr3: *Blktrnsfr3, blktrnsfr12: *Blktrnsfr12, nhw: u32, nhe: u32, nvn: u32, nvs: u32) anyerror!void {
    // xnph = 1/no. of cycles h-1 for water, heat and solute flux calculations
    // xnpg = 1/number of cycles h-1 for gas flux calculations
    // *sgl* = solute diffusivity from hour1.f
    // solute code: co=co2, ch=ch4, ox=o2, ng=n2, n2=n2o, hg=h2
    //             : oc=doc, on=don, op=dop, oa=acetate
    //             : nh4=nh4, nh3=nh3, no3=no3, no2=no2, p14=hpo4, po4=h2po4 in non-band
    //             : n4b=nh4, n3b=nh3, nob=no3, n2b=no2, p1b=hpo4, pob=h2po4 in band
    for (nhw..nhe) |nx| {
        for (nvn..nvs) |ny| {
            for (blk8a.nu[nx][ny]..blk8a.nl[nx][ny]) |l| {
                blktrnsfr1.ocsgl2[nx][ny][l] = blk11b.ocsgl[nx][ny][l] * blkc.xnph;
                blktrnsfr1.onsgl2[nx][ny][l] = blk11b.onsgl[nx][ny][l] * blkc.xnph;
                blktrnsfr1.opsgl2[nx][ny][l] = blk11b.opsgl[nx][ny][l] * blkc.xnph;
                blktrnsfr1.oasgl2[nx][ny][l] = blk11b.oasgl[nx][ny][l] * blkc.xnph;
                blktrnsfr3.clsgl2[nx][ny][l] = blk11a.clsgl[nx][ny][l] * blkc.xnph;
                blktrnsfr3.cqsgl2[nx][ny][l] = blk11a.cqsgl[nx][ny][l] * blkc.xnph;
                blktrnsfr3.olsgl2[nx][ny][l] = blk11a.olsgl[nx][ny][l] * blkc.xnph;
                blktrnsfr3.zlsgl2[nx][ny][l] = blk11b.zlsgl[nx][ny][l] * blkc.xnph;
                blktrnsfr3.zvsgl2[nx][ny][l] = blk11b.zvsgl[nx][ny][l] * blkc.xnph;
                blktrnsfr3.znsgl2[nx][ny][l] = blk11b.znsgl[nx][ny][l] * blkc.xnph;
                blktrnsfr3.hlsgl2[nx][ny][l] = blk11b.hlsgl[nx][ny][l] * blkc.xnph;
                blktrnsfr3.zosgl2[nx][ny][l] = blk11b.zosgl[nx][ny][l] * blkc.xnph;
                blktrnsfr3.posgl2[nx][ny][l] = blk11b.posgl[nx][ny][l] * blkc.xnph;
                blktrnsfr1.cgsgl2[nx][ny][l] = blk11a.cgsgl[nx][ny][l] * blkc.xnpg;
                blktrnsfr1.chsgl2[nx][ny][l] = blk11a.chsgl[nx][ny][l] * blkc.xnpg;
                blktrnsfr1.ogsgl2[nx][ny][l] = blk11a.ogsgl[nx][ny][l] * blkc.xnpg;
                blktrnsfr1.zgsgl2[nx][ny][l] = blk11a.zgsgl[nx][ny][l] * blkc.xnpg;
                blktrnsfr1.z2sgl2[nx][ny][l] = blk11b.z2sgl[nx][ny][l] * blkc.xnpg;
                blktrnsfr1.zhsgl2[nx][ny][l] = blk11b.zhsgl[nx][ny][l] * blkc.xnpg;
                blktrnsfr12.hgsgl2[nx][ny][l] = blk11b.hgsgl[nx][ny][l] * blkc.xnpg;
            }
        }
    }
}
