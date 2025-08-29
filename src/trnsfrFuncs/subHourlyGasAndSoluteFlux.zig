const std = @import("std");
const Blk8a = @import("../globalStructs/blk8a.zig").Blk8a;
const Blk15a = @import("../globalStructs/blk15a.zig").Blk15a;
const Blk22b = @import("../globalStructs/blk22b.zig").Blk22b;
const Blkc = @import("../globalStructs/blkc.zig").Blkc;
const Blktrnsfr10 = @import("../localStructs/blktrnsfr10.zig").Blktrnsfr10;
const Blktrnsfr13 = @import("../localStructs/blktrnsfr13.zig").Blktrnsfr13;

/// Gas and solute fluxes at sub-hourly flux time step entered in site file.
pub inline fn subHourlyGasAndSoluteFlux(blk8a: *Blk8a, blk15a: *Blk15a, blk22b: *Blk22b, blkc: *Blkc, blktrnsfr10: *Blktrnsfr10, blktrnsfr13: *Blktrnsfr13, nhw: u32, nhe: u32, nvn: u32, nvs: u32) !void {
    // xnph=1/no. of cycles h-1 for water, heat and solute flux calculations
    // r*bls, r*fl0, r*fl1, r*fl2=solute flux to snowpack, surface litter, soil surface non-band, band
    // solute code:co=co2, ch=ch4, ox=o2, ng=n2, n2=n2o, hg=h2
    //             :oc=doc, on=don, op=dop, oa=acetate
    //             :nh4=nh4, nh3=nh3, no3=no3, no2=no2, p14=hpo4, po4=h2po4 in non-band
    //             :n4b=nh4, n3b=nh3, nob=no3, n2b=no2, p1b=hpo4, pob=h2po4 in band
    // gas code: *co*=co2, *ox*=o2, *ch*=ch4, *ng*=n2, *n2*=n2o, *nh*=nh3, *h2*=h2
    for (nhw..nhe) |nx| {
        for (nvn..nvs) |ny| {
            inline for (0..3) |k| {
                blktrnsfr13.rocfl0[nx][ny][k] = blk15a.xocfls[nx][ny][0][2][k] * blkc.xnph;
                blktrnsfr13.ronfl0[nx][ny][k] = blk15a.xonfls[nx][ny][0][2][k] * blkc.xnph;
                blktrnsfr13.ropfl0[nx][ny][k] = blk15a.xopfls[nx][ny][0][2][k] * blkc.xnph;
                blktrnsfr13.roafl0[nx][ny][k] = blk15a.xoafls[nx][ny][0][2][k] * blkc.xnph;
                blktrnsfr13.rocfl1[nx][ny][k] = blk15a.xocfls[nx][ny][blk8a.nu[nx][ny]][2][k] * blkc.xnph;
                blktrnsfr13.ronfl1[nx][ny][k] = blk15a.xonfls[nx][ny][blk8a.nu[nx][ny]][2][k] * blkc.xnph;
                blktrnsfr13.ropfl1[nx][ny][k] = blk15a.xopfls[nx][ny][blk8a.nu[nx][ny]][2][k] * blkc.xnph;
                blktrnsfr13.roafl1[nx][ny][k] = blk15a.xoafls[nx][ny][blk8a.nu[nx][ny]][2][k] * blkc.xnph;
            }
            blktrnsfr10.rcobls[nx][ny][0] = blk22b.xcobls[nx][ny][0] * blkc.xnph;
            blktrnsfr10.rchbls[nx][ny][0] = blk22b.xchbls[nx][ny][0] * blkc.xnph;
            blktrnsfr10.roxbls[nx][ny][0] = blk22b.xoxbls[nx][ny][0] * blkc.xnph;
            blktrnsfr10.rngbls[nx][ny][0] = blk22b.xngbls[nx][ny][0] * blkc.xnph;
            blktrnsfr10.rn2bls[nx][ny][0] = blk22b.xn2bls[nx][ny][0] * blkc.xnph;
            blktrnsfr10.rn4blw[nx][ny][0] = blk22b.xn4blw[nx][ny][0] * blkc.xnph;
            blktrnsfr10.rn3blw[nx][ny][0] = blk22b.xn3blw[nx][ny][0] * blkc.xnph;
            blktrnsfr10.rnoblw[nx][ny][0] = blk22b.xnoblw[nx][ny][0] * blkc.xnph;
            blktrnsfr10.rh1pbs[nx][ny][0] = blk22b.xh1pbs[nx][ny][0] * blkc.xnph;
            blktrnsfr13.rchfl0[nx][ny] = blk15a.xchfls[nx][ny][0][2] * blkc.xnph;
            blktrnsfr13.roxfl0[nx][ny] = blk15a.xoxfls[nx][ny][0][2] * blkc.xnph;
            blktrnsfr13.rngfl0[nx][ny] = blk15a.xngfls[nx][ny][0][2] * blkc.xnph;
            blktrnsfr13.rn2fl0[nx][ny] = blk15a.xn2fls[nx][ny][0][2] * blkc.xnph;
            blktrnsfr13.rhgfl0[nx][ny] = blk15a.xhgfls[nx][ny][0][2] * blkc.xnph;
            blktrnsfr13.rn4fl0[nx][ny] = blk15a.xn4flw[nx][ny][0][2] * blkc.xnph;
            blktrnsfr13.rn3fl0[nx][ny] = blk15a.xn3flw[nx][ny][0][2] * blkc.xnph;
            blktrnsfr13.rnofl0[nx][ny] = blk15a.xnoflw[nx][ny][0][2] * blkc.xnph;
            blktrnsfr13.rnxfl0[nx][ny] = blk15a.xnxfls[nx][ny][0][2] * blkc.xnph;
            blktrnsfr13.rh1pf0[nx][ny] = blk15a.xh1pfs[nx][ny][0][2] * blkc.xnph;
            blktrnsfr13.rh2pf0[nx][ny] = blk15a.xh2pfs[nx][ny][0][2] * blkc.xnph;
            blktrnsfr13.rcofl1[nx][ny] = blk15a.xcofls[nx][ny][blk8a.nu[nx][ny]][2] * blkc.xnph;
            blktrnsfr13.rchfl1[nx][ny] = blk15a.xchfls[nx][ny][blk8a.nu[nx][ny]][2] * blkc.xnph;
            blktrnsfr13.roxfl1[nx][ny] = blk15a.xoxfls[nx][ny][blk8a.nu[nx][ny]][2] * blkc.xnph;
            blktrnsfr13.rngfl1[nx][ny] = blk15a.xngfls[nx][ny][blk8a.nu[nx][ny]][2] * blkc.xnph;
            blktrnsfr13.rn2fl1[nx][ny] = blk15a.xn2fls[nx][ny][blk8a.nu[nx][ny]][2] * blkc.xnph;
            blktrnsfr13.rn4fl1[nx][ny] = blk15a.xn4flw[nx][ny][blk8a.nu[nx][ny]][2] * blkc.xnph;
            blktrnsfr13.rn3fl1[nx][ny] = blk15a.xn3flw[nx][ny][blk8a.nu[nx][ny]][2] * blkc.xnph;
            blktrnsfr13.rnofl1[nx][ny] = blk15a.xnoflw[nx][ny][blk8a.nu[nx][ny]][2] * blkc.xnph;
            blktrnsfr13.rnxfl1[nx][ny] = blk15a.xnxfls[nx][ny][blk8a.nu[nx][ny]][2] * blkc.xnph;
            blktrnsfr13.rh1pf1[nx][ny] = blk15a.xh1pfs[nx][ny][blk8a.nu[nx][ny]][2] * blkc.xnph;
            blktrnsfr13.rh2pf1[nx][ny] = blk15a.xh2pfs[nx][ny][blk8a.nu[nx][ny]][2] * blkc.xnph;
            blktrnsfr13.rn4fl2[nx][ny] = blk15a.xn4flb[nx][ny][blk8a.nu[nx][ny]][2] * blkc.xnph;
            blktrnsfr13.rn3fl2[nx][ny] = blk15a.xn3flb[nx][ny][blk8a.nu[nx][ny]][2] * blkc.xnph;
            blktrnsfr13.rnofl2[nx][ny] = blk15a.xnoflb[nx][ny][blk8a.nu[nx][ny]][2] * blkc.xnph;
            blktrnsfr13.rnxfl2[nx][ny] = blk15a.xnxflb[nx][ny][blk8a.nu[nx][ny]][2] * blkc.xnph;
            blktrnsfr13.rh1bf2[nx][ny] = blk15a.xh1bfb[nx][ny][blk8a.nu[nx][ny]][2] * blkc.xnph;
            blktrnsfr13.rh2bf2[nx][ny] = blk15a.xh2bfb[nx][ny][blk8a.nu[nx][ny]][2] * blkc.xnph;
        }
    }
}
