const std = @import("std");
const Blk11a = @import("../globalStructs/blk11a.zig").Blk11a;
const Blk11b = @import("../globalStructs/blk11b.zig").Blk11b;
const Blkc = @import("../globalStructs/blkc.zig").Blkc;
const Blktrnsfr1 = @import("../localStructs/blktrnsfr1.zig").Blktrnsfr1;
const Blktrnsfr3 = @import("../localStructs/blktrnsfr3.zig").Blktrnsfr3;

///Gas and solute sinks and sources in soil layers from microbial transformations in 'nitro.zig' + root exchange in 'extract.zig' + equilibria reactions in 'solute.zig' at sub‑hourly time step
pub inline fn soilGasSoluteSourceSink(blk11a: *Blk11a, blk11b: *Blk11b, blkc: *Blkc, blktrnsfr1: *Blktrnsfr1, blktrnsfr3: *Blktrnsfr3, nhw: u32, nhe: u32, nvn: u32, nvs: u32) anyerror!void {

    // blkc.xnph = 1 / no. of cycles h‑1 for water, heat and solute flux calculations
    // *sgl* = solute diffusivity from hour1.zig
    // solute code: co = co2, ch = ch4, ox = o2, ng = n2, n2 = n2o, hg = h2
    //             : oc = doc, on = don, op = dop, oa = acetate
    //             : nh4 = nh4, nh3 = nh3, no3 = no3, no2 = no2, p14 = hpo4, po4 = h2po4 in non‑band
    //             : n4b = nh4, n3b = nh3, nob = no3, n2b = no2, p1b = hpo4, pob = h2po4 in band
    // parr = boundary layer conductance above litter from watsub.f
    // xnpt = 1 / number of cycles nph‑1 for gas flux calculations
    for (nhw..nhe) |nx| {
        for (nvn..nvs) |ny| {
            blktrnsfr3.clsgl2[nx][ny][0] = blk11a.clsgl[nx][ny][0] * blkc.xnph;
            blktrnsfr3.cqsgl2[nx][ny][0] = blk11a.cqsgl[nx][ny][0] * blkc.xnph;
            blktrnsfr3.olsgl2[nx][ny][0] = blk11a.olsgl[nx][ny][0] * blkc.xnph;
            blktrnsfr3.zlsgl2[nx][ny][0] = blk11b.zlsgl[nx][ny][0] * blkc.xnph;
            blktrnsfr3.znsgl2[nx][ny][0] = blk11b.znsgl[nx][ny][0] * blkc.xnph;
            blktrnsfr3.zvsgl2[nx][ny][0] = blk11b.zvsgl[nx][ny][0] * blkc.xnph;
            blktrnsfr3.hlsgl2[nx][ny][0] = blk11b.hlsgl[nx][ny][0] * blkc.xnph;
            blktrnsfr1.ocsgl2[nx][ny][0] = blk11b.ocsgl[nx][ny][0] * blkc.xnph;
            blktrnsfr1.onsgl2[nx][ny][0] = blk11b.onsgl[nx][ny][0] * blkc.xnph;
            blktrnsfr1.opsgl2[nx][ny][0] = blk11b.opsgl[nx][ny][0] * blkc.xnph;
            blktrnsfr1.oasgl2[nx][ny][0] = blk11b.oasgl[nx][ny][0] * blkc.xnph;
            blktrnsfr3.zosgl2[nx][ny][0] = blk11b.zosgl[nx][ny][0] * blkc.xnph;
            blktrnsfr3.posgl2[nx][ny][0] = blk11b.posgl[nx][ny][0] * blkc.xnph;
        }
    }
}
