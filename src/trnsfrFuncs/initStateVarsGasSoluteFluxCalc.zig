const std = @import("std");
const Blk13a = @import("../globalStructs/blk13a.zig").Blk13a;
const Blk13b = @import("../globalStructs/blk13b.zig").Blk13b;
const Blk13c = @import("../globalStructs/blk13c.zig").Blk13c;
const Blk8a = @import("../globalStructs/blk8a.zig").Blk8a;
const Blktrnsfr1 = @import("../localStructs/blktrnsfr1.zig").Blktrnsfr1;
const Blktrnsfr12 = @import("../localStructs/blktrnsfr12.zig").Blktrnsfr12;

/// Initialize state variables for use in gas, solute flux calculations.
pub inline fn initStateVarsGasSoluteFluxCalc(blk13a: *Blk13a, blk13b: *Blk13b, blk13c: *Blk13c, blk8a: *Blk8a, blktrnsfr1: *Blktrnsfr1, blktrnsfr12: *Blktrnsfr12, nhw: u32, nhe: u32, nvn: u32, nvs: u32) anyerror!void {
    // co2s,ch4s,oxys,z2gs,z2os,h2gs=aqueous co2,ch4,o2,n2,n2o,h2 content
    // oqc,oqn,oqp,oqa=doc,don,dop,acetate
    // xoqcs,xoqnz,xoqps,xoqas=net change in doc,don,dop,acetate from nitro.zig
    // znh4s,znh3s,zno3s,zno2s,h1po4,h2po4=aqueous nh4,nh3,no3,no2,hpo4,h2po4
    // chy0=h concentration
    // ph=ph
    //
    for (nhw..nhe) |nx| {
        for (nvn..nvs) |ny| {
            blktrnsfr1.co2s2[nx][ny][0] = blk13b.co2s[nx][ny][0];
            blktrnsfr1.ch4s2[nx][ny][0] = blk13b.ch4s[nx][ny][0];
            blktrnsfr1.oxys2[nx][ny][0] = blk13b.oxys[nx][ny][0];
            blktrnsfr1.z2gs2[nx][ny][0] = blk13a.z2gs[nx][ny][0];
            blktrnsfr1.z2os2[nx][ny][0] = blk13a.z2os[nx][ny][0];
            blktrnsfr12.h2gs2[nx][ny][0] = blk13b.h2gs[nx][ny][0];

            inline for (0..4) |k| {
                blktrnsfr1.oqc2[nx][ny][0][k] = blk13a.oqc[nx][ny][0][k] - blk13c.xoqcs[nx][ny][0][k];
                blktrnsfr1.oqn2[nx][ny][0][k] = blk13a.oqn[nx][ny][0][k] - blk13c.xoqns[nx][ny][0][k];
                blktrnsfr1.oqp2[nx][ny][0][k] = blk13a.oqp[nx][ny][0][k] - blk13c.xoqps[nx][ny][0][k];
                blktrnsfr1.oqa2[nx][ny][0][k] = blk13a.oqa[nx][ny][0][k] - blk13c.xoqas[nx][ny][0][k];
            }

            blktrnsfr1.znh4s2[nx][ny][0] = blk13a.znh4s[nx][ny][0];
            blktrnsfr1.znh3s2[nx][ny][0] = blk13a.znh3s[nx][ny][0];
            blktrnsfr1.zno3s2[nx][ny][0] = blk13a.zno3s[nx][ny][0];
            blktrnsfr1.zno2s2[nx][ny][0] = blk13a.zno2s[nx][ny][0];
            blktrnsfr1.h1po42[nx][ny][0] = blk13a.h1po4[nx][ny][0];
            blktrnsfr1.h2po42[nx][ny][0] = blk13a.h2po4[nx][ny][0];
            blktrnsfr1.chy0[nx][ny][0] = std.math.pow(f32, 10.0, -(blk8a.ph[nx][ny][0] - 3.0));
        }
    }
}
