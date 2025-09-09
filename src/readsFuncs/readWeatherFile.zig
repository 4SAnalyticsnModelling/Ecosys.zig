const std = @import("std");
const offset: u32 = 1;
const Blk2a = @import("../globalStructs/blk2a.zig").Blk2a;
const Blkc = @import("../globalStructs/blkc.zig").Blkc;
const Blkmain = @import("../localStructs/blkmain.zig").Blkmain;
const Blkwthr = @import("../localStructs/blkwthr.zig").Blkwthr;
const tokenizeLine = @import("../ecosysUtils/tokenizeLine.zig").tokenizeLine;
const parseTokenToInt = @import("../ecosysUtils/parseTokenToInt.zig").parseTokenToInt;
const parseTokenToFloat = @import("../ecosysUtils/parseTokenToFloat.zig").parseTokenToFloat;
/// This function reads weather data
pub fn readWeatherFile(allocator: std.mem.Allocator, logFileWriter: *std.Io.Writer, logWeather: *std.Io.Writer, logRun: *std.Io.Writer, ecosysRun: *std.Io.Reader, nhw: u32, nvn: u32, nhe: u32, nvs: u32, nPass: usize, nex: usize, ne: usize) !void {
    // Log error message if this function fails
    errdefer {
        const err = error.FunctionFailed_readWeatherFile;
        logFileWriter.print("error: {s}\n", .{@errorName(err)}) catch {};
        logFileWriter.flush() catch {};
        std.debug.print("error: {s}\n", .{@errorName(err)});
    }
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
        line = try wthrUnitFile.takeDelimiterExclusive('\n');
        tokens = try tokenizeLine(line, allocator);
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                // Read weather file headers
                // Read time step: H = hourly, D = Daily, 3 = 3-hourly.
                blkwthr.ttype[nx][ny] = tokens.items[0][0];
                // Read calendar format: J = Julian day, Orlese calendar date.
                blkwthr.ctype[nx][ny] = tokens.items[0][1];
                // Read number of date variables.
                blkwthr.ni[nx][ny] = try parseTokenToInt(u32, error.InvalidNumberOfDateVariables, tokens.items[0][2..4], logFileWriter);
                // Read number of weather variables.
                blkwthr.nn[nx][ny] = try parseTokenToInt(u32, error.InvalidNumberOfWeatherVariables, tokens.items[0][4..6], logFileWriter);
                if (nPass == 0) {
                    try logWeather.print("=> [Start of {s} file.] {s} line#1 inputs: grid cell position W-E: {}, N-S: {}, time step: {s}, date format: {s}, number of date variables to read: {d}, number of weather variables to read: {d}.\n", .{ weatherUnitFileName, weatherUnitFileName, nx + offset, ny + offset, try timeFrequency(blkwthr.ttype[nx][ny]), try calendarType(blkwthr.ctype[nx][ny]), blkwthr.ni[nx][ny], blkwthr.nn[nx][ny] });
                    try logWeather.flush();
                }
            }
        }
        //         // Read altitude
        //         blk2a.alti[nx][ny] = try parseTokenToFloat(f32, error.InvalidElevation, tokens.items[1], logFileWriter);
        //         // Read mean annual temperature (MAT) (deg C) to be used as lower boundary initial temperature
        //         blk2a.atcai[nx][ny] = try parseTokenToFloat(f32, error.InvalidMeanAnnualTemperature, tokens.items[2], logFileWriter);
        //         // Read water table flag; 0 = none; 1,2 = natural stationary, mobile; 3,4 = artificial stationary, mobile
        //         blk2a.idtbl[nx][ny] = try parseTokenToInt(u32, error.InvalidWaterTableFlag, tokens.items[3], logFileWriter);
        //         if (blk2a.idtbl[nx][ny] > 4) {
        //             const err = error.InvalidWaterTableFlag;
        //             try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        //             try logFileWriter.flush();
        //             return err;
        //         }
        //         try logSite.print("=> [Start of {s} file.] {s} line#1 inputs: grid cell position W-E: {}, N-S: {}, latitude: {d} degree, elevation: {d} m, MAT: {d} degree C, water table simulation: {s}.\n", .{ landscapeUnitFileName, landscapeUnitFileName, nx + offset, ny + offset, blkc.alat[nx][ny], blk2a.alti[nx][ny], blk2a.atcai[nx][ny], wtflag[blk2a.idtbl[nx][ny]] });
        //         try logSite.flush();
        //     }
        // }
        // tokens.deinit(allocator);
        // line = try landscapeUnitFile.takeDelimiterExclusive('\n');
        // tokens = try tokenizeLine(line, allocator);
        // if (tokens.items.len != 6) {
        //     const err = error.InvalidInputLandscapeUnitFileLine2;
        //     try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        //     try logFileWriter.flush();
        //     return err;
        // }
        // for (nh1..nh2) |nx| {
        //     for (nv1..nv2) |ny| {
        //         // Read atmospheric O2 concentration (ppm)
        //         blk2a.oxye[nx][ny] = try parseTokenToFloat(f32, error.InvalidAtmO2Concentration, tokens.items[0], logFileWriter);
        //         // Read atmospheric N2 concentration (ppm)
        //         blk2a.z2ge[nx][ny] = try parseTokenToFloat(f32, error.InvalidAtmN2Concentration, tokens.items[1], logFileWriter);
        //         // Read atmospheric CO2 concentration (ppm)
        //         blk2a.co2ei[nx][ny] = try parseTokenToFloat(f32, error.InvalidAtmCO2Concentration, tokens.items[2], logFileWriter);
        //         // Read atmospheric CH4 concentration (ppm)
        //         blk2a.ch4e[nx][ny] = try parseTokenToFloat(f32, error.InvalidAtmCH4Concentration, tokens.items[3], logFileWriter);
        //         // Read atmospheric N2O concentration (ppm)
        //         blk2a.z2oe[nx][ny] = try parseTokenToFloat(f32, error.InvalidAtmN2OConcentration, tokens.items[4], logFileWriter);
        //         // Read atmospheric NH3 concentration (ppm)
        //         blk2a.znh3e[nx][ny] = try parseTokenToFloat(f32, error.InvalidAtmNH3Concentration, tokens.items[5], logFileWriter);
        //         try logSite.print("=> {s} line#2 inputs for atmospheric gas concentrations: grid cell position W-E: {}, N-S: {}, O2: {} ppm, N2: {} ppm, CO2: {d} ppm, CH4: {d} ppm, N2O: {d} ppm, NH3: {d} ppm.\n", .{ landscapeUnitFileName, nx + offset, ny + offset, blk2a.oxye[nx][ny], blk2a.z2ge[nx][ny], blk2a.co2ei[nx][ny], blk2a.ch4e[nx][ny], blk2a.z2oe[nx][ny], blk2a.znh3e[nx][ny] });
        //         try logSite.flush();
        //     }
        // }
        // tokens.deinit(allocator);
        // line = try landscapeUnitFile.takeDelimiterExclusive('\n');
        // tokens = try tokenizeLine(line, allocator);
        // if (tokens.items.len != 7) {
        //     const err = error.InvalidInputLandscapeUnitFileLine3;
        //     try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        //     try logFileWriter.flush();
        //     return err;
        // }
        // for (nh1..nh2) |nx| {
        //     for (nv1..nv2) |ny| {
        //         // Read Koppen climate zone
        //         blkc.ietyp[nx][ny] = try parseTokenToInt(u32, error.InvalidKoppenClimateZone, tokens.items[0], logFileWriter);
        //         // Read salt options; 0 = no salinity simulation; 1 = salinity simulation
        //         blkc.isalt[nx][ny] = try parseTokenToInt(u32, error.InvalidSaltOption, tokens.items[1], logFileWriter);
        //         if (blkc.isalt[nx][ny] > 1) {
        //             const err = error.InvalidSaltOption;
        //             try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        //             try logFileWriter.flush();
        //             return err;
        //         }
        //         // Read erosion options; 0 = allow freeze-thaw to change elevation; 1 = allow freeze-thaw plus erosion to change elevation; 2 = allow freeze-thaw plus soc accumulation to change elevation; 3 = allow freeze-thaw plus soc accumulation plus erosion to change elevation, -1 = no change in elevation
        //         blkc.iersn[nx][ny] = try parseTokenToInt(i32, error.InvalidErosionOption, tokens.items[2], logFileWriter);
        //         if (blkc.iersn[nx][ny] > 3 or blkc.iersn[nx][ny] < -1) {
        //             const err = error.InvalidErosionOption;
        //             try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        //             try logFileWriter.flush();
        //             return err;
        //         }
        //         // Read lateral mass and energy transport options; 1 = lateral connections between grid cells (and hence lateral flux simulations); 3 = no lateral connection/flux simulation
        //         blkc.ncn[nx][ny] = try parseTokenToInt(u32, error.InvalidLateralFluxOption, tokens.items[3], logFileWriter);
        //         if (blkc.ncn[nx][ny] != 1) {
        //             if (blkc.ncn[nx][ny] != 3) {
        //                 const err = error.InvalidLateralFluxOption;
        //                 try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        //                 try logFileWriter.flush();
        //                 return err;
        //             }
        //         }
        //         // Read the depth of natural external water table (m)
        //         blk2a.dtbli[nx][ny] = try parseTokenToFloat(f32, error.InvalidExtWTD, tokens.items[4], logFileWriter);
        //         // Read the depth of artificial water table to simulate artificial drainage (m)
        //         blk2a.dtbldi[nx][ny] = try parseTokenToFloat(f32, error.InvalidArtificialWTD, tokens.items[5], logFileWriter);
        //         // Slope of natural water table relative to landscape surface
        //         blk2a.dtblg[nx][ny] = try parseTokenToFloat(f32, error.InvalidWTDSlope, tokens.items[6], logFileWriter);
        //         const iersngforopt: u32 = @max(0, @min(4, blkc.iersn[nx][ny] + 1));
        //         const ncngforopt: u32 = blkc.ncn[nx][ny] - 1;
        //         try logSite.print("=> {s} line#3 inputs: grid cell position W-E: {}, N-S: {}, Koppen climate zone: {}, salinity simulation: {s}, erosion/surface change simulation: {s}, grid cell connectivity: {s}, external WTD: {d} m, artificial WTD: {d} m, slope of WT relative to landscape surface: {d}. Note: WTD will be simulated only if water table option in line#1 is chosen AND external WTD in line#3 < depth of the lowest soil layer in soil file. Artificial drainage will be simulated only if artificial water table option in line#1 is chosen AND artificial WTD in line#3 < external WTD in line#3.\n", .{ landscapeUnitFileName, nx + offset, ny + offset, blkc.ietyp[nx][ny], saltopt[blkc.isalt[nx][ny]], erosionopt[iersngforopt], gridconnopt[ncngforopt], blk2a.dtbli[nx][ny], blk2a.dtbldi[nx][ny], blk2a.dtblg[nx][ny] });
        //         try logSite.flush();
        //     }
        // }
        // tokens.deinit(allocator);
        // line = try landscapeUnitFile.takeDelimiterExclusive('\n');
        // tokens = try tokenizeLine(line, allocator);
        // if (tokens.items.len != 13) {
        //     const err = error.InvalidInputLandscapeFileLine4;
        //     try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        //     try logFileWriter.flush();
        //     return err;
        // }
        // for (nh1..nh2) |nx| {
        //     for (nv1..nv2) |ny| {
        //         // Read surface boundary conditions for run-off simulation through N, E, S, and W boundary
        //         blk2a.rchqn[nx][ny] = try parseTokenToFloat(f32, error.InvalidSurfBoundCond_N, tokens.items[0], logFileWriter);
        //         blk2a.rchqe[nx][ny] = try parseTokenToFloat(f32, error.InvalidSurfBoundCond_E, tokens.items[1], logFileWriter);
        //         blk2a.rchqs[nx][ny] = try parseTokenToFloat(f32, error.InvalidSurfBoundCond_S, tokens.items[2], logFileWriter);
        //         blk2a.rchqw[nx][ny] = try parseTokenToFloat(f32, error.InvalidSurfBoundCond_W, tokens.items[3], logFileWriter);
        //         // Read sub-surface boundary conditions for sub-surface lateral flux simulations through N, E, S, and W boundary
        //         blk2a.rchgnu[nx][ny] = try parseTokenToFloat(f32, error.InvalidSubSurfBoundCond_N, tokens.items[4], logFileWriter);
        //         blk2a.rchgeu[nx][ny] = try parseTokenToFloat(f32, error.InvalidSubSurfBoundCond_E, tokens.items[5], logFileWriter);
        //         blk2a.rchgsu[nx][ny] = try parseTokenToFloat(f32, error.InvalidSubSurfBoundCond_S, tokens.items[6], logFileWriter);
        //         blk2a.rchgwu[nx][ny] = try parseTokenToFloat(f32, error.InvalidSubSurfBoundCond_W, tokens.items[7], logFileWriter);
        //         // Read lateral distance to external water table (natural or artificial) to the N, E, S, and W
        //         blk2a.rchgnt[nx][ny] = try parseTokenToFloat(f32, error.InvalidDistToExtWT_N, tokens.items[8], logFileWriter);
        //         blk2a.rchget[nx][ny] = try parseTokenToFloat(f32, error.InvalidDistToExtWT_E, tokens.items[9], logFileWriter);
        //         blk2a.rchgst[nx][ny] = try parseTokenToFloat(f32, error.InvalidDistToExtWT_S, tokens.items[10], logFileWriter);
        //         blk2a.rchgwt[nx][ny] = try parseTokenToFloat(f32, error.InvalidDistToExtWT_W, tokens.items[11], logFileWriter);
        //         // Read lower boundary conditions for water flux simulations through lower boundary
        //         blk2a.rchgd[nx][ny] = try parseTokenToFloat(f32, error.InvalidLowerBoundCond, tokens.items[12], logFileWriter);
        //         try logSite.print("=> {s} line#4 inputs for model boundary conditions: grid cell position W-E: {}, N-S: {}, multiplier for surface run-off/run-on simulation through N: {d}, E: {d}, S: {d}, and W: {d} boundary. Multiplier for sub-surface discharge/recharge simulation through N: {d}, E: {d}, S: {d}, and W: {d} boundary. Lateral distance to external WT (natural or artificial) to the N: {d} m, E: {d} m, S: {d} m, and W: {d} m direction. Multiplier for water flux simulation (e.g. deep percolation, capillary-rise) through lower boundary: {d}.\n", .{ landscapeUnitFileName, nx + offset, ny + offset, blk2a.rchqn[nx][ny], blk2a.rchqe[nx][ny], blk2a.rchqs[nx][ny], blk2a.rchqw[nx][ny], blk2a.rchgnu[nx][ny], blk2a.rchgeu[nx][ny], blk2a.rchgsu[nx][ny], blk2a.rchgwu[nx][ny], blk2a.rchgnt[nx][ny], blk2a.rchget[nx][ny], blk2a.rchgst[nx][ny], blk2a.rchgwt[nx][ny], blk2a.rchgd[nx][ny] });
        //         try logSite.flush();
        //     }
        // }
        // tokens.deinit(allocator);
        // line = try landscapeUnitFile.takeDelimiterExclusive('\n');
        // tokens = try tokenizeLine(line, allocator);
        // if (tokens.items.len != 2) {
        //     const err = error.InvalidInputLandscapeFileLine5;
        //     try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        //     try logFileWriter.flush();
        //     return err;
        // }
        // for (nh1..nh2) |nx| {
        //     for (nv1..nv2) |ny| {
        //         // Read width of the W-E landscape (m)
        //         blk2a.dh[nx][ny] = try parseTokenToFloat(f32, error.InvalidGridWidthInLandscapeFile_WE, tokens.items[0], logFileWriter);
        //         // Read width of the N-S landscape (m)
        //         blk2a.dv[nx][ny] = try parseTokenToFloat(f32, error.InvalidGridWidthInLandscapeFile_NS, tokens.items[1], logFileWriter);
        //         try logSite.print("=> {s} line#5 inputs for grid cell size: grid cell position W-E: {}, N-S: {}, W-E width: {d} m, N-S width: {d} m. [End of {s} file.]\n", .{ landscapeUnitFileName, nx + offset, ny + offset, blk2a.dh[nx][ny], blk2a.dv[nx][ny], landscapeUnitFileName });
        //         try logSite.flush();
        //     }
        // }
        // tokens.deinit(allocator);
        for (nh1..nh2) |_| {
            for (nv1..nv2) |_| {
                // blk2a.co2e[nx][ny] = blk2a.co2ei[nx][ny];
                // blk2a.h2ge[nx][ny] = 1.0e-03;
                // // Calculate maximum daylength for plant phenology
                // // dylm = maximum daylength (h)
                // if (blkc.alat[nx][ny] > 0.0) {
                //     blkc.dylm[nx][ny] = try dylnFunc(blkc, 173, nx, ny);
                // } else {
                //     blkc.dylm[nx][ny] = try dylnFunc(blkc, 356, nx, ny);
                // }
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

/// This function returns time step or frequency details.
pub fn timeFrequency(ttype: u8) anyerror![]const u8 {
    return switch (ttype) {
        'H', 'h' => "hourly",
        'D', 'd' => "daily",
        '3' => "3-hourly",
        else => error.InvalidDateFormatInWeatherUnitFileHeader,
    };
}

/// This function returns date format details.
pub fn calendarType(ctype: u8) ![]const u8 {
    return switch (ctype) {
        'J', 'j' => "julian date",
        else => "calendar date",
    };
}
