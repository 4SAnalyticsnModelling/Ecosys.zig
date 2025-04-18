const std = @import("std");
const config = @import("config");
const Blk10 = @import("globalStructs/blk10.zig").Blk10;
const Blk11a = @import("globalStructs/blk11a.zig").Blk11a;
const Blk11b = @import("globalStructs/blk11b.zig").Blk11b;
const Blk12a = @import("globalStructs/blk12a.zig").Blk12a;
const Blk12b = @import("globalStructs/blk12b.zig").Blk12b;
const Blk13a = @import("globalStructs/blk13a.zig").Blk13a;
const Blk13b = @import("globalStructs/blk13b.zig").Blk13b;
const Blk13c = @import("globalStructs/blk13c.zig").Blk13c;
const Blk13d = @import("globalStructs/blk13d.zig").Blk13d;
const Blk14 = @import("globalStructs/blk14.zig").Blk14;
const Blk15a = @import("globalStructs/blk15a.zig").Blk15a;
const Blk15b = @import("globalStructs/blk15b.zig").Blk15b;
const Blk16 = @import("globalStructs/blk16.zig").Blk16;
const Blk17 = @import("globalStructs/blk17.zig").Blk17;
const Blk18a = @import("globalStructs/blk18a.zig").Blk18a;
const Blk18b = @import("globalStructs/blk18b.zig").Blk18b;
const Blk19a = @import("globalStructs/blk19a.zig").Blk19a;
const Blk19b = @import("globalStructs/blk19b.zig").Blk19b;
const Blk19c = @import("globalStructs/blk19c.zig").Blk19c;
const Blk19d = @import("globalStructs/blk19d.zig").Blk19d;
const Blk1cp = @import("globalStructs/blk1cp.zig").Blk1cp;
const Blk1cr = @import("globalStructs/blk1cr.zig").Blk1cr;
const Blk1g = @import("globalStructs/blk1g.zig").Blk1g;
const Blk1n = @import("globalStructs/blk1n.zig").Blk1n;
const Blk1p = @import("globalStructs/blk1p.zig").Blk1p;
const Blk1s = @import("globalStructs/blk1s.zig").Blk1s;
const Blk1u = @import("globalStructs/blk1u.zig").Blk1u;
const Blk20a = @import("globalStructs/blk20a.zig").Blk20a;
const Blk20b = @import("globalStructs/blk20b.zig").Blk20b;
const Blk20c = @import("globalStructs/blk20c.zig").Blk20c;
const Blk20d = @import("globalStructs/blk20d.zig").Blk20d;
const Blk20e = @import("globalStructs/blk20e.zig").Blk20e;
const Blk20f = @import("globalStructs/blk20f.zig").Blk20f;
const Blk21a = @import("globalStructs/blk21a.zig").Blk21a;
const Blk21b = @import("globalStructs/blk21b.zig").Blk21b;
const Blk22a = @import("globalStructs/blk22a.zig").Blk22a;
const Blk22b = @import("globalStructs/blk22b.zig").Blk22b;
const Blk22c = @import("globalStructs/blk22c.zig").Blk22c;
const Blk2a = @import("globalStructs/blk2a.zig").Blk2a;
const Blk2b = @import("globalStructs/blk2b.zig").Blk2b;
const Blk2c = @import("globalStructs/blk2c.zig").Blk2c;
const Blk3 = @import("globalStructs/blk3.zig").Blk3;
const Blk5 = @import("globalStructs/blk5.zig").Blk5;
const Blk6 = @import("globalStructs/blk6.zig").Blk6;
const Blk8a = @import("globalStructs/blk8a.zig").Blk8a;
const Blk8b = @import("globalStructs/blk8b.zig").Blk8b;
const Blk9a = @import("globalStructs/blk9a.zig").Blk9a;
const Blk9b = @import("globalStructs/blk9b.zig").Blk9b;
const Blk9c = @import("globalStructs/blk9c.zig").Blk9c;
const Blkc = @import("globalStructs/blkc.zig").Blkc;
const Filec = @import("globalStructs/filec.zig").Filec;
const Files = @import("globalStructs/files.zig").Files;
const trnsfr = @import("trnsfr.zig").trnsfr;

