const std = @import("std");
const Blk10 = @import("../globalStructs/blk10.zig").Blk10;
const Blk11a = @import("../globalStructs/blk11a.zig").Blk11a;
const Blk15a = @import("../globalStructs/blk15a.zig").Blk15a;
const Blk2a = @import("../globalStructs/blk2a.zig").Blk2a;
const Blk2b = @import("../globalStructs/blk2b.zig").Blk2b;
const Blk2c = @import("../globalStructs/blk2c.zig").Blk2c;
const Blk22b = @import("../globalStructs/blk22b.zig").Blk22b;

/// Hourly solute fluxes from atmosphere to soil surface in rainfall and irrigation according to concentrations entered in weather and irrigation files
pub inline fn atmToSurfSoluteFlux(blk10: *Blk10, blk11a: *Blk11a, blk15a: *Blk15a, blk2a: *Blk2a, blk2b: *Blk2b, blk2c: *Blk2c, blk22b: *Blk22b, nx: usize, ny: usize, i: usize) anyerror!void {
    // hourly solute fluxes from atmosphere to snowpack if snowfall and irrigation is zero and snowpack is absent

    // precq, preci = snow + rain, irrigation
    // x*bls = hourly solute flux to snowpack
    // x*fls, x*flb = hourly solute flux to surface litter, soil surface micropore non-band, band

    // solute code:
    // co = co2, ch = ch4, ox = o2, ng = n2, n2 = n2o, hg = h2
    // oc = doc, on = don, op = dop, oa = acetate
    // nh4 = nh4, nh3 = nh3, no3 = no3, no2 = no2, p14 = hpo4, po4 = h2po4 in non-band
    // n4b = nh4, n3b = nh3, nob = no3, n2b = no2, p1b = hpo4, pob = h2po4 in band

    // flqrq, flqri = water flux to surface litter from rain, irrigation
    // flqgq, flqgi = water flux to soil surface from rain, irrigation
    // c*r, c*q = precipitation, irrigation solute concentrations

    // gas code:
    // *co* = co2, *ox* = o2, *ch* = ch4, *ng* = n2, *n2* = n2o, *nh* = nh3, *h2* = h2
    if (blk2a.precw[nx][ny] > 0.0 or (blk2a.precr[nx][ny] > 0.0 and blk10.vhcpwm[nx][ny][0][1] > blk11a.vhcpwx[nx][ny])) {
        blk22b.xcobls[nx][ny][0] = (blk15a.flqgq[nx][ny] * blk2b.ccor[nx][ny] + blk15a.flqgi[nx][ny] * blk2c.ccoq[nx][ny]);
        blk22b.xchbls[nx][ny][0] = (blk15a.flqgq[nx][ny] * blk2b.cchr[nx][ny] + blk15a.flqgi[nx][ny] * blk2c.cchq[nx][ny]);
        blk22b.xoxbls[nx][ny][0] = (blk15a.flqgq[nx][ny] * blk2b.coxr[nx][ny] + blk15a.flqgi[nx][ny] * blk2c.coxq[nx][ny]);
        blk22b.xngbls[nx][ny][0] = (blk15a.flqgq[nx][ny] * blk2b.cnnr[nx][ny] + blk15a.flqgi[nx][ny] * blk2c.cnnq[nx][ny]);
        blk22b.xn2bls[nx][ny][0] = (blk15a.flqgq[nx][ny] * blk2b.cn2r[nx][ny] + blk15a.flqgi[nx][ny] * blk2c.cn2q[nx][ny]);
        blk22b.xn4blw[nx][ny][0] = (blk15a.flqgq[nx][ny] * blk2b.cn4r[nx][ny] + blk15a.flqgi[nx][ny] * blk2b.cn4q[nx][ny][i]) * 14.0;
        blk22b.xn3blw[nx][ny][0] = (blk15a.flqgq[nx][ny] * blk2b.cn3r[nx][ny] + blk15a.flqgi[nx][ny] * blk2b.cn3q[nx][ny][i]) * 14.0;
        blk22b.xnoblw[nx][ny][0] = (blk15a.flqgq[nx][ny] * blk2b.cnor[nx][ny] + blk15a.flqgi[nx][ny] * blk2b.cnoq[nx][ny][i]) * 14.0;
        blk22b.xh1pbs[nx][ny][0] = (blk15a.flqgq[nx][ny] * blk2b.ch1pr[nx][ny] + blk15a.flqgi[nx][ny] * blk2b.ch1pq[nx][ny][i]) * 31.0;
        blk22b.xh2pbs[nx][ny][0] = (blk15a.flqgq[nx][ny] * blk2b.cpor[nx][ny] + blk15a.flqgi[nx][ny] * blk2b.cpoq[nx][ny][i]) * 31.0;
    }
    // hourly solute fluxes from atmosphere to snowpack if snowfall and irrigation is zero and snowpack is absent
    if ((blk2a.precq[nx][ny] > 0.0 or blk2a.preci[nx][ny] > 0.0) and blk10.vhcpwm[nx][ny][0][1] <= blk11a.vhcpwx[nx][ny]) {
        blk15a.xcofls[nx][ny][2][0] = (blk15a.flqrq[nx][ny] * blk2b.ccor[nx][ny] + blk15a.flqri[nx][ny] * blk2c.ccoq[nx][ny]);
        blk15a.xchfls[nx][ny][2][0] = (blk15a.flqrq[nx][ny] * blk2b.cchr[nx][ny] + blk15a.flqri[nx][ny] * blk2c.cchq[nx][ny]);
        blk15a.xoxfls[nx][ny][2][0] = (blk15a.flqrq[nx][ny] * blk2b.coxr[nx][ny] + blk15a.flqri[nx][ny] * blk2c.coxq[nx][ny]);
        blk15a.xngfls[nx][ny][2][0] = (blk15a.flqrq[nx][ny] * blk2b.cnnr[nx][ny] + blk15a.flqri[nx][ny] * blk2c.cnnq[nx][ny]);
        blk15a.xn2fls[nx][ny][2][0] = (blk15a.flqrq[nx][ny] * blk2b.cn2r[nx][ny] + blk15a.flqri[nx][ny] * blk2c.cn2q[nx][ny]);
        blk15a.xn4flw[nx][ny][2][0] = (blk15a.flqrq[nx][ny] * blk2b.cn4r[nx][ny] + blk15a.flqri[nx][ny] * blk2b.cn4q[nx][ny][i]) * 14.0;
        blk15a.xn3flw[nx][ny][2][0] = (blk15a.flqrq[nx][ny] * blk2b.cn3r[nx][ny] + blk15a.flqri[nx][ny] * blk2b.cn3q[nx][ny][i]) * 14.0;
        blk15a.xnoflw[nx][ny][2][0] = (blk15a.flqrq[nx][ny] * blk2b.cnor[nx][ny] + blk15a.flqri[nx][ny] * blk2b.cnoq[nx][ny][i]) * 14.0;
        blk15a.xh1pfs[nx][ny][2][0] = (blk15a.flqrq[nx][ny] * blk2b.ch1pr[nx][ny] + blk15a.flqri[nx][ny] * blk2b.ch1pq[nx][ny][i]) * 31.0;
        blk15a.xh2pfs[nx][ny][2][0] = (blk15a.flqrq[nx][ny] * blk2b.cpor[nx][ny] + blk15a.flqri[nx][ny] * blk2b.cpoq[nx][ny][i]) * 31.0;
    }
}
