const std = @import("std");
const Blk13a = @import("../globalStructs/blk13a.zig").Blk13a;
const Blk13b = @import("../globalStructs/blk13b.zig").Blk13b;
const Blk13c = @import("../globalStructs/blk13c.zig").Blk13c;
const Blk8a = @import("../globalStructs/blk8a.zig").Blk8a;
const Blktrnsfr1 = @import("../localStructs/blktrnsfr1.zig").Blktrnsfr1;
const Blktrnsfr7 = @import("../localStructs/blktrnsfr7.zig").Blktrnsfr7;
const Blktrnsfr12 = @import("../localStructs/blktrnsfr12.zig").Blktrnsfr12;

///State variables for gases and solutes used in 'trnsfr' to store sub-hourly changes during flux calculations including transformations from nitro.zig, uptake.zig and solute.zig
pub inline fn stateVarsGasSoluteTrnsfr(blk8a: *Blk8a, blk13a: *Blk13a, blk13b: *Blk13b, blk13c: *Blk13c, blktrnsfr1: *Blktrnsfr1, blktrnsfr7: *Blktrnsfr7, blktrnsfr12: *Blktrnsfr12, nhw: u32, nhe: u32, nvn: u32, nvs: u32) !void {
    // co2g, ch4g, oxyg, zn3g, z2gg, z2og, h2gg = gaseous co2, ch4, o2, nh3, n2, n2o, h2
    // co2s, ch4s, oxys, z2gs, z2os, h2gs = aqueous co2, ch4, o2, n2, n2o, h2 in micropores
    // oqc, oqn, oqp, oqa = doc, don, dop, acetate in micropores
    // xoqcs, xoqns, xoqps, xoqas = net change in doc, don, dop, acetate from nitro.zig
    // oqch, oqnh, oqph, oqah = doc, don, dop, acetate in macropores
    // znh4s, znh3s, zno3s, zno2s, h1po4, h2po4 = aqueous nh4, nh3, no3, no2, hpo4, h2po4 in non-band micropores
    // znh4b, znh3b, zno3b, zno2b, h1pob, h2pob = aqueous nh4, nh3, no3, no2, hpo4, h2po4 in band micropores
    // co2sh, ch4sh, oxysh, z2gsh, z2osh, h2gsh = aqueous co2, ch4, o2, n2, n2o, h2 content in macropores
    // znh4sh, znh3sh, zno3sh, zno2sh, h1po4h, h2po4h = aqueous nh4, nh3, no3, no2, hpo4, h2po4 in non-band macropores
    // znh4bh, znh3bh, zno3bh, zno2bh, h1pobh, h2pobh = aqueous nh4, nh3, no3, no2, hpo4, h2po4 in band macropores
    for (nhw..nhe) |nx| {
        for (nvn..nvs) |ny| {
            for (blk8a.nu[nx][ny]..blk8a.nl[nx][ny]) |l| {
                blktrnsfr1.co2g2[nx][ny][l] = blk13b.co2g[nx][ny][l];
                blktrnsfr1.ch4g2[nx][ny][l] = blk13b.ch4g[nx][ny][l];
                blktrnsfr1.oxyg2[nx][ny][l] = blk13b.oxyg[nx][ny][l];
                blktrnsfr1.zn3g2[nx][ny][l] = blk13a.znh3g[nx][ny][l];
                blktrnsfr1.z2gg2[nx][ny][l] = blk13a.z2gg[nx][ny][l];
                blktrnsfr1.z2og2[nx][ny][l] = blk13a.z2og[nx][ny][l];
                blktrnsfr12.h2gg2[nx][ny][l] = blk13c.h2gg[nx][ny][l];
                blktrnsfr1.co2s2[nx][ny][l] = blk13b.co2s[nx][ny][l];
                blktrnsfr1.ch4s2[nx][ny][l] = blk13b.ch4s[nx][ny][l];
                blktrnsfr1.oxys2[nx][ny][l] = blk13b.oxys[nx][ny][l];
                blktrnsfr1.z2gs2[nx][ny][l] = blk13a.z2gs[nx][ny][l];
                blktrnsfr1.z2os2[nx][ny][l] = blk13a.z2os[nx][ny][l];
                blktrnsfr12.h2gs2[nx][ny][l] = blk13b.h2gs[nx][ny][l];

                inline for (0..4) |k| {
                    blktrnsfr1.oqc2[nx][ny][l][k] = blk13a.oqc[nx][ny][l][k] - blk13c.xoqcs[nx][ny][l][k];
                    blktrnsfr1.oqn2[nx][ny][l][k] = blk13a.oqn[nx][ny][l][k] - blk13c.xoqns[nx][ny][l][k];
                    blktrnsfr1.oqp2[nx][ny][l][k] = blk13a.oqp[nx][ny][l][k] - blk13c.xoqps[nx][ny][l][k];
                    blktrnsfr1.oqa2[nx][ny][l][k] = blk13a.oqa[nx][ny][l][k] - blk13c.xoqas[nx][ny][l][k];
                    blktrnsfr7.oqch2[nx][ny][l][k] = blk13a.oqch[nx][ny][l][k];
                    blktrnsfr7.oqnh2[nx][ny][l][k] = blk13a.oqnh[nx][ny][l][k];
                    blktrnsfr7.oqph2[nx][ny][l][k] = blk13a.oqph[nx][ny][l][k];
                    blktrnsfr7.oqah2[nx][ny][l][k] = blk13a.oqah[nx][ny][l][k];
                }

                blktrnsfr1.znh4s2[nx][ny][l] = blk13a.znh4s[nx][ny][l];
                blktrnsfr1.znh3s2[nx][ny][l] = blk13a.znh3s[nx][ny][l];
                blktrnsfr1.zno3s2[nx][ny][l] = blk13a.zno3s[nx][ny][l];
                blktrnsfr1.zno2s2[nx][ny][l] = blk13a.zno2s[nx][ny][l];
                blktrnsfr1.h1po42[nx][ny][l] = blk13a.h1po4[nx][ny][l];
                blktrnsfr1.h2po42[nx][ny][l] = blk13a.h2po4[nx][ny][l];

                blktrnsfr1.znh4b2[nx][ny][l] = blk13a.znh4b[nx][ny][l];
                blktrnsfr1.znh3b2[nx][ny][l] = blk13a.znh3b[nx][ny][l];
                blktrnsfr1.zno3b2[nx][ny][l] = blk13a.zno3b[nx][ny][l];
                blktrnsfr7.zno2b2[nx][ny][l] = blk13a.zno2b[nx][ny][l];
                blktrnsfr1.h1pob2[nx][ny][l] = blk13a.h1pob[nx][ny][l];
                blktrnsfr1.h2pob2[nx][ny][l] = blk13a.h2pob[nx][ny][l];

                blktrnsfr7.co2sh2[nx][ny][l] = blk13b.co2sh[nx][ny][l];
                blktrnsfr7.ch4sh2[nx][ny][l] = blk13b.ch4sh[nx][ny][l];
                blktrnsfr7.oxysh2[nx][ny][l] = blk13b.oxysh[nx][ny][l];
                blktrnsfr7.z2gsh2[nx][ny][l] = blk13a.z2gsh[nx][ny][l];
                blktrnsfr7.z2osh2[nx][ny][l] = blk13a.z2osh[nx][ny][l];
                blktrnsfr12.h2gsh2[nx][ny][l] = blk13c.h2gsh[nx][ny][l];

                blktrnsfr7.znh4h2[nx][ny][l] = blk13a.znh4sh[nx][ny][l];
                blktrnsfr7.znh3h2[nx][ny][l] = blk13a.znh3sh[nx][ny][l];
                blktrnsfr7.zno3h2[nx][ny][l] = blk13a.zno3sh[nx][ny][l];
                blktrnsfr7.zno2h2[nx][ny][l] = blk13a.zno2sh[nx][ny][l];
                blktrnsfr7.h1p4h2[nx][ny][l] = blk13a.h1po4h[nx][ny][l];
                blktrnsfr7.h2p4h2[nx][ny][l] = blk13a.h2po4h[nx][ny][l];

                blktrnsfr7.zn4bh2[nx][ny][l] = blk13a.znh4bh[nx][ny][l];
                blktrnsfr7.zn3bh2[nx][ny][l] = blk13a.znh3bh[nx][ny][l];
                blktrnsfr7.znobh2[nx][ny][l] = blk13a.zno3bh[nx][ny][l];
                blktrnsfr7.zn2bh2[nx][ny][l] = blk13a.zno2bh[nx][ny][l];
                blktrnsfr7.h1pbh2[nx][ny][l] = blk13a.h1pobh[nx][ny][l];
                blktrnsfr7.h2pbh2[nx][ny][l] = blk13a.h2pobh[nx][ny][l];
            }
        }
    }
}
