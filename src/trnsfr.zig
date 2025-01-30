const std = @import("std");
const config = @import("config");
const Blk13b = @import("globalStructs/blk13b.zig").Blk13b;
const Blk13c = @import("globalStructs/blk13c.zig").Blk13c;
const Blk21a = @import("globalStructs/blk21a.zig").Blk21a;
const Blk21b = @import("globalStructs/blk21b.zig").Blk21b;
const Blkc = @import("globalStructs/blkc.zig").Blkc;
const Blktrnsfr1 = @import("localStructs/blktrnsfr1.zig").Blktrnsfr1;
const Blktrnsfr2 = @import("localStructs/blktrnsfr2.zig").Blktrnsfr2;
const Blktrnsfr3 = @import("localStructs/blktrnsfr3.zig").Blktrnsfr3;
const Blktrnsfr4 = @import("localStructs/blktrnsfr4.zig").Blktrnsfr4;
const Blktrnsfr5 = @import("localStructs/blktrnsfr5.zig").Blktrnsfr5;
const Blktrnsfr6 = @import("localStructs/blktrnsfr6.zig").Blktrnsfr6;
const Blktrnsfr7 = @import("localStructs/blktrnsfr7.zig").Blktrnsfr7;
const Blktrnsfr8 = @import("localStructs/blktrnsfr8.zig").Blktrnsfr8;
const Blktrnsfr9 = @import("localStructs/blktrnsfr9.zig").Blktrnsfr9;
const Blktrnsfr10 = @import("localStructs/blktrnsfr10.zig").Blktrnsfr10;
const Blktrnsfr11 = @import("localStructs/blktrnsfr11.zig").Blktrnsfr11;
const Blktrnsfr12 = @import("localStructs/blktrnsfr12.zig").Blktrnsfr12;
const Blktrnsfr13 = @import("localStructs/blktrnsfr13.zig").Blktrnsfr13;
const Blktrnsfr14 = @import("localStructs/blktrnsfr14.zig").Blktrnsfr14;
const Blktrnsfrparams = @import("localStructs/blktrnsfrparams.zig").Blktrnsfrparams;
const residueGasSoluteSourceSink = @import("trnsfrFuncs/residueGasSoluteSourceSink.zig").residueGasSoluteSourceSink;
pub fn trnsfr(blk13b: *Blk13b, blk13c: *Blk13c, blk21a: *Blk21a, blk21b: *Blk21b, blkc: *Blkc) anyerror!void {
    // const blktrnsfrparams: Blktrnsfrparams = Blktrnsfrparams.init();
    var blktrnsfr2: Blktrnsfr2 = Blktrnsfr2.init();
    for (0..600) |_| {
        for (0..2) |nx| {
            for (0..2) |ny| {
                try residueGasSoluteSourceSink(blk13b, blk13c, blk21a, blk21b, blkc, &blktrnsfr2, nx, ny);
            }
        }
    }
    // var blktrnsfr4: Blktrnsfr4 = Blktrnsfr4.init();
    // var blktrnsfr5: Blktrnsfr5 = Blktrnsfr5.init();
    // var blktrnsfr6: Blktrnsfr6 = Blktrnsfr6.init();
    // var blktrnsfr7: Blktrnsfr7 = Blktrnsfr7.init();
    // var blktrnsfr8: Blktrnsfr8 = Blktrnsfr8.init();
    // var blktrnsfr9: Blktrnsfr9 = Blktrnsfr9.init();
    // var blktrnsfr10: Blktrnsfr10 = Blktrnsfr10.init();
    // var blktrnsfr11: Blktrnsfr11 = Blktrnsfr11.init();
    // var blktrnsfr12: Blktrnsfr12 = Blktrnsfr12.init();
    // var blktrnsfr13: Blktrnsfr13 = Blktrnsfr13.init();
    // var blktrnsfr14: Blktrnsfr14 = Blktrnsfr14.init();
    //
    // blktrnsfr1.icgsgl2[0][0][0] = 10;
    // blktrnsfr2.r1ps2k[0][0][0] = 2.0;
    // blktrnsfr3.cls2gl[0][0][0] = 100.0;
    // blktrnsfr4.rchfhs[0][0][0][0] = 3.0;
    // blktrnsfr5.rchdfg[0][0][0] = 2.0;
    // blktrnsfr6.rchbbl[0][0][0] = 2.0;
    // blktrnsfr7.ch4sh2[0][0][0] = 2.0;
    // blktrnsfr8.rchflz[0][0][0] = 2.0;
    // blktrnsfr9.rchfxs[0][0][0] = 2.0;
    // blktrnsfr10.rchbls[0][0][0] = 2.0;
    // blktrnsfr11.coqph1[0] = 5.0;
    // blktrnsfr12.h2gsh2[0][0][0] = 2.0;
    // blktrnsfr13.rocfl0[0][0][0] = 2.0;
    // blktrnsfr14.rqron0[0][0][0] = 2.0;
    // _ = blktrnsfrparams;
}
