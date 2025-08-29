const std = @import("std");
const Blk13c = @import("../globalStructs/blk13c.zig").Blk13c;
const Blk2b = @import("../globalStructs/blk2b.zig").Blk2b;
const Blk2c = @import("../globalStructs/blk2c.zig").Blk2c;
const Blk22a = @import("../globalStructs/blk22a.zig").Blk22a;
const Blk8a = @import("../globalStructs/blk8a.zig").Blk8a;
/// Solute fluxes from subsurface irrigation.
pub inline fn soluteFluxSubSurfIrrig(blk13c: *Blk13c, blk2b: *Blk2b, blk2c: *Blk2c, blk22a: *Blk22a, blk8a: *Blk8a, nhw: u32, nhe: u32, nvn: u32, nvs: u32, i: u64) !void {
    // flu=subsurface water flux from watsub.zig
    // r*flu,r*fbu=subsurface solute flux in non-band,band
    // solute code:co=co2,ch=ch4,ox=o2,ng=n2,n2=n2o,hg=h2
    //             :oc=doc,on=don,op=dop,oa=acetate
    //             :nh4=nh4,nh3=nh3,no3=no3,no2=no2,p14=hpo4,po4=h2po4 in non-band
    //             :n4b=nh4,n3b=nh3,nob=no3,n2b=no2,p1b=hpo4,pob=h2po4 in band
    // c*q=irrigation solute concentrations
    // vlnh4,vlno3,vlpo4=non-band nh4,no3,po4 volume fraction
    // vlnhb,vlnob,vlpob=band nh4,no3,po4 volume fraction

    // const stdout = std.io.getStdOut().writer();
    for (nhw..nhe) |nx| {
        for (nvn..nvs) |ny| {
            for (blk8a.nu[nx][ny]..blk8a.nl[nx][ny]) |l| {
                // try stdout.print("Number of soil layer :{}\n", .{l});
                blk22a.rcoflu[nx][ny][l] = blk22a.flu[nx][ny][l] * blk2c.ccoq[nx][ny];
                blk22a.rchflu[nx][ny][l] = blk22a.flu[nx][ny][l] * blk2c.cchq[nx][ny];
                blk22a.roxflu[nx][ny][l] = blk22a.flu[nx][ny][l] * blk2c.coxq[nx][ny];
                blk22a.rngflu[nx][ny][l] = blk22a.flu[nx][ny][l] * blk2c.cnnq[nx][ny];
                blk22a.rn2flu[nx][ny][l] = blk22a.flu[nx][ny][l] * blk2c.cn2q[nx][ny];
                // blk22a.rhgflu[nx][ny][l] = 0.0;
                blk22a.rn4flu[nx][ny][l] = blk22a.flu[nx][ny][l] * blk2b.cn4q[nx][ny][i] * blk13c.vlnh4[nx][ny][l] * 14.0;
                blk22a.rn3flu[nx][ny][l] = blk22a.flu[nx][ny][l] * blk2b.cn3q[nx][ny][i] * blk13c.vlnh4[nx][ny][l] * 14.0;
                blk22a.rnoflu[nx][ny][l] = blk22a.flu[nx][ny][l] * blk2b.cnoq[nx][ny][i] * blk13c.vlno3[nx][ny][l] * 14.0;
                blk22a.rh1pfu[nx][ny][l] = blk22a.flu[nx][ny][l] * blk2b.ch1pq[nx][ny][i] * blk13c.vlpo4[nx][ny][l] * 31.0;
                blk22a.rh2pfu[nx][ny][l] = blk22a.flu[nx][ny][l] * blk2b.cpoq[nx][ny][i] * blk13c.vlpo4[nx][ny][l] * 31.0;
                blk22a.rn4fbu[nx][ny][l] = blk22a.flu[nx][ny][l] * blk2b.cn4q[nx][ny][i] * blk13c.vlnhb[nx][ny][l] * 14.0;
                blk22a.rn3fbu[nx][ny][l] = blk22a.flu[nx][ny][l] * blk2b.cn3q[nx][ny][i] * blk13c.vlnhb[nx][ny][l] * 14.0;
                blk22a.rnofbu[nx][ny][l] = blk22a.flu[nx][ny][l] * blk2b.cnoq[nx][ny][i] * blk13c.vlnob[nx][ny][l] * 14.0;
                blk22a.rh1bbu[nx][ny][l] = blk22a.flu[nx][ny][l] * blk2b.ch1pq[nx][ny][i] * blk13c.vlpob[nx][ny][l] * 31.0;
                blk22a.rh2bbu[nx][ny][l] = blk22a.flu[nx][ny][l] * blk2b.cpoq[nx][ny][i] * blk13c.vlpob[nx][ny][l] * 31.0;
            }
        }
    }
}
