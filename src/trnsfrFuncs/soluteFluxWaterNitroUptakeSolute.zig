const std = @import("std");

const Blk13b = @import("../globalStructs/blk13b.zig").Blk13b;
const Blk13c = @import("../globalStructs/blk13c.zig").Blk13c;
const Blk18a = @import("../globalStructs/blk18a.zig").Blk18a;
const Blk18b = @import("../globalStructs/blk18b.zig").Blk18b;
const Blk21a = @import("../globalStructs/blk21a.zig").Blk21a;
const Blk21b = @import("../globalStructs/blk21b.zig").Blk21b;
const Blk8a = @import("../globalStructs/blk8a.zig").Blk8a;
const Blkc = @import("../globalStructs/blkc.zig").Blkc;
const Blktrnsfr1 = @import("../localStructs/blktrnsfr1.zig").Blktrnsfr1;
const Blktrnsfr2 = @import("../localStructs/blktrnsfr2.zig").Blktrnsfr2;
const Blktrnsfr3 = @import("../localStructs/blktrnsfr3.zig").Blktrnsfr3;

///Solute fluxes from watsub.zig, nitro.zig, uptake.zig, solute.zig
pub inline fn soluteFluxWaterNitroUptakeSolute(blk13b: *Blk13b, blk13c: *Blk13c, blk18a: *Blk18a, blk18b: *Blk18b, blk21a: *Blk21a, blk21b: *Blk21b, blk8a: *Blk8a, blkc: *Blkc, blktrnsfr1: *Blktrnsfr1, blktrnsfr2: *Blktrnsfr2, blktrnsfr3: *Blktrnsfr3, nx: usize, ny: usize) anyerror!void {
    //     blkc.xnph=1/no. of cycles h-1 for water, heat and solute flux calculations
    //     chy0=h concentration
    //     ph=pH
    //     flwu,tupwtr=total root water uptake from extract.zig
    //     r*sk2=total sink from nitro.zig, uptake.zig, solute.zig
    //     rco2o=net soil co2 uptake from nitro.zig
    //     rch4o=net soil ch4 uptake from nitro.zig
    //     rn2g=total soil n2 production from nitro.zig
    //     xn2gs=total n2 fixation from nitro.zig
    //     rn2o=net soil n2o uptake from nitro.zig
    //     rh2go=net h2 uptake from nitro.zig
    //     xoqcs,xoqns,xoqps,xoqas=net change in doc,don,dop,acetate from nitro.zig
    //     xnh4s=net change in nh4 from nitro.zig
    //     trn4s,trn3s=nh4,nh3 dissolution from solute.zig
    //     xno3s=net change in no3 from nitro.zig
    //     trno3=no3 dissolution from solute.zig
    //     xno2s=net change in no2 from nitro.zig
    //     trno2=no2 dissolution from solute.zig
    //     xh2ps=net change in h2po4 from nitro.zig
    //     trh2p=h2po4 dissolution from solute.zig
    //     xh1ps=net change in hpo4 from nitro.zig
    //     trh1p=hpo4 dissolution from solute.zig
    //     tupnh4,tupnhb=root nh4 uptake in non-band,band from extract.zig
    //     tupno3,tupnob=root no3 uptake in non-band,band from extract.zig
    //     tuph2p,tuph2b=root h2po4 uptake in non-band,band from extract.zig
    //     tuph1p,tuph1b=root hpo4 uptake in non-band,band from extract.zig

    for (blk8a.nu[nx][ny]..blk8a.nl[nx][ny]) |l| {
        blktrnsfr1.chy0[nx][ny][l] = std.math.pow(f32, 10.0, -(blk8a.ph[nx][ny][l] - 3.0));
        blktrnsfr3.flwu[nx][ny][l] = blk18a.tupwtr[nx][ny][l] * blkc.xnph;
        blktrnsfr2.rcosk2[nx][ny][l] = (blk13b.rco2o[nx][ny][l] + blk18a.tco2s[nx][ny][l] - blk21a.trco2[nx][ny][l]) * blkc.xnpg;
        blktrnsfr2.rchsk2[nx][ny][l] = (blk13b.rch4o[nx][ny][l] + blk18a.tupchs[nx][ny][l]) * blkc.xnpg;
        blktrnsfr2.rngsk2[nx][ny][l] = (blk13b.rn2g[nx][ny][l] + blk13c.xn2gs[nx][ny][l] + blk18a.tupnf[nx][ny][l]) * blkc.xnpg;
        blktrnsfr2.rn2sk2[nx][ny][l] = (blk13b.rn2o[nx][ny][l] + blk18a.tupn2s[nx][ny][l]) * blkc.xnpg;
        blktrnsfr2.rnhsk2[nx][ny][l] = -blk21b.trn3g[nx][ny][l] * blkc.xnpg;
        blktrnsfr2.rhgsk2[nx][ny][l] = (blk13b.rh2go[nx][ny][l] + blk18b.tuphgs[nx][ny][l]) * blkc.xnpg;

        inline for (0..4) |k| {
            blktrnsfr2.rocsk2[nx][ny][l][k] = -blk13c.xoqcs[nx][ny][l][k] * blkc.xnph;
            blktrnsfr2.ronsk2[nx][ny][l][k] = -blk13c.xoqns[nx][ny][l][k] * blkc.xnph;
            blktrnsfr2.ropsk2[nx][ny][l][k] = -blk13c.xoqps[nx][ny][l][k] * blkc.xnph;
            blktrnsfr2.roask2[nx][ny][l][k] = -blk13c.xoqas[nx][ny][l][k] * blkc.xnph;
        }

        blktrnsfr2.rn4sk2[nx][ny][l] = (-blk13c.xnh4s[nx][ny][l] - blk21a.trn4s[nx][ny][l] + blk18a.tupnh4[nx][ny][l]) * blkc.xnph;
        blktrnsfr2.rn3sk2[nx][ny][l] = (-blk21a.trn3s[nx][ny][l] + blk18a.tupn3s[nx][ny][l]) * blkc.xnph;
        blktrnsfr2.rnosk2[nx][ny][l] = (-blk13c.xno3s[nx][ny][l] - blk21a.trno3[nx][ny][l] + blk18a.tupno3[nx][ny][l]) * blkc.xnph;
        blktrnsfr2.rnxsk2[nx][ny][l] = (-blk13b.xno2s[nx][ny][l] - blk21b.trno2[nx][ny][l]) * blkc.xnph;
        blktrnsfr2.rhpsk2[nx][ny][l] = (-blk13c.xh2ps[nx][ny][l] - blk21a.trh2p[nx][ny][l] + blk18a.tuph2p[nx][ny][l]) * blkc.xnph;
        blktrnsfr2.r1psk2[nx][ny][l] = (-blk13c.xh1ps[nx][ny][l] - blk21a.trh1p[nx][ny][l] + blk18a.tuph1p[nx][ny][l]) * blkc.xnph;
        blktrnsfr2.r4bsk2[nx][ny][l] = (-blk13c.xnh4b[nx][ny][l] - blk21a.trn4b[nx][ny][l] + blk18a.tupnhb[nx][ny][l]) * blkc.xnph;
        blktrnsfr2.r3bsk2[nx][ny][l] = (-blk21a.trn3b[nx][ny][l] + blk18a.tupn3b[nx][ny][l]) * blkc.xnph;
        blktrnsfr2.rnbsk2[nx][ny][l] = (-blk13c.xno3b[nx][ny][l] - blk21a.trnob[nx][ny][l] + blk18a.tupnob[nx][ny][l]) * blkc.xnph;
        blktrnsfr2.rnzsk2[nx][ny][l] = (-blk13b.xno2b[nx][ny][l] - blk21b.trn2b[nx][ny][l]) * blkc.xnph;
        blktrnsfr2.rhbsk2[nx][ny][l] = (-blk13c.xh2bs[nx][ny][l] - blk21a.trh2b[nx][ny][l] + blk18a.tuph2b[nx][ny][l]) * blkc.xnph;
        blktrnsfr3.r1bsk2[nx][ny][l] = (-blk13c.xh1bs[nx][ny][l] - blk21a.trh1b[nx][ny][l] + blk18a.tuph1b[nx][ny][l]) * blkc.xnph;
    }
}
