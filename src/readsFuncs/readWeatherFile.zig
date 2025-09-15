const std = @import("std");
const offset: u32 = 1;
const timeFrequency = @import("timeFrequency.zig").timeFrequency;
const dateVars = @import("dateVars.zig").dateVars;
const calendarType = @import("calendarType.zig").calendarType;
const weatherVars = @import("weatherVars.zig").weatherVars;
const tempUnits = @import("tempUnits.zig").tempUnits;
const radiationUnits = @import("radiationUnits.zig").radiationUnits;
const windspeedUnits = @import("windspeedUnits.zig").windspeedUnits;
const precipitationUnits = @import("precipitationUnits.zig").precipitationUnits;
const humidityUnits = @import("humidityUnits.zig").humidityUnits;
const wthrUnits = @import("wthrUnits.zig").wthrUnits;
const Blk2a = @import("../globalStructs/blk2a.zig").Blk2a;
const Blk2b = @import("../globalStructs/blk2b.zig").Blk2b;
const Blkc = @import("../globalStructs/blkc.zig").Blkc;
const Blkmain = @import("../localStructs/blkmain.zig").Blkmain;
const Blkwthr = @import("../localStructs/blkwthr.zig").Blkwthr;
const tokenizeLine = @import("../ecosysUtils/tokenizeLine.zig").tokenizeLine;
const parseTokenToInt = @import("../ecosysUtils/parseTokenToInt.zig").parseTokenToInt;
const parseTokenToFloat = @import("../ecosysUtils/parseTokenToFloat.zig").parseTokenToFloat;
const toLowerCase = @import("../ecosysUtils/toLowerCase.zig").toLowerCase;
/// This function reads weather data
pub fn readWeatherFile(allocator: std.mem.Allocator, logFileWriter: *std.Io.Writer, logWeather: *std.Io.Writer, logRun: *std.Io.Writer, ecosysRun: *std.Io.Reader, blk2a: *Blk2a, blk2b: *Blk2b, blkc: *Blkc, nhw: u32, nvn: u32, nhe: u32, nvs: u32, nPass: usize, nex: usize, ne: usize) !void {
    // Log error message if this function fails
    errdefer {
        const err = error.FunctionFailed_readWeatherFile;
        logFileWriter.print("error: {s}\n", .{@errorName(err)}) catch {};
        logFileWriter.flush() catch {};
        std.debug.print("error: {s}\n", .{@errorName(err)});
    }
    // Wind speed measurement flag.
    const windSpeedFlag: [2][]const u8 = .{ "soil", "canopy" };
    // Buffer for file I/O: read
    var inBuf: [1024]u8 = undefined;
    var blkwthr: Blkwthr = Blkwthr.init();
    var line = try ecosysRun.takeDelimiterExclusive('\n');
    var tokens = try tokenizeLine(line, allocator);
    if (tokens.items.len != 1) {
        const err = error.InvalidWeatherFileInRunScript;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        try logFileWriter.flush();
        return err;
    }
    const weatherFileName = try allocator.dupe(u8, tokens.items[0]);
    defer allocator.free(weatherFileName);
    if (nPass == 0) {
        try logRun.print("=> Weather file (scenario #{} scene #{}): {s}.\n", .{ nex + offset, ne + offset, weatherFileName });
        try logRun.flush();
    }
    tokens.deinit(allocator);
    // Open weather file
    const fs = std.fs.cwd();
    const weatherF = fs.openFile(weatherFileName, .{}) catch {
        const err = error.WeatherFileNotFoundOrFailedToOpenWeatherFile;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        try logFileWriter.flush();
        return err;
    };
    defer weatherF.close();
    var weatherFileBuf = weatherF.reader(&inBuf);
    const weatherFile = &weatherFileBuf.interface;
    var gridCount: u32 = 0;
    while (true) {
        line = weatherFile.takeDelimiterExclusive('\n') catch |err| switch (err) {
            error.EndOfStream => break,
            else => return err,
        }; // break out of the loop at the EOF.
        tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 4) {
            const err = error.InvalidInputForGridCellPositionsInWeatherFile;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            try logFileWriter.flush();
            return err;
        }
        // Read grid cell positions in W, N, E, and S direction
        const nh1 = try parseTokenToInt(u32, error.InvalidGridCellPositionInWeatherFile_W, tokens.items[0], logFileWriter) - offset;
        const nv1 = try parseTokenToInt(u32, error.InvalidGridCellPositionInWeatherFile_N, tokens.items[1], logFileWriter) - offset;
        const nh2 = try parseTokenToInt(u32, error.InvalidGridCellPositionInWeatherFile_E, tokens.items[2], logFileWriter);
        const nv2 = try parseTokenToInt(u32, error.InvalidGridCellPositionInWeatherFile_S, tokens.items[3], logFileWriter);
        if (nPass == 0) {
            try logWeather.print("=> Grid cell positions: W: {}, N: {}, E: {}, S: {}.\n", .{ nh1 + offset, nv1 + offset, nh2, nv2 });
            try logWeather.flush();
        }
        if (nh1 > nh2 or nv1 > nv2 or nh1 < nhw or nh2 > nhe or nv1 < nvn or nv2 > nvs) {
            const err = error.InvalidInputForGridCellPositionsInWeatherFile;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            try logFileWriter.flush();
            return err;
        }
        // Free up memory allocated in tokenized line
        tokens.deinit(allocator);
        // Read each weather file for each landscape unit within the weather file
        line = try weatherFile.takeDelimiterExclusive('\n');
        tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 1) {
            const err = error.InvalidInputForWeatherUnitFileNameInWeatherFile;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            try logFileWriter.flush();
            return err;
        }
        const weatherUnitFileName = try allocator.dupe(u8, tokens.items[0]);
        defer allocator.free(weatherUnitFileName);
        const weatherUnitFile = fs.openFile(weatherUnitFileName, .{}) catch |err| {
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            try logFileWriter.flush();
            return error.WeatherUnitFileNotFoundInWeatherFileOrFailedToOpenWeatherUnitFile;
        };
        defer weatherUnitFile.close();
        var wthrUnitFileBuf = weatherUnitFile.reader(&inBuf);
        const wthrUnitFile = &wthrUnitFileBuf.interface;
        tokens.deinit(allocator);
        // Read weather file headers
        line = try wthrUnitFile.takeDelimiterExclusive('\n');
        const wthrHeadersLower = try toLowerCase(allocator, line);
        defer allocator.free(wthrHeadersLower);
        tokens = try tokenizeLine(wthrHeadersLower, allocator);
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                // Read time step: H, h = hourly, D, d = Daily, 3 = 3-hourly.
                blkwthr.ttype[nx][ny] = tokens.items[0][0];
                // Read calendar format: J, j = Julian day, Orlese calendar date.
                blkwthr.ctype[nx][ny] = tokens.items[0][1];
                // Read number of date variables.
                blkwthr.ni[nx][ny] = try parseTokenToInt(u32, error.InvalidNumberOfDateVariables, tokens.items[0][2..4], logFileWriter);
                // Read number of weather variables.
                blkwthr.nn[nx][ny] = try parseTokenToInt(u32, error.InvalidNumberOfWeatherVariables, tokens.items[0][4..6], logFileWriter);
                // Read date variable names (in short forms, e.g., D, d = day, M, m = month, H, d = hour etc.).
                for (6..6 + blkwthr.ni[nx][ny]) |k| {
                    blkwthr.ivars[nx][ny][k - 6] = tokens.items[0][k];
                }
                // Read weather variable names (in short forms, e.g., M, m = max. temperature, N, n = min. temperature, H, h = humidity etc.).
                for (6 + blkwthr.ni[nx][ny]..6 + blkwthr.ni[nx][ny] + blkwthr.nn[nx][ny]) |k| {
                    blkwthr.vars[nx][ny][k - blkwthr.ni[nx][ny] - 6] = tokens.items[0][k];
                }
            }
        }
        tokens.deinit(allocator);
        // Read units of weather variables.
        line = try wthrUnitFile.takeDelimiterExclusive('\n');
        const wthrUnitLower = try toLowerCase(allocator, line);
        defer allocator.free(wthrUnitLower);
        tokens = try tokenizeLine(wthrUnitLower, allocator);
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                if (nPass == 0) {
                    try logWeather.print("=> [Start of {s} file.] {s} line#1&2 inputs: time step: {s}, date format: {s}, number of date variables to read: {d}, number of weather variables to read: {d}. Variables used in the model: ", .{ weatherUnitFileName, weatherUnitFileName, try timeFrequency(blkwthr.ttype[nx][ny]), try calendarType(blkwthr.ctype[nx][ny]), blkwthr.ni[nx][ny], blkwthr.nn[nx][ny] });
                    try logWeather.flush();
                }
                for (0..blkwthr.ni[nx][ny]) |k| {
                    const wthrVarName = try dateVars(blkwthr.vars[nx][ny][k]);
                    if (nPass == 0) {
                        if (!(std.mem.eql(u8, wthrVarName, "n/a"))) {
                            try logWeather.print("{s}, ", .{wthrVarName});
                            try logWeather.flush();
                        }
                    }
                }
                // Read weather variable units (in short forms).
                for (0..blkwthr.nn[nx][ny]) |k| {
                    blkwthr.typ[nx][ny][k] = tokens.items[0][k];
                    const wthrVarName = try weatherVars(blkwthr.vars[nx][ny][k]);
                    if (nPass == 0) {
                        const weatherUnit = try wthrUnits(blkwthr.vars[nx][ny][k], blkwthr.typ[nx][ny][k], blkwthr.ttype[nx][ny]);
                        if (!(std.mem.eql(u8, weatherUnit, "n/a"))) {
                            try logWeather.print("{s} ({s}), ", .{ wthrVarName, weatherUnit });
                            try logWeather.flush();
                        }
                    }
                }
                if (nPass == 0) {
                    try logWeather.print("\n", .{});
                    try logWeather.flush();
                }
            }
        }
        tokens.deinit(allocator);
        // Read wind speed measurement height and solar noon.
        line = try wthrUnitFile.takeDelimiterExclusive('\n');
        tokens = try tokenizeLine(line, allocator);
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                // Read windspeed measurement height.
                blk2a.z0[nx][ny] = try parseTokenToFloat(f32, error.WindSpeedMeasurementHeightNotValidInWeatherFile, tokens.items[0], logFileWriter);
                // Read flag for raising windspeed measurement height over vegetation.
                blkc.iflgw[nx][ny] = try parseTokenToInt(u32, error.WindSpeedMeasurementFlagNotValidInWeatherFile, tokens.items[1], logFileWriter);
                // Read solar noon.
                blk2a.znoon[nx][ny] = try parseTokenToFloat(f32, error.SolarNoonNotValidInWeatherFile, tokens.items[2], logFileWriter);
                if (nPass == 0) {
                    try logWeather.print("=> {s} line#3 inputs: wind speed measured at {d} m above {s} surface, solar noon: {d}.\n", .{ weatherUnitFileName, blk2a.z0[nx][ny], windSpeedFlag[blkc.iflgw[nx][ny]], blk2a.znoon[nx][ny] });
                    try logWeather.flush();
                }
            }
        }
        tokens.deinit(allocator);
        // Read chemical concentrations in precipitation water.
        line = try wthrUnitFile.takeDelimiterExclusive('\n');
        tokens = try tokenizeLine(line, allocator);
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                // Read pH of precipitation water.
                blk2b.phr[nx][ny] = try parseTokenToFloat(f32, error.PrecipitationWaterpHNotValidInWeatherFile, tokens.items[0], logFileWriter);
                // Read NH₄ concentration of precipitation water.
                blk2b.cn4r[nx][ny] = try parseTokenToFloat(f32, error.PrecipitationWaterNH4ConcNotValidInWeatherFile, tokens.items[1], logFileWriter);
                // Read NO₃ concentration of precipitation water.
                blk2b.cnor[nx][ny] = try parseTokenToFloat(f32, error.PrecipitationWaterNO3ConcNotValidInWeatherFile, tokens.items[2], logFileWriter);
                // Read H₂PO₄ concentration of precipitation water.
                blk2b.cpor[nx][ny] = try parseTokenToFloat(f32, error.PrecipitationWaterH2PO4ConcNotValidInWeatherFile, tokens.items[3], logFileWriter);
                // Read Al concentration of precipitation water.
                blk2b.calr[nx][ny] = try parseTokenToFloat(f32, error.PrecipitationWaterAlConcNotValidInWeatherFile, tokens.items[4], logFileWriter);
                // Read Fe concentration of precipitation water.
                blk2b.cfer[nx][ny] = try parseTokenToFloat(f32, error.PrecipitationWaterFeConcNotValidInWeatherFile, tokens.items[5], logFileWriter);
                // Read Ca concentration of precipitation water.
                blk2b.ccar[nx][ny] = try parseTokenToFloat(f32, error.PrecipitationWaterCaConcNotValidInWeatherFile, tokens.items[6], logFileWriter);
                // Read Mg concentration of precipitation water.
                blk2b.cmgr[nx][ny] = try parseTokenToFloat(f32, error.PrecipitationWaterMgConcNotValidInWeatherFile, tokens.items[7], logFileWriter);
                // Read Na concentration of precipitation water.
                blk2b.cnar[nx][ny] = try parseTokenToFloat(f32, error.PrecipitationWaterNaConcNotValidInWeatherFile, tokens.items[8], logFileWriter);
                // Read K concentration of precipitation water.
                blk2b.ckar[nx][ny] = try parseTokenToFloat(f32, error.PrecipitationWaterKConcNotValidInWeatherFile, tokens.items[9], logFileWriter);
                // Read SO₄ concentration of precipitation water.
                blk2b.csor[nx][ny] = try parseTokenToFloat(f32, error.PrecipitationWaterSO4ConcNotValidInWeatherFile, tokens.items[10], logFileWriter);
                // Read Cl concentration of precipitation water.
                blk2b.cclr[nx][ny] = try parseTokenToFloat(f32, error.PrecipitationWaterClConcNotValidInWeatherFile, tokens.items[11], logFileWriter);
                if (nPass == 0) {
                    try logWeather.print("=> {s} line#4 inputs: chemical concentrations in precipitation water: pH => {d} ppm, NH₄ => {d} ppm, NO₃ => {d} ppm, H₂PO₄ => {d} ppm, Al => {d} ppm, Fe => {d} ppm, Ca => {d} ppm, Mg => {d} ppm, Na => {d} ppm, K => {d} ppm, SO₄ => {d} ppm, Cl => {d} ppm.\n", .{ weatherUnitFileName, blk2b.phr[nx][ny], blk2b.cn4r[nx][ny], blk2b.cnor[nx][ny], blk2b.cpor[nx][ny], blk2b.calr[nx][ny], blk2b.cfer[nx][ny], blk2b.ccar[nx][ny], blk2b.cmgr[nx][ny], blk2b.cnar[nx][ny], blk2b.ckar[nx][ny], blk2b.csor[nx][ny], blk2b.cclr[nx][ny] });
                    try logWeather.flush();
                }
            }
        }
        tokens.deinit(allocator);
        var hasDoy366: bool = false;
        var day: usize = 0;
        var hour: usize = 0;
        while (true) {
            line = wthrUnitFile.takeDelimiterExclusive('\n') catch |err| switch (err) {
                error.EndOfStream => break,
                else => return err,
            }; // break out of the loop at the EOF.
            tokens = try tokenizeLine(line, allocator);
            const prevHour: usize = hour;
            var nSubHour: usize = 1;
            for (nh1..nh2) |nx| {
                for (nv1..nv2) |ny| {
                    if (blkwthr.ttype[nx][ny] == 'h') {
                        if (blkwthr.ctype[nx][ny] == 'j') {
                            for (0..blkwthr.ni[nx][ny]) |k| {
                                if (blkwthr.ivars[nx][ny][k] == 'd') {
                                    day = try parseTokenToInt(usize, error.InvalidDayInWeatherFile, tokens.items[k], logFileWriter);
                                    day = day - 1; // for 0 indexing.
                                }
                                if (blkwthr.ivars[nx][ny][k] == 'h') {
                                    hour = try parseTokenToInt(usize, error.InvalidHourInWeatherFile, tokens.items[k], logFileWriter);
                                    if (hour > 24) hour = (hour + 100 / 2) / 100;
                                    hour = ((hour % 24) + 24) % 24; // normalize hours from 0 to 23;
                                    if (hour == prevHour) nSubHour += 1;
                                }
                            }
                            for (blkwthr.ni[nx][ny]..blkwthr.ni[nx][ny] + blkwthr.nn[nx][ny]) |k0| {
                                const k = k0 - @as(usize, blkwthr.ni[nx][ny]);
                                if (blkwthr.vars[nx][ny][k] == 't') {
                                    blk2a.tmph[nx][ny][day][hour] = try parseTokenToFloat(f32, error.InvalidHourlyTemperatureInWeatherFile, tokens.items[k0], logFileWriter);
                                    if (hour == prevHour) {
                                        blk2a.tmph[nx][ny][day][hour] += blk2a.tmph[nx][ny][day][hour];
                                        blk2a.tmph[nx][ny][day][hour] = blk2a.tmph[nx][ny][day][hour] / @as(f32, @floatFromInt(nSubHour));
                                    }
                                }
                                if (blkwthr.vars[nx][ny][k] == 'r') {
                                    blk2a.sradh[nx][ny][day][hour] = try parseTokenToFloat(f32, error.InvalidHourlyShortwaveRadiationInWeatherFile, tokens.items[k0], logFileWriter);
                                    if (hour == prevHour) {
                                        blk2a.sradh[nx][ny][day][hour] += blk2a.sradh[nx][ny][day][hour];
                                        blk2a.sradh[nx][ny][day][hour] = blk2a.sradh[nx][ny][day][hour] / @as(f32, @floatFromInt(nSubHour));
                                    }
                                }
                                if (blkwthr.vars[nx][ny][k] == 'p') {
                                    blk2a.rainh[nx][ny][day][hour] = try parseTokenToFloat(f32, error.InvalidHourlyPrecipitationInWeatherFile, tokens.items[k0], logFileWriter);
                                    if (hour == prevHour) {
                                        blk2a.rainh[nx][ny][day][hour] += blk2a.rainh[nx][ny][day][hour];
                                        blk2a.rainh[nx][ny][day][hour] = blk2a.rainh[nx][ny][day][hour] / @as(f32, @floatFromInt(nSubHour));
                                    }
                                }
                                if (blkwthr.vars[nx][ny][k] == 'h') {
                                    blk2a.dwpht[nx][ny][day][hour] = try parseTokenToFloat(f32, error.InvalidHumidityInWeatherFile, tokens.items[k0], logFileWriter);
                                    if (hour == prevHour) {
                                        blk2a.dwpht[nx][ny][day][hour] += blk2a.dwpht[nx][ny][day][hour];
                                        blk2a.dwpht[nx][ny][day][hour] = blk2a.dwpht[nx][ny][day][hour] / @as(f32, @floatFromInt(nSubHour));
                                    }
                                }
                                if (blkwthr.vars[nx][ny][k] == 'w') {
                                    blk2a.windh[nx][ny][day][hour] = try parseTokenToFloat(f32, error.InvalidWindSpeedInWeatherFile, tokens.items[k0], logFileWriter);
                                    if (hour == prevHour) {
                                        blk2a.windh[nx][ny][day][hour] += blk2a.windh[nx][ny][day][hour];
                                        blk2a.windh[nx][ny][day][hour] = blk2a.windh[nx][ny][day][hour] / @as(f32, @floatFromInt(nSubHour));
                                    }
                                }
                            }
                            // Fill in for leap years.
                            if (day == 365) {
                                hasDoy366 = true;
                            }
                        }
                    }
                }
            }
            tokens.deinit(allocator);
            // Fill the weather data for the extra day in a leap year
            if (blkc.iyrc % 4 == 0 and hasDoy366 == false) {
                for (nh1..nh2) |nx| {
                    for (nv1..nv2) |ny| {
                        for (0..23) |hourLeapyear| {
                            blk2a.tmph[nx][ny][365][hourLeapyear] = blk2a.tmph[nx][ny][364][hourLeapyear];
                            blk2a.sradh[nx][ny][365][hourLeapyear] = blk2a.sradh[nx][ny][364][hourLeapyear];
                            blk2a.rainh[nx][ny][365][hourLeapyear] = blk2a.rainh[nx][ny][364][hourLeapyear];
                            blk2a.dwpht[nx][ny][365][hourLeapyear] = blk2a.dwpht[nx][ny][364][hourLeapyear];
                            blk2a.windh[nx][ny][365][hourLeapyear] = blk2a.windh[nx][ny][364][hourLeapyear];
                        }
                    }
                }
            }
        }
        const daysPrint: [3]u32 = .{ 0, 364, 365 };
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                for (daysPrint) |dayPrint| {
                    for (0..23) |hourPrint| {
                        if (nPass == 0 and ((blkc.iyrc % 4 == 0 and (dayPrint == 0 or dayPrint == 365)) or (blkc.iyrc % 4 != 0 and (dayPrint == 0 or dayPrint == 364)))) {
                            try logWeather.print("{s}, year: {d}, doy: {d}, hour: {d}, temperature: {d}, shortwave radiation: {d}, precipitation: {d}, humidity: {d}, and wind speed: {d}.\n", .{ weatherFileName, blkc.iyrc, dayPrint + 1, hourPrint + 1, blk2a.tmph[nx][ny][dayPrint][hourPrint], blk2a.sradh[nx][ny][dayPrint][hourPrint], blk2a.rainh[nx][ny][dayPrint][hourPrint], blk2a.dwpht[nx][ny][dayPrint][hourPrint], blk2a.windh[nx][ny][dayPrint][hourPrint] });
                            try logWeather.flush();
                        }
                    }
                }
            }
        }
        for (nh1..nh2) |_| {
            for (nv1..nv2) |_| {
                gridCount += 1;
            }
        }
    }
    if (gridCount != (nhe - nhw) * (nvs - nvn)) {
        const err = error.InvalidInputForGridCellPositionsInWeatherFile;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        try logFileWriter.flush();
        return err;
    }
}
