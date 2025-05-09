const std = @import("std");
const config = @import("config");
const Blk10 = @import("globalStructs/blk10.zig").Blk10;
const Blk11a = @import("globalStructs/blk11a.zig").Blk11a;
const Blk11b = @import("globalStructs/blk11b.zig").Blk11b;
const Blk13a = @import("globalStructs/blk13a.zig").Blk13a;
const Blk13b = @import("globalStructs/blk13b.zig").Blk13b;
const Blk13c = @import("globalStructs/blk13c.zig").Blk13c;
const Blk15a = @import("globalStructs/blk15a.zig").Blk15a;
const Blk18a = @import("globalStructs/blk18a.zig").Blk18a;
const Blk18b = @import("globalStructs/blk18b.zig").Blk18b;
const Blk19d = @import("globalStructs/blk19d.zig").Blk19d;
const Blk2a = @import("globalStructs/blk2a.zig").Blk2a;
const Blk2b = @import("globalStructs/blk2b.zig").Blk2b;
const Blk2c = @import("globalStructs/blk2c.zig").Blk2c;
const Blk21a = @import("globalStructs/blk21a.zig").Blk21a;
const Blk21b = @import("globalStructs/blk21b.zig").Blk21b;
const Blk22a = @import("globalStructs/blk22a.zig").Blk22a;
const Blk22b = @import("globalStructs/blk22b.zig").Blk22b;
const Blk8a = @import("globalStructs/blk8a.zig").Blk8a;
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
const initStateVarsGasSoluteFluxCalc = @import("trnsfrFuncs/initStateVarsGasSoluteFluxCalc.zig").initStateVarsGasSoluteFluxCalc;
const atmToSurfSoluteFlux = @import("trnsfrFuncs/atmToSurfSoluteFlux.zig").atmToSurfSoluteFlux;
const subHourlyGasAndSoluteFlux = @import("trnsfrFuncs/subHourlyGasAndSoluteFlux.zig").subHourlyGasAndSoluteFlux;
const soilGasSoluteSourceSink = @import("trnsfrFuncs/soilGasSoluteSourceSink.zig").soilGasSoluteSourceSink;
const initSnowpackSolute = @import("trnsfrFuncs/initSnowpackSolute.zig").initSnowpackSolute;
const soluteFluxWaterNitroUptakeSolute = @import("trnsfrFuncs/soluteFluxWaterNitroUptakeSolute.zig").soluteFluxWaterNitroUptakeSolute;
const soluteFluxSubSurfIrrig = @import("trnsfrFuncs/soluteFluxSubSurfIrrig.zig").soluteFluxSubSurfIrrig;
const subHourlySoluteFluxSubSurfIrrig = @import("trnsfrFuncs/subHourlySoluteFluxSubSurfIrrig.zig").subHourlySoluteFluxSubSurfIrrig;
const subHourlyGasSoluteDiffusvty = @import("trnsfrFuncs/subHourlyGasSoluteDiffusvty.zig").subHourlyGasSoluteDiffusvty;
const stateVarsGasSoluteTrnsfr = @import("trnsfrFuncs/stateVarsGasSoluteTrnsfr.zig").stateVarsGasSoluteTrnsfr;

pub fn trnsfr(i: usize, nhw: u32, nhe: u32, nvn: u32, nvs: u32, blk10: *Blk10, blk11a: *Blk11a, blk11b: *Blk11b, blk13a: *Blk13a, blk13b: *Blk13b, blk13c: *Blk13c, blk15a: *Blk15a, blk18a: *Blk18a, blk18b: *Blk18b, blk19d: *Blk19d, blk2a: *Blk2a, blk2b: *Blk2b, blk2c: *Blk2c, blk21a: *Blk21a, blk21b: *Blk21b, blk22a: *Blk22a, blk22b: *Blk22b, blk8a: *Blk8a, blkc: *Blkc) anyerror!void {
    // const blktrnsfrparams: Blktrnsfrparams = Blktrnsfrparams.init();
    var blktrnsfr1: Blktrnsfr1 = Blktrnsfr1.init();
    var blktrnsfr2: Blktrnsfr2 = Blktrnsfr2.init();
    var blktrnsfr3: Blktrnsfr3 = Blktrnsfr3.init();
    var blktrnsfr7: Blktrnsfr7 = Blktrnsfr7.init();
    var blktrnsfr8: Blktrnsfr8 = Blktrnsfr8.init();
    var blktrnsfr10: Blktrnsfr10 = Blktrnsfr10.init();
    var blktrnsfr12: Blktrnsfr12 = Blktrnsfr12.init();
    var blktrnsfr13: Blktrnsfr13 = Blktrnsfr13.init();
    try residueGasSoluteSourceSink(blk13b, blk13c, blk21a, blk21b, blkc, &blktrnsfr2, nhw, nhe, nvn, nvs);
    try initStateVarsGasSoluteFluxCalc(blk13a, blk13b, blk13c, blk8a, &blktrnsfr1, &blktrnsfr12, nhw, nhe, nvn, nvs);
    try atmToSurfSoluteFlux(blk10, blk11a, blk15a, blk2a, blk2b, blk2c, blk22b, nhw, nhe, nvn, nvs, i);
    try subHourlyGasAndSoluteFlux(blk8a, blk15a, blk22b, blkc, &blktrnsfr10, &blktrnsfr13, nhw, nhe, nvn, nvs);
    try soilGasSoluteSourceSink(blk11a, blk11b, blkc, &blktrnsfr1, &blktrnsfr3, nhw, nhe, nvn, nvs);
    try initSnowpackSolute(blk19d, &blktrnsfr1, nhw, nhe, nvn, nvs);
    try soluteFluxWaterNitroUptakeSolute(blk13b, blk13c, blk18a, blk18b, blk21a, blk21b, blk8a, blkc, &blktrnsfr1, &blktrnsfr2, &blktrnsfr3, nhw, nhe, nvn, nvs);
    try soluteFluxSubSurfIrrig(blk13c, blk2b, blk2c, blk22a, blk8a, nhw, nhe, nvn, nvs, i);
    try subHourlySoluteFluxSubSurfIrrig(blk22a, blk8a, blkc, &blktrnsfr8, &blktrnsfr12, nhw, nhe, nvn, nvs);
    try subHourlyGasSoluteDiffusvty(blk8a, blk11a, blk11b, blkc, &blktrnsfr1, &blktrnsfr3, &blktrnsfr12, nhw, nhe, nvn, nvs);
    try stateVarsGasSoluteTrnsfr(blk8a, blk13a, blk13b, blk13c, &blktrnsfr1, &blktrnsfr7, &blktrnsfr12, nhw, nhe, nvn, nvs);
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
