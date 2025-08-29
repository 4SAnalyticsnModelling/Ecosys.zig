const std = @import("std");
const Blk22a = @import("../globalStructs/blk22a.zig").Blk22a;
const Blk8a = @import("../globalStructs/blk8a.zig").Blk8a;
const Blkc = @import("../globalStructs/blkc.zig").Blkc;
const Blktrnsfr8 = @import("../localStructs/blktrnsfr8.zig").Blktrnsfr8;
const Blktrnsfr12 = @import("../localStructs/blktrnsfr12.zig").Blktrnsfr12;

/// Sub-hourly solute fluxes from subsurface irrigation.
pub inline fn subHourlySoluteFluxSubSurfIrrig(blk22a: *Blk22a, blk8a: *Blk8a, blkc: *Blkc, blktrnsfr8: *Blktrnsfr8, blktrnsfr12: *Blktrnsfr12, nhw: u32, nhe: u32, nvn: u32, nvs: u32) !void {
    // r*flz, r*fbz=subsurface solute flux in non-band,band
    // xnph=1/no. of cycles h-1 for water, heat and solute flux calculations
    for (nhw..nhe) |nx| {
        for (nvn..nvs) |ny| {
            for (blk8a.nu[nx][ny]..blk8a.nl[nx][ny]) |l| {
                blktrnsfr8.rcoflz[nx][ny][l] = blk22a.rcoflu[nx][ny][l] * blkc.xnph;
                blktrnsfr8.rchflz[nx][ny][l] = blk22a.rchflu[nx][ny][l] * blkc.xnph;
                blktrnsfr8.roxflz[nx][ny][l] = blk22a.roxflu[nx][ny][l] * blkc.xnph;
                blktrnsfr8.rngflz[nx][ny][l] = blk22a.rngflu[nx][ny][l] * blkc.xnph;
                blktrnsfr8.rn2flz[nx][ny][l] = blk22a.rn2flu[nx][ny][l] * blkc.xnph;
                blktrnsfr12.rhgflz[nx][ny][l] = blk22a.rhgflu[nx][ny][l] * blkc.xnph;
                blktrnsfr8.rn4flz[nx][ny][l] = blk22a.rn4flu[nx][ny][l] * blkc.xnph;
                blktrnsfr8.rn3flz[nx][ny][l] = blk22a.rn3flu[nx][ny][l] * blkc.xnph;
                blktrnsfr8.rnoflz[nx][ny][l] = blk22a.rnoflu[nx][ny][l] * blkc.xnph;
                blktrnsfr8.rh1pfz[nx][ny][l] = blk22a.rh1pfu[nx][ny][l] * blkc.xnph;
                blktrnsfr8.rh2pfz[nx][ny][l] = blk22a.rh2pfu[nx][ny][l] * blkc.xnph;
                blktrnsfr8.rn4fbz[nx][ny][l] = blk22a.rn4fbu[nx][ny][l] * blkc.xnph;
                blktrnsfr8.rn3fbz[nx][ny][l] = blk22a.rn3fbu[nx][ny][l] * blkc.xnph;
                blktrnsfr8.rnofbz[nx][ny][l] = blk22a.rnofbu[nx][ny][l] * blkc.xnph;
                blktrnsfr8.rh1bbz[nx][ny][l] = blk22a.rh1bbu[nx][ny][l] * blkc.xnph;
                blktrnsfr8.rh2bbz[nx][ny][l] = blk22a.rh2bbu[nx][ny][l] * blkc.xnph;
            }
        }
    }
}