// inline fn modifyBlk11b(blk11b: *Blk11b) void {
//     blk11b.zlsgl[0][0][0] += 3.0;
//     const hey = computeZlsgl(blk11b.zlsgl[0][0][0]);
//     blk11b.zlsgl[0][0][0] = hey;
// }
//
// inline fn computeZlsgl(x: f32) f32 {
//     const step1 = x + 6.0 - (3.0 * 2.0) / 4.0;
//     const step2 = @min(step1, @abs(x - 5.0));
//     const step3 = @max(step2, @log(x + 1.0));
//     return std.math.pow(f32, step3, 2.0);
// }

pub fn main() anyerror!void {
    const stdout = std.io.getStdOut().writer();
    var blk11b: Blk11b = Blk11b.init();
    var blk10: Blk10 = Blk10.init();
    var blk11a: Blk11a = Blk11a.init();
    var blk12a: Blk12a = Blk12a.init();
    var blk12b: Blk12b = Blk12b.init();
    var blk13a: Blk13a = Blk13a.init();
    var blk13b: Blk13b = Blk13b.init();
    var blk13c: Blk13c = Blk13c.init();
    var blk13d: Blk13d = Blk13d.init();
    var blk14: Blk14 = Blk14.init();
    var blk15a: Blk15a = Blk15a.init();
    var blk15b: Blk15b = Blk15b.init();
    var blk16: Blk16 = Blk16.init();
    const blk17: Blk17 = Blk17.init();
    var blk18a: Blk18a = Blk18a.init();
    var blk18b: Blk18b = Blk18b.init();
    var blk19a: Blk19a = Blk19a.init();
    var blk19b: Blk19b = Blk19b.init();
    var blk19c: Blk19c = Blk19c.init();
    var blk19d: Blk19d = Blk19d.init();
    var blk1cp: Blk1cp = Blk1cp.init();
    var blk1cr: Blk1cr = Blk1cr.init();
    var blk1g: Blk1g = Blk1g.init();
    var blk1n: Blk1n = Blk1n.init();
    var blk1p: Blk1p = Blk1p.init();
    var blk1s: Blk1s = Blk1s.init();
    var blk1u: Blk1u = Blk1u.init();
    var blk20a: Blk20a = Blk20a.init();
    var blk20b: Blk20b = Blk20b.init();
    var blk20c: Blk20c = Blk20c.init();
    var blk20d: Blk20d = Blk20d.init();
    var blk20e: Blk20e = Blk20e.init();
    var blk20f: Blk20f = Blk20f.init();
    var blk21a: Blk21a = Blk21a.init();
    var blk21b: Blk21b = Blk21b.init();
    var blk22a: Blk22a = Blk22a.init();
    var blk22b: Blk22b = Blk22b.init();
    var blk22c: Blk22c = Blk22c.init();
    var blk2a: Blk2a = Blk2a.init();
    var blk2b: Blk2b = Blk2b.init();
    var blk2c: Blk2c = Blk2c.init();
    var blk3: Blk3 = Blk3.init();
    var blk5: Blk5 = Blk5.init();
    var blk6: Blk6 = Blk6.init();
    var blk8a: Blk8a = Blk8a.init();
    var blk8b: Blk8b = Blk8b.init();
    var blk9a: Blk9a = Blk9a.init();
    var blk9b: Blk9b = Blk9b.init();
    var blk9c: Blk9c = Blk9c.init();
    var blkc: Blkc = Blkc.init();

    try stdout.print("Initial blk11b.zlsgl[0][0][0]: {}\n", .{blk11b.zlsgl[0][0][0]});
    blk10.qrm[0][0][0] = 42.0;
    try stdout.print("blk10.qrm[0][0][0] : {}\n", .{blk10.qrm[0][0][0]});
    blk11a.tcs[0][0][0] = 43.0;
    blk11b.wgsgr[0][0] = 41.0;
    blk12a.roxyz[0][0][0] = 76.0;
    blk12b.rh2gz[0][0][0] = 23.0;
    blk13a.h1pobh[0][0][0] = 23.0;
    blk13b.oxyg[0][0][0] = 23.0;
    blk13c.cfosc[0][0][0][0][0] = 23.0;
    blk13d.fosrh[0][0][0][0] = 23.0;
    blk14.balc[0][0][0] = 23.0;
    blk15a.qs[0][0][0] = 23.0;
    blk15b.xh1bhb[0][0][0][0] = 23.0;
    blk16.tlno3 = 103.0;
    try stdout.print("blk17 : {}\n", .{blk17.icor[0]});
    blk18a.tco2s[0][0][0] = 23.0;
    blk18b.rno3y[0][0][0] = 23.0;
    blk19a.zal[0][0][0] = 23.0;
    blk19b.ecnd[0][0][0] = 23.0;
    blk19c.zmgoh[0][0][0] = 23.0;
    blk19d.co2w[0][0][0] = 23.0;
    blk20a.xqsso[0][0][0] = 23.0;
    blk20b.xmgofs[0][0][0][0] = 23.0;
    blk20c.xmgohs[0][0][0][0] = 23.0;
    blk20d.xn4fxb[0][0][0] = 23.0;
    blk20e.xh0pxs[0][0][0] = 23.0;
    blk20f.xfe2er[0][0][0][0] = 23.0;
    blk21a.tral[0][0][0] = 23.0;
    blk21b.trxh0[0][0][0] = 23.0;
    blk22a.flu[0][0][0] = 23.0;
    blk22b.rc2pfu[0][0][0] = 23.0;
    blk22c.xmghbs[0][0][0] = 23.0;
    blk1cp.pp[0][0][0] = 23.0;
    blk1cr.wtrt[0][0][0] = 23.0;
    blk1g.zc[0][0][0] = 23.0;
    blk1n.wtshn[0][0][0] = 23.0;
    blk1p.wtshp[0][0][0] = 23.0;
    blk1s.htshex[0][0][0][0] = 23.0;
    blk1u.raz[0][0][0] = 23.0;
    blk2a.dylx[0][0] = 23.0;
    blk2b.phq[0][0][0] = 23.0;
    blk2c.ccau[0][0][0] = 23.0;
    blk3.nb1[0][0][0] = 23.0;
    blk5.zl[0][0][0] = 23.0;
    blk6.tavg2 = 12.0;
    blk8a.fc[0][0][0] = 23.0;
    blk8b.psl[0][0][0] = 23.0;
    blk9a.pb[0][0][0] = 23.0;
    blk9b.pr[0][0][0] = 23.0;
    blk9c.ppi[0][0][0] = 23.0;
    blkc.npr = 10;

    const nhw: u32 = 0;
    const nhe: u32 = 2;
    const nvn: u32 = 0;
    const nvs: u32 = 2;

    for (nhw..nhe) |nx| {
        for (nvn..nvs) |ny| {
            blk8a.nl[nx][ny] = 10;
        }
    }

    for (0..366) |i| {
        for (0..24) |_| {
            try trnsfr(i, nhw, nhe, nvn, nvs, &blk10, &blk11a, &blk11b, &blk13a, &blk13b, &blk13c, &blk15a, &blk18a, &blk18b, &blk19d, &blk2a, &blk2b, &blk2c, &blk21a, &blk21b, &blk22a, &blk22b, &blk8a, &blkc);
        }
    }

    try stdout.print("Modified blk11b.zlsgl[0][0][0]: {}\n", .{blk11b.zlsgl[0][0][0]});
    // const waitTime: usize = 20 * std.time.ns_per_s;
    // std.time.sleep(waitTime);
}
