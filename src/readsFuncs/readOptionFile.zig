const std = @import("std");
const offset: u32 = 1;
const Blkc = @import("../globalStructs/blkc.zig").Blkc;
const Blkmain = @import("../localStructs/blkmain.zig").Blkmain;
const Files = @import("../globalStructs/files.zig").Files;
const tokenizeLine = @import("../ecosysUtils/tokenizeLine.zig").tokenizeLine;
const parseTokenToInt = @import("../ecosysUtils/parseTokenToInt.zig").parseTokenToInt;
const parseTokenToFloat = @import("../ecosysUtils/parseTokenToFloat.zig").parseTokenToFloat;
const toLowerCase = @import("../ecosysUtils/toLowerCase.zig").toLowerCase;
/// This function reads weather options
pub fn readOptionFile(allocator: std.mem.Allocator, logFileWriter: *std.Io.Writer, logOption: *std.Io.Writer, optionFileName: []const u8, nPass: usize, nex: usize, nfx: usize, ne: usize, nd: usize, blkc: *Blkc, blkmain: *Blkmain, files: *Files) !void {
    // Log error message if this function fails
    errdefer {
        const err = error.FunctionFailed_readOptionFile;
        logFileWriter.print("error: {s}\n", .{@errorName(err)}) catch {};
        logFileWriter.flush() catch {};
        std.debug.print("error: {s}\n", .{@errorName(err)});
    }
    // Buffer for file I/O: read
    var inBuf: [1024]u8 = undefined;
    const iclmflag: [3][]const u8 = .{ "none", "stepwise", "transient/gradual" };
    // Open site file
    const fs = std.fs.cwd();
    const optionF = fs.openFile(optionFileName, .{}) catch {
        const err = error.OptionFileNotFoundOrFailedToOpenOptionFile;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        try logFileWriter.flush();
        return err;
    };
    defer optionF.close();
    var optionFileBuf = optionF.reader(&inBuf);
    const optionFile = &optionFileBuf.interface;
    // Read option file line by line
    // Read scenario start date in DDMMYYY format
    var line = try optionFile.takeDelimiterExclusive('\n');
    var tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 1) {
        const err = error.InvalidInputForScenarioStartDateInOptionFile;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        try logFileWriter.flush();
        return err;
    }
    files.idata[0] = try parseTokenToInt(u32, error.InvalidScenarioStartDate_DD_InOptionFile, tokens.items[0][0..2], logFileWriter);
    files.idata[1] = try parseTokenToInt(u32, error.InvalidScenarioStartDate_MM_InOptionFile, tokens.items[0][2..4], logFileWriter);
    files.idata[2] = try parseTokenToInt(u32, error.InvalidScenarioStartDate_YYYY_InOptionFile, tokens.items[0][4..8], logFileWriter);
    if (nPass == 0) {
        try logOption.print("=> [Start of {s} file.] {s} line#1 inputs: scenario start date (day/month/year) {d}/{d}/{d}; scenario #{} pass #{}, scene #{} pass #{}\n", .{ optionFileName, optionFileName, files.idata[0], files.idata[1], files.idata[2], nex + offset, nfx + offset, ne + offset, nd + offset });
        try logOption.flush();
    }
    tokens.deinit(allocator);
    // Read scenario end date in DDMMYYY format
    line = try optionFile.takeDelimiterExclusive('\n');
    tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 1) {
        const err = error.InvalidInputForScenarioEndDateInOptionFile;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        try logFileWriter.flush();
        return err;
    }
    files.idata[3] = try parseTokenToInt(u32, error.InvalidScenarioEndDate_DD_InOptionFile, tokens.items[0][0..2], logFileWriter);
    files.idata[4] = try parseTokenToInt(u32, error.InvalidScenarioEndDate_MM_InOptionFile, tokens.items[0][2..4], logFileWriter);
    files.idata[5] = try parseTokenToInt(u32, error.InvalidScenarioEndDate_YYYY_InOptionFile, tokens.items[0][4..8], logFileWriter);
    if (nPass == 0) {
        try logOption.print("=> {s} line#2 inputs: scenario end date (day/month/year) {d}/{d}/{d}\n", .{ optionFileName, files.idata[3], files.idata[4], files.idata[5] });
        try logOption.flush();
    }
    tokens.deinit(allocator);
    // Read model run start date in DDMMYYY format
    line = try optionFile.takeDelimiterExclusive('\n');
    tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 1) {
        const err = error.InvalidInputForModelRunStartDateInOptionFile;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        try logFileWriter.flush();
        return err;
    }
    files.idata[6] = try parseTokenToInt(u32, error.InvalidModelRunStartDate_DD_InOptionFile, tokens.items[0][0..2], logFileWriter);
    files.idata[7] = try parseTokenToInt(u32, error.InvalidModelRunStartDate_MM_InOptionFile, tokens.items[0][2..4], logFileWriter);
    files.idata[8] = try parseTokenToInt(u32, error.InvalidModelRunStartDate_YYYY_InOptionFile, tokens.items[0][4..8], logFileWriter);
    if (nPass == 0) {
        try logOption.print("=> {s} line#3 inputs: model run start date (day/month/year) {d}/{d}/{d}\n", .{ optionFileName, files.idata[6], files.idata[7], files.idata[8] });
        try logOption.flush();
    }
    tokens.deinit(allocator);
    // Read flag for generating checkpoint files, resuming from earlier checkpoint files
    line = try optionFile.takeDelimiterExclusive('\n');
    tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 1) {
        const err = error.InvalidInputForCheckPointFileFlagInOptionFile;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        try logFileWriter.flush();
        return err;
    }
    const lowerFlag = try toLowerCase(allocator, tokens.items[0]);
    defer allocator.free(lowerFlag);
    blkmain.data[20] = lowerFlag;
    if (!(std.mem.eql(u8, blkmain.data[20], "yes") or
        std.mem.eql(u8, blkmain.data[20], "no")))
    {
        const err = error.InvalidInputForCheckPointFileFlagInOptionFile;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        try logFileWriter.flush();
        return err;
    }
    if (nPass == 0) {
        try logOption.print("=> {s} line#4 inputs: start from an earlier run?: {s}\n", .{ optionFileName, blkmain.data[20] });
        try logOption.flush();
    }
    tokens.deinit(allocator);
    // Read climate forcing files for each month of a calendar year
    for (0..12) |n| {
        line = try optionFile.takeDelimiterExclusive('\n');
        tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 10) {
            const err = error.InvalidInputForClimateForcingInOptionFile;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            try logFileWriter.flush();
            return err;
        }
        // Radiation forcing
        blkc.drad[n] = try parseTokenToFloat(f32, error.InvalidDataFormatForRadiationForcingInOptionFile, tokens.items[0], logFileWriter);
        // Maximum temperature forcing
        blkc.dtmpx[n] = try parseTokenToFloat(f32, error.InvalidDataFormatForMaxTempForcingInOptionFile, tokens.items[1], logFileWriter);
        // Minimum temperature forcing
        blkc.dtmpn[n] = try parseTokenToFloat(f32, error.InvalidDataFormatForMinTempForcingInOptionFile, tokens.items[2], logFileWriter);
        // Humidity forcing
        blkc.dhum[n] = try parseTokenToFloat(f32, error.InvalidDataFormatForHumidityForcingInOptionFile, tokens.items[3], logFileWriter);
        // Precipitation forcing
        blkc.dprec[n] = try parseTokenToFloat(f32, error.InvalidDataFormatForPrecipForcingInOptionFile, tokens.items[4], logFileWriter);
        // Irrigation forcing
        blkc.dirri[n] = try parseTokenToFloat(f32, error.InvalidDataFormatForIrrigationForcingInOptionFile, tokens.items[5], logFileWriter);
        // Wind speed forcing
        blkc.dwind[n] = try parseTokenToFloat(f32, error.InvalidDataFormatForWindSpeedForcingInOptionFile, tokens.items[6], logFileWriter);
        // CO2 concentration forcing
        blkc.dco2e[n] = try parseTokenToFloat(f32, error.InvalidDataFormatForCO2ConcForcingInOptionFile, tokens.items[7], logFileWriter);
        // NH4 concentration forcing
        blkc.dcn4r[n] = try parseTokenToFloat(f32, error.InvalidDataFormatForNH4ConcForcingInOptionFile, tokens.items[8], logFileWriter);
        // NO3 concentration forcing
        blkc.dcnor[n] = try parseTokenToFloat(f32, error.InvalidDataFormatForNO3ConcForcingInOptionFile, tokens.items[9], logFileWriter);
        if (nPass == 0) {
            try logOption.print("=> {s} line#{} inputs: climate forcing parameters for month #{}; Δ radiation: {d}, Δ max. temperature: {d},  Δ min. temperature: {d},  Δ humidity: {d},  Δ precipitation: {d},  Δ irrigation: {d},  Δ wind speed: {d},  Δ CO2 concentration: {d},  Δ NH4 concentration: {d},  Δ NO3 concentration: {d} \n", .{ optionFileName, n + 5, n + 1, blkc.drad[n], blkc.dtmpx[n], blkc.dtmpn[n], blkc.dhum[n], blkc.dprec[n], blkc.dirri[n], blkc.dwind[n], blkc.dco2e[n], blkc.dcn4r[n], blkc.dcnor[n] });
            try logOption.flush();
        }
        tokens.deinit(allocator);
    }
    // Read flag for generating checkpoint files, resuming from earlier checkpoint files
    line = try optionFile.takeDelimiterExclusive('\n');
    tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 6) {
        const err = error.InvalidInputForModelOutputFrequencyInOptionFile;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        try logFileWriter.flush();
        return err;
    }
    // Maximum number of cycles per hour for water, heat, and solute flux calculations.
    blkc.npx = try parseTokenToInt(u32, error.InvalidDataFormatForNumberOfSubHourlyWaterCycles, tokens.items[0], logFileWriter);
    // Maximum number of cycles per npx for gas flux calculations
    blkc.npy = try parseTokenToInt(u32, error.InvalidDataFormatForNumberOfSubHourlyWaterCycles, tokens.items[1], logFileWriter);
    // Output frequency for hourly data
    blkc.jout = try parseTokenToInt(u32, error.InvalidDataFormatForNumberOfSubHourlyWaterCycles, tokens.items[2], logFileWriter);
    // Output frequency for daily data
    blkc.iout = try parseTokenToInt(u32, error.InvalidDataFormatForNumberOfSubHourlyWaterCycles, tokens.items[3], logFileWriter);
    // Output frequency for checkpoint data
    blkc.kout = try parseTokenToInt(u32, error.InvalidDataFormatForNumberOfSubHourlyWaterCycles, tokens.items[4], logFileWriter);
    // Climate forcing type (0=none, 1=step, 2=transient)
    blkc.iclm = try parseTokenToInt(u32, error.InvalidDataFormatForNumberOfSubHourlyWaterCycles, tokens.items[5], logFileWriter);
    if (nPass == 0) {
        try logOption.print("=> {s} line#17 inputs: max. sub-hourly water flux cycles #{d}, max. gas flux cycles within sub-hourly water flux cycle #{d}, output frequencies for: hourly outputs {d}, daily outputs {d}, and checkpoint data {d}, climate forcing type: {s}. [End of {s} file.]\n", .{ optionFileName, blkc.npx, blkc.npy, blkc.jout, blkc.iout, blkc.kout, iclmflag[blkc.iclm], optionFileName });
        try logOption.flush();
    }
    tokens.deinit(allocator);
}
