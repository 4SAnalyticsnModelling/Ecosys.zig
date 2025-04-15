const std = @import("std");
const Blk13b = @import("../globalStructs/blk13b.zig").Blk13b;
const Blk13c = @import("../globalStructs/blk13c.zig").Blk13c;
const Blk21a = @import("../globalStructs/blk21a.zig").Blk21a;
const Blk21b = @import("../globalStructs/blk21b.zig").Blk21b;
const Blkc = @import("../globalStructs/blkc.zig").Blkc;
const Blktrnsfr2 = @import("../localStructs/blktrnsfr2.zig").Blktrnsfr2;

/// Gas and solute sinks and sources in surface residue from microbial transformations in 'nitro.zig',root exchange in 'extract.zig', and equilibrium reactions in 'solute.zig' at sub-hourly time steps.
pub inline fn residueGasSoluteSourceSink(blk13b: *Blk13b, blk13c: *Blk13c, blk21a: *Blk21a, blk21b: *Blk21b, blkc: *Blkc, blktrnsfr2: *Blktrnsfr2, nhw: u32, nhe: u32, nvn: u32, nvs: u32) anyerror!void {
    // solute code:
    // co=co2, ch=ch4, ox=o2, ng=n2, n2=n2o, hg=h2
    // oc=doc, on=don, op=dop, oa=acetate
    // nh4=nh4, nh3=nh3, no3=no3, no2=no2, p14=hpo4, po4=h2po4 in non-band
    // n4b=nh4, n3b=nh3, nob=no3, n2b=no2, p1b=hpo4, pob=h2po4 in band
    //
    // xnpg=1/number of cycles h-1 for gas flux calculations
    // xnph=1/no. of cycles h-1 for water, heat and solute flux calculations
    // r*sk2=total sink from nitro.zig, uptake.zig, solute.zig
    // rco2o=net soil co2 uptake from nitro.zig
    // rch4o=net soil ch4 uptake from nitro.zig
    // rn2g=total soil n2 production from nitro.zig
    // xn2gs=total n2 fixation from nitro.zig
    // rn2o=net soil n2o uptake from nitro.zig
    // rh2go=net h2 uptake from nitro.zig
    // xoqcs,xoqnz,xoqps,xoqas=net change in doc,don,dop,acetate from nitro.zig
    // xnh4s=net change in nh4 from nitro.zig
    // trn4s,trn3s=nh4,nh3 dissolution from solute.zig
    // xno3s=net change in no3 from nitro.zig
    // trno3=no3 dissolution from solute.zig
    // xno2s=net change in no2 from nitro.zig
    // trno2=no2 dissolution from solute.zig
    // xh2ps=net change in h2po4 from nitro.zig
    // trh2p=h2po4 dissolution from solute.zig
    // xh1ps=net change in hpo4 from nitro.zig
    // trh1p=hpo4 dissolution from solute.zig
    //
    for (nhw..nhe) |nx| {
        for (nvn..nvs) |ny| {
            blktrnsfr2.rcosk2[nx][ny][0] = blk13b.rco2o[nx][ny][0] * blkc.xnpg;
            blktrnsfr2.rchsk2[nx][ny][0] = blk13b.rch4o[nx][ny][0] * blkc.xnpg;
            blktrnsfr2.rngsk2[nx][ny][0] = (blk13b.rn2g[nx][ny][0] + blk13c.xn2gs[nx][ny][0]) * blkc.xnpg;
            blktrnsfr2.rn2sk2[nx][ny][0] = blk13b.rn2o[nx][ny][0] * blkc.xnpg;
            // blktrnsfr2.rnhsk2[nx][ny][0] = 0.0;
            blktrnsfr2.rhgsk2[nx][ny][0] = blk13b.rh2go[nx][ny][0] * blkc.xnpg;

            inline for (0..4) |k| {
                blktrnsfr2.rocsk2[nx][ny][0][k] = -blk13c.xoqcs[nx][ny][0][k] * blkc.xnph;
                blktrnsfr2.ronsk2[nx][ny][0][k] = -blk13c.xoqns[nx][ny][0][k] * blkc.xnph;
                blktrnsfr2.ropsk2[nx][ny][0][k] = -blk13c.xoqps[nx][ny][0][k] * blkc.xnph;
                blktrnsfr2.roask2[nx][ny][0][k] = -blk13c.xoqas[nx][ny][0][k] * blkc.xnph;
            }

            blktrnsfr2.rn4sk2[nx][ny][0] = (-blk13c.xnh4s[nx][ny][0] - blk21a.trn4s[nx][ny][0]) * blkc.xnph;
            blktrnsfr2.rn3sk2[nx][ny][0] = -blk21a.trn3s[nx][ny][0] * blkc.xnph;
            blktrnsfr2.rnosk2[nx][ny][0] = (-blk13c.xno3s[nx][ny][0] - blk21a.trno3[nx][ny][0]) * blkc.xnph;
            blktrnsfr2.rnxsk2[nx][ny][0] = (-blk13b.xno2s[nx][ny][0] - blk21b.trno2[nx][ny][0]) * blkc.xnph;
            blktrnsfr2.rhpsk2[nx][ny][0] = (-blk13c.xh2ps[nx][ny][0] - blk21a.trh2p[nx][ny][0]) * blkc.xnph;
            blktrnsfr2.r1psk2[nx][ny][0] = (-blk13c.xh1ps[nx][ny][0] - blk21a.trh1p[nx][ny][0]) * blkc.xnph;
        }
    }
}
