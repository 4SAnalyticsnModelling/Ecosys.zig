const std = @import("std");
const offset: u32 = 1;
const Blk2a = @import("../globalStructs/blk2a.zig").Blk2a;
const Blkc = @import("../globalStructs/blkc.zig").Blkc;
const Blkmain = @import("../localStructs/blkmain.zig").Blkmain;
const readLine = @import("../ecosysUtils/readLine.zig").readLine;
const tokenizeLine = @import("../ecosysUtils/tokenizeLine.zig").tokenizeLine;
const dylnFunc = @import("dylnFunc.zig").dylnFunc;
const parseTokenToInt = @import("../ecosysUtils/parseTokenToInt.zig").parseTokenToInt;
const parseTokenToFloat = @import("../ecosysUtils/parseTokenToFloat.zig").parseTokenToFloat;
/// This function reads site data
pub fn readSiteFile(allocator: std.mem.Allocator, logFileWriter: std.fs.File.Writer, siteName: []const u8, blk2a: *Blk2a, blkc: *Blkc, nhw: u32, nvn: u32, nhe: u32, nvs: u32) anyerror!void {
    // Log error message if this function fails
    errdefer {
        const err = error.FunctionFailed_readSiteFile;
        logFileWriter.print("error: {s}\n", .{@errorName(err)}) catch {};
        std.debug.print("error: {s}\n", .{@errorName(err)});
    }
    // Open site file
    const fs = std.fs.cwd();
    const siteFile = fs.openFile(siteName, .{}) catch {
        const err = error.SiteFileNotFoundOrFailedToOpenSiteFile;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        return err;
    };
    defer siteFile.close();
    // Create a log file to write site file inputs to check if they are all appropriately read
    var logSiteFile = try fs.createFile("outputs/checkPointLogs/siteFileInputCheckLog", .{ .read = false });
    defer logSiteFile.close();
    const logSite = logSiteFile.writer();
    const wtflag: [5][]const u8 = .{ "no", "yes, natural, stationary", "yes, natural, mobile", "yes, artificial, stationary", "yes, artificial, mobile" };
    const saltopt: [2][]const u8 = .{ "no salinity simulation", "salinity simulation" };
    const erosionopt: [5][]const u8 = .{ "no change in elevation", "allow freeze-thaw to change elevation", "allow freeze-thaw + erosion to change elevation", "allow freeze-thaw + soc accumulation to change elevation", "allow freeze-thaw + soc accumulation + erosion to change elevation" };
    const gridconnopt: [3][]const u8 = .{ "lateral connections between grid cells (and hence lateral flux simulations)", "not a valid option", "no lateral connection/flux simulation" };
    var gridCount: u32 = 0;
    while (true) {
        var line = readLine(siteFile, allocator) catch break; // break out of the loop at the EOF.
        var tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 4) {
            const err = error.InvalidInputForGridCellPositionsInSiteFile;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        // Read grid cell positions in W, N, E, and S direction
        const nh1 = try parseTokenToInt(u32, error.InvalidGridCellPositionInSiteFile_W, tokens.items[0], logFileWriter) - offset;
        const nv1 = try parseTokenToInt(u32, error.InvalidGridCellPositionInSiteFile_N, tokens.items[1], logFileWriter) - offset;
        const nh2 = try parseTokenToInt(u32, error.InvalidGridCellPositionInSiteFile_E, tokens.items[2], logFileWriter);
        const nv2 = try parseTokenToInt(u32, error.InvalidGridCellPositionInSiteFile_S, tokens.items[3], logFileWriter);
        try logSite.print("=> Grid cell positions: W: {}, N: {}, E: {}, S: {}.\n", .{ nh1 + offset, nv1 + offset, nh2 + offset, nv2 + offset });
        if (nh1 > nh2 or nv1 > nv2 or nh1 < nhw or nh2 > nhe or nv1 < nvn or nv2 > nvs) {
            const err = error.InvalidInputForGridCellPositionsInSiteFile;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        allocator.free(line);
        tokens.deinit();
        // Read each landscape unit file within the site file
        line = try readLine(siteFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 1) {
            const err = error.InvalidInputForLandscapeUnitNameInSiteFile;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        const landscapeUnitFileName: []const u8 = tokens.items[0];
        const landscapeUnitFile = fs.openFile(landscapeUnitFileName, .{}) catch |err| {
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return error.LandscapeUnitFileNotFoundInSiteFileOrFailedToOpenLandscapeUnitFile;
        };
        defer landscapeUnitFile.close();
        allocator.free(line);
        tokens.deinit();
        line = try readLine(landscapeUnitFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 4) {
            const err = error.InvalidInputLandscapeUnitFileLine1;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                // Read latitude
                blkc.alat[nx][ny] = try parseTokenToFloat(f32, error.InvalidLatitude, tokens.items[0], logFileWriter);
                // Read altitude
                blk2a.alti[nx][ny] = try parseTokenToFloat(f32, error.InvalidElevation, tokens.items[1], logFileWriter);
                // Read mean annual temperature (MAT) (deg C) to be used as lower boundary initial temperature
                blk2a.atcai[nx][ny] = try parseTokenToFloat(f32, error.InvalidMeanAnnualTemperature, tokens.items[2], logFileWriter);
                // Read water table flag; 0 = none; 1,2 = natural stationary, mobile; 3,4 = artificial stationary, mobile
                blk2a.idtbl[nx][ny] = try parseTokenToInt(u32, error.InvalidWaterTableFlag, tokens.items[3], logFileWriter);
                if (blk2a.idtbl[nx][ny] > 4) {
                    const err = error.InvalidWaterTableFlag;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logSite.print("=> [Start of {s} file.] {s} line#1 inputs: grid cell position W-E: {}, N-S: {}, latitude: {d} degree, elevation: {d} m, MAT: {d} degree C, water table simulation: {s}.\n", .{ landscapeUnitFileName, landscapeUnitFileName, nx + offset, ny + offset, blkc.alat[nx][ny], blk2a.alti[nx][ny], blk2a.atcai[nx][ny], wtflag[blk2a.idtbl[nx][ny]] });
            }
        }
        allocator.free(line);
        tokens.deinit();
        line = try readLine(landscapeUnitFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 6) {
            const err = error.InvalidInputLandscapeUnitFileLine2;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                // Read atmospheric O2 concentration (ppm)
                blk2a.oxye[nx][ny] = try parseTokenToFloat(f32, error.InvalidAtmO2Concentration, tokens.items[0], logFileWriter);
                // Read atmospheric N2 concentration (ppm)
                blk2a.z2ge[nx][ny] = try parseTokenToFloat(f32, error.InvalidAtmN2Concentration, tokens.items[1], logFileWriter);
                // Read atmospheric CO2 concentration (ppm)
                blk2a.co2ei[nx][ny] = try parseTokenToFloat(f32, error.InvalidAtmCO2Concentration, tokens.items[2], logFileWriter);
                // Read atmospheric CH4 concentration (ppm)
                blk2a.ch4e[nx][ny] = try parseTokenToFloat(f32, error.InvalidAtmCH4Concentration, tokens.items[3], logFileWriter);
                // Read atmospheric N2O concentration (ppm)
                blk2a.z2oe[nx][ny] = try parseTokenToFloat(f32, error.InvalidAtmN2OConcentration, tokens.items[4], logFileWriter);
                // Read atmospheric NH3 concentration (ppm)
                blk2a.znh3e[nx][ny] = try parseTokenToFloat(f32, error.InvalidAtmNH3Concentration, tokens.items[5], logFileWriter);
                try logSite.print("=> {s} line#2 inputs for atmospheric gas concentrations: grid cell position W-E: {}, N-S: {}, O2: {} ppm, N2: {} ppm, CO2: {d} ppm, CH4: {d} ppm, N2O: {d} ppm, NH3: {d} ppm.\n", .{ landscapeUnitFileName, nx + offset, ny + offset, blk2a.oxye[nx][ny], blk2a.z2ge[nx][ny], blk2a.co2ei[nx][ny], blk2a.ch4e[nx][ny], blk2a.z2oe[nx][ny], blk2a.znh3e[nx][ny] });
            }
        }
        allocator.free(line);
        tokens.deinit();
        line = try readLine(landscapeUnitFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 7) {
            const err = error.InvalidInputLandscapeUnitFileLine3;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                // Read Koppen climate zone
                blkc.ietyp[nx][ny] = try parseTokenToInt(u32, error.InvalidKoppenClimateZone, tokens.items[0], logFileWriter);
                // Read salt options; 0 = no salinity simulation; 1 = salinity simulation
                blkc.isalt[nx][ny] = try parseTokenToInt(u32, error.InvalidSaltOption, tokens.items[1], logFileWriter);
                if (blkc.isalt[nx][ny] > 1) {
                    const err = error.InvalidSaltOption;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                // Read erosion options; 0 = allow freeze-thaw to change elevation; 1 = allow freeze-thaw plus erosion to change elevation; 2 = allow freeze-thaw plus soc accumulation to change elevation; 3 = allow freeze-thaw plus soc accumulation plus erosion to change elevation, -1 = no change in elevation
                blkc.iersn[nx][ny] = try parseTokenToInt(i32, error.InvalidErosionOption, tokens.items[2], logFileWriter);
                if (blkc.iersn[nx][ny] > 3 or blkc.iersn[nx][ny] < -1) {
                    const err = error.InvalidErosionOption;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                // Read lateral mass and energy transport options; 1 = lateral connections between grid cells (and hence lateral flux simulations); 3 = no lateral connection/flux simulation
                blkc.ncn[nx][ny] = try parseTokenToInt(u32, error.InvalidLateralFluxOption, tokens.items[3], logFileWriter);
                if (blkc.ncn[nx][ny] != 1) {
                    if (blkc.ncn[nx][ny] != 3) {
                        const err = error.InvalidLateralFluxOption;
                        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                        return err;
                    }
                }
                // Read the depth of natural external water table (m)
                blk2a.dtbli[nx][ny] = try parseTokenToFloat(f32, error.InvalidExtWTD, tokens.items[4], logFileWriter);
                // Read the depth of artificial water table to simulate artificial drainage (m)
                blk2a.dtbldi[nx][ny] = try parseTokenToFloat(f32, error.InvalidArtificialWTD, tokens.items[5], logFileWriter);
                // Slope of natural water table relative to landscape surface
                blk2a.dtblg[nx][ny] = try parseTokenToFloat(f32, error.InvalidWTDSlope, tokens.items[6], logFileWriter);
                const iersngforopt: u32 = @max(0, @min(4, blkc.iersn[nx][ny] + 1));
                const ncngforopt: u32 = blkc.ncn[nx][ny] - 1;
                try logSite.print("=> {s} line#3 inputs: grid cell position W-E: {}, N-S: {}, Koppen climate zone: {}, salinity simulation: {s}, erosion/surface change simulation: {s}, grid cell connectivity: {s}, external WTD: {d} m, artificial WTD: {d} m, slope of WT relative to landscape surface: {d}. Note: WTD will be simulated only if water table option in line#1 is chosen AND external WTD in line#3 < depth of the lowest soil layer in soil file. Artificial drainage will be simulated only if artificial water table option in line#1 is chosen AND artificial WTD in line#3 < external WTD in line#3.\n", .{ landscapeUnitFileName, nx + offset, ny + offset, blkc.ietyp[nx][ny], saltopt[blkc.isalt[nx][ny]], erosionopt[iersngforopt], gridconnopt[ncngforopt], blk2a.dtbli[nx][ny], blk2a.dtbldi[nx][ny], blk2a.dtblg[nx][ny] });
            }
        }
        allocator.free(line);
        tokens.deinit();
        line = try readLine(landscapeUnitFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 13) {
            const err = error.InvalidInputLandscapeFileLine4;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                // Read surface boundary conditions for run-off simulation through N, E, S, and W boundary
                blk2a.rchqn[nx][ny] = try parseTokenToFloat(f32, error.InvalidSurfBoundCond_N, tokens.items[0], logFileWriter);
                blk2a.rchqe[nx][ny] = try parseTokenToFloat(f32, error.InvalidSurfBoundCond_E, tokens.items[1], logFileWriter);
                blk2a.rchqs[nx][ny] = try parseTokenToFloat(f32, error.InvalidSurfBoundCond_S, tokens.items[2], logFileWriter);
                blk2a.rchqw[nx][ny] = try parseTokenToFloat(f32, error.InvalidSurfBoundCond_W, tokens.items[3], logFileWriter);
                // Read sub-surface boundary conditions for sub-surface lateral flux simulations through N, E, S, and W boundary
                blk2a.rchgnu[nx][ny] = try parseTokenToFloat(f32, error.InvalidSubSurfBoundCond_N, tokens.items[4], logFileWriter);
                blk2a.rchgeu[nx][ny] = try parseTokenToFloat(f32, error.InvalidSubSurfBoundCond_E, tokens.items[5], logFileWriter);
                blk2a.rchgsu[nx][ny] = try parseTokenToFloat(f32, error.InvalidSubSurfBoundCond_S, tokens.items[6], logFileWriter);
                blk2a.rchgwu[nx][ny] = try parseTokenToFloat(f32, error.InvalidSubSurfBoundCond_W, tokens.items[7], logFileWriter);
                // Read lateral distance to external water table (natural or artificial) to the N, E, S, and W
                blk2a.rchgnt[nx][ny] = try parseTokenToFloat(f32, error.InvalidDistToExtWT_N, tokens.items[8], logFileWriter);
                blk2a.rchget[nx][ny] = try parseTokenToFloat(f32, error.InvalidDistToExtWT_E, tokens.items[9], logFileWriter);
                blk2a.rchgst[nx][ny] = try parseTokenToFloat(f32, error.InvalidDistToExtWT_S, tokens.items[10], logFileWriter);
                blk2a.rchgwt[nx][ny] = try parseTokenToFloat(f32, error.InvalidDistToExtWT_W, tokens.items[11], logFileWriter);
                // Read lower boundary conditions for water flux simulations through lower boundary
                blk2a.rchgd[nx][ny] = try parseTokenToFloat(f32, error.InvalidLowerBoundCond, tokens.items[12], logFileWriter);
                try logSite.print("=> {s} line#4 inputs for model boundary conditions: grid cell position W-E: {}, N-S: {}, multiplier for surface run-off/run-on simulation through N: {d}, E: {d}, S: {d}, and W: {d} boundary. Multiplier for sub-surface discharge/recharge simulation through N: {d}, E: {d}, S: {d}, and W: {d} boundary. Lateral distance to external WT (natural or artificial) to the N: {d} m, E: {d} m, S: {d} m, and W: {d} m direction. Multiplier for water flux simulation (e.g. deep percolation, capillary-rise) through lower boundary: {d}.\n", .{ landscapeUnitFileName, nx + offset, ny + offset, blk2a.rchqn[nx][ny], blk2a.rchqe[nx][ny], blk2a.rchqs[nx][ny], blk2a.rchqw[nx][ny], blk2a.rchgnu[nx][ny], blk2a.rchgeu[nx][ny], blk2a.rchgsu[nx][ny], blk2a.rchgwu[nx][ny], blk2a.rchgnt[nx][ny], blk2a.rchget[nx][ny], blk2a.rchgst[nx][ny], blk2a.rchgwt[nx][ny], blk2a.rchgd[nx][ny] });
            }
        }
        allocator.free(line);
        tokens.deinit();
        line = try readLine(landscapeUnitFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 2) {
            const err = error.InvalidInputLandscapeFileLine5;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                // Read width of the W-E landscape (m)
                blk2a.dh[nx][ny] = try parseTokenToFloat(f32, error.InvalidGridWidthInLandscapeFile_WE, tokens.items[0], logFileWriter);
                // Read width of the N-S landscape (m)
                blk2a.dv[nx][ny] = try parseTokenToFloat(f32, error.InvalidGridWidthInLandscapeFile_NS, tokens.items[1], logFileWriter);
                try logSite.print("=> {s} line#5 inputs for grid cell size: grid cell position W-E: {}, N-S: {}, W-E width: {d} m, N-S width: {d} m. [End of {s} file.]\n", .{ landscapeUnitFileName, nx + offset, ny + offset, blk2a.dh[nx][ny], blk2a.dv[nx][ny], landscapeUnitFileName });
            }
        }
        allocator.free(line);
        tokens.deinit();
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                blk2a.co2e[nx][ny] = blk2a.co2ei[nx][ny];
                blk2a.h2ge[nx][ny] = 1.0e-03;
                // Calculate maximum daylength for plant phenology
                // dylm = maximum daylength (h)
                if (blkc.alat[nx][ny] > 0.0) {
                    blkc.dylm[nx][ny] = try dylnFunc(blkc, 173, nx, ny);
                } else {
                    blkc.dylm[nx][ny] = try dylnFunc(blkc, 356, nx, ny);
                }
                gridCount += 1;
            }
        }
    }
    if (gridCount != (nhe - nhw) * (nvs - nvn)) {
        const err = error.InvalidInputForGridCellPositionsInSiteFile;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        return err;
    }
}
