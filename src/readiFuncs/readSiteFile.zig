const std = @import("std");
const Blk2a = @import("../globalStructs/blk2a.zig").Blk2a;
const Blkc = @import("../globalStructs/blkc.zig").Blkc;
const Blkmain = @import("../localStructs/blkmain.zig").Blkmain;
const readLine = @import("../ecosysUtils/readLine.zig").readLine;
const tokenizeLine = @import("../ecosysUtils/tokenizeLine.zig").tokenizeLine;
const flatIndex = @import("../ecosysUtils/flatIndex.zig").flatIndex;
const dylnFunc = @import("dylnFunc.zig").dylnFunc;
const parseTokenToInt = @import("../ecosysUtils/parseTokenToInt.zig").parseTokenToInt;
const parseTokenToFloat = @import("../ecosysUtils/parseTokenToFloat.zig").parseTokenToFloat;
/// This function reads site cluster data
pub fn readSiteFile(allocator: std.mem.Allocator, logFileWriter: std.fs.File.Writer, siteClusterName: []const u8, blk2a: *Blk2a, blkc: *Blkc) anyerror!void {
    // Open site cluster file
    const fs = std.fs.cwd();
    const siteClusterFile = fs.openFile(siteClusterName, .{}) catch |err| {
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        return error.SiteClusterFileNotFoundOrFailedToOpenSiteClusterFile;
    };
    defer siteClusterFile.close();
    // Create a log file to write site file inputs to check if they are all appropriately read
    var logSitefile = try fs.createFile("outputs/checkPointLogs/siteFileInputCheckLog", .{ .read = false });
    defer logSitefile.close();
    const logSite = logSitefile.writer();
    const wtflag: [5][]const u8 = .{ "no", "yes, natural, stationary", "yes, natural, mobile", "yes, artificial, stationary", "yes, artificial, mobile" };
    const saltopt: [2][]const u8 = .{ "no salinity simulation", "salinity simulation" };
    const erosionopt: [5][]const u8 = .{ "no change in elevation", "allow freeze-thaw to change elevation", "allow freeze-thaw + erosion to change elevation", "allow freeze-thaw + soc accumulation to change elevation", "allow freeze-thaw + soc accumulation + erosion to change elevation" };
    const gridconnopt: [3][]const u8 = .{ "lateral connections between grid cells (and hence lateral flux simulations)", "not a valid option", "no lateral connection/flux simulation" };
    // Read grid position of each site in the site cluster file
    while (true) {
        var line = readLine(siteClusterFile, allocator) catch break; // break out of the loop at the EOF.
        var tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 4) {
            const err = error.InvalidInputForGridCellPositionsInSiteClusterFile;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        // Read grid cell positions in W, N, E, and S direction
        const nh1 = try parseTokenToInt(u32, error.InvalidGridCellPositionInSiteClusterFile_W, tokens.items[0], logFileWriter) - 1;
        const nv1 = try parseTokenToInt(u32, error.InvalidGridCellPositionInSiteClusterFile_N, tokens.items[1], logFileWriter) - 1;
        const nh2 = try parseTokenToInt(u32, error.InvalidGridCellPositionInSiteClusterFile_E, tokens.items[2], logFileWriter);
        const nv2 = try parseTokenToInt(u32, error.InvalidGridCellPositionInSiteClusterFile_S, tokens.items[3], logFileWriter);
        try logSite.print("=> Site grid cell positions: W: {}, N: {}, E: {}, S: {}.\n", .{ nh1, nv1, nh2, nv2 });
        allocator.free(line);
        tokens.deinit();
        // Read each site file in the site cluster
        line = try readLine(siteClusterFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 1) {
            const err = error.InvalidInputForSiteFileNameInSiteClusterFile;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        const siteFileName: []const u8 = tokens.items[0];
        const siteFile = fs.openFile(siteFileName, .{}) catch |err| {
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return error.SiteFileNotFoundOrFailedToOpenSiteFile;
        };
        defer siteFile.close();
        allocator.free(line);
        tokens.deinit();
        line = try readLine(siteFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 4) {
            const err = error.InvalidInputSiteFileLine1;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        // Read latitude
        const alatg = try parseTokenToFloat(f32, error.InvalidLatitude, tokens.items[0], logFileWriter);
        // Read altitude
        const altig = try parseTokenToFloat(f32, error.InvalidElevation, tokens.items[1], logFileWriter);
        // Read mean annual temperature (MAT) (deg C) to be used as lower boundary initial temperature
        const atcag = try parseTokenToFloat(f32, error.InvalidMeanAnnualTemperature, tokens.items[2], logFileWriter);
        // Read water table flag; 0 = none; 1,2 = natural stationary, mobile; 3,4 = artificial stationary, mobile
        const idtblg = try parseTokenToInt(u32, error.InvalidWaterTableFlag, tokens.items[3], logFileWriter);
        if (idtblg > 4) {
            const err = error.InvalidWaterTableFlag;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        try logSite.print("=> [Start of {s} file.] {s} line#1 inputs: latitude: {d} degree, elevation: {d} m, MAT: {d} degree C, water table simulation: {s}.\n", .{ siteFileName, siteFileName, alatg, altig, atcag, wtflag[idtblg] });
        allocator.free(line);
        tokens.deinit();
        line = try readLine(siteFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 6) {
            const err = error.InvalidInputSiteFileLine2;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        // Read atmospheric O2 concentration (ppm)
        const oxyeg = try parseTokenToFloat(f32, error.InvalidAtmO2Concentration, tokens.items[0], logFileWriter);
        // Read atmospheric N2 concentration (ppm)
        const z2geg = try parseTokenToFloat(f32, error.InvalidAtmN2Concentration, tokens.items[1], logFileWriter);
        // Read atmospheric CO2 concentration (ppm)
        const co2eig = try parseTokenToFloat(f32, error.InvalidAtmCO2Concentration, tokens.items[2], logFileWriter);
        // Read atmospheric CH4 concentration (ppm)
        const ch4eg = try parseTokenToFloat(f32, error.InvalidAtmCH4Concentration, tokens.items[3], logFileWriter);
        // Read atmospheric N2O concentration (ppm)
        const z2oeg = try parseTokenToFloat(f32, error.InvalidAtmN2OConcentration, tokens.items[4], logFileWriter);
        // Read atmospheric NH3 concentration (ppm)
        const znh3eg = try parseTokenToFloat(f32, error.InvalidAtmNH3Concentration, tokens.items[5], logFileWriter);
        try logSite.print("=> {s} line#2 inputs for atmospheric gas concentrations: O2: {} ppm, N2: {} ppm, CO2: {d} ppm, CH4: {d} ppm, N2O: {d} ppm, NH3: {d} ppm.\n", .{ siteFileName, oxyeg, z2geg, co2eig, ch4eg, z2oeg, znh3eg });
        allocator.free(line);
        tokens.deinit();
        line = try readLine(siteFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 7) {
            const err = error.InvalidInputSiteFileLine3;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        // Read Koppen climate zone
        const ietypg = try parseTokenToInt(u32, error.InvalidKoppenClimateZone, tokens.items[0], logFileWriter);
        // Read salt options; 0 = no salinity simulation; 1 = salinity simulation
        const isaltg = try parseTokenToInt(u32, error.InvalidSaltOption, tokens.items[1], logFileWriter);
        if (isaltg > 1) {
            const err = error.InvalidSaltOption;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        // Read erosion options; 0 = allow freeze-thaw to change elevation; 1 = allow freeze-thaw plus erosion to change elevation; 2 = allow freeze-thaw plus soc accumulation to change elevation; 3 = allow freeze-thaw plus soc accumulation plus erosion to change elevation, -1 = no change in elevation
        const iersng = try parseTokenToInt(i32, error.InvalidErosionOption, tokens.items[2], logFileWriter);
        if (iersng > 3 or iersng < -1) {
            const err = error.InvalidErosionOption;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        // Read lateral mass and energy transport options; 1 = lateral connections between grid cells (and hence lateral flux simulations); 3 = no lateral connection/flux simulation
        const ncng = try parseTokenToInt(u32, error.InvalidLateralFluxOption, tokens.items[3], logFileWriter);
        if (ncng != 1) {
            if (ncng != 3) {
                const err = error.InvalidLateralFluxOption;
                try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                return err;
            }
        }
        // Read the depth of natural external water table (m)
        const dtblig = try parseTokenToFloat(f32, error.InvalidExtWTD, tokens.items[4], logFileWriter);
        // Read the depth of artificial water table to simulate artificial drainage (m)
        const dtbldig = try parseTokenToFloat(f32, error.InvalidArtificialWTD, tokens.items[5], logFileWriter);
        // Slope of natural water table relative to landscape surface
        const dtblgg = try parseTokenToFloat(f32, error.InvalidWTDSlope, tokens.items[6], logFileWriter);
        const iersngforopt: u32 = @max(0, @min(4, iersng + 1));
        const ncngforopt: u32 = ncng - 1;
        try logSite.print("=> {s} line#3 inputs -> Koppen climate zone: {}, salinity simulation: {s}, erosion/surface change simulation: {s}, grid cell connectivity: {s}, external WTD: {d} m, artificial WTD: {d} m, slope of WT relative to landscape surface: {d}. Note: WTD will be simulated only if water table option in line#1 is chosen AND external WTD in line#3 < depth of the lowest soil layer in soil file. Artificial drainage will be simulated only if artificial water table option in line#1 is chosen AND artificial WTD in line#3 < external WTD in line#3.\n", .{ siteFileName, ietypg, saltopt[isaltg], erosionopt[iersngforopt], gridconnopt[ncngforopt], dtblig, dtbldig, dtblgg });
        allocator.free(line);
        tokens.deinit();
        line = try readLine(siteFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 13) {
            const err = error.InvalidInputSiteFileLine4;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        // Read surface boundary conditions for run-off simulation through N, E, S, and W boundary
        const rchqng = try parseTokenToFloat(f32, error.InvalidSurfBoundCond_N, tokens.items[0], logFileWriter);
        const rchqeg = try parseTokenToFloat(f32, error.InvalidSurfBoundCond_E, tokens.items[1], logFileWriter);
        const rchqsg = try parseTokenToFloat(f32, error.InvalidSurfBoundCond_S, tokens.items[2], logFileWriter);
        const rchqwg = try parseTokenToFloat(f32, error.InvalidSurfBoundCond_W, tokens.items[3], logFileWriter);
        // Read sub-surface boundary conditions for sub-surface lateral flux simulations through N, E, S, and W boundary
        const rchgnug = try parseTokenToFloat(f32, error.InvalidSubSurfBoundCond_N, tokens.items[4], logFileWriter);
        const rchgeug = try parseTokenToFloat(f32, error.InvalidSubSurfBoundCond_E, tokens.items[5], logFileWriter);
        const rchgsug = try parseTokenToFloat(f32, error.InvalidSubSurfBoundCond_S, tokens.items[6], logFileWriter);
        const rchgwug = try parseTokenToFloat(f32, error.InvalidSubSurfBoundCond_W, tokens.items[7], logFileWriter);
        // Read lateral distance to external water table (natural or artificial) to the N, E, S, and W
        const rchgntg = try parseTokenToFloat(f32, error.InvalidDistToExtWT_N, tokens.items[8], logFileWriter);
        const rchgetg = try parseTokenToFloat(f32, error.InvalidDistToExtWT_E, tokens.items[9], logFileWriter);
        const rchgstg = try parseTokenToFloat(f32, error.InvalidDistToExtWT_S, tokens.items[10], logFileWriter);
        const rchgwtg = try parseTokenToFloat(f32, error.InvalidDistToExtWT_W, tokens.items[11], logFileWriter);
        // Read lower boundary conditions for water flux simulations through lower boundary
        const rchgdg = try parseTokenToFloat(f32, error.InvalidLowerBoundCond, tokens.items[12], logFileWriter);
        try logSite.print("=> {s} line#4 inputs for model boundary conditions -> multiplier for surface run-off/run-on simulation through N: {d}, E: {d}, S: {d}, and W: {d} boundary. Multiplier for sub-surface discharge/recharge simulation through N: {d}, E: {d}, S: {d}, and W: {d} boundary. Lateral distance to external WT (natural or artificial) to the N: {d} m, E: {d} m, S: {d} m, and W: {d} m direction. Multiplier for water flux simulation (e.g. deep percolation, capillary-rise) through lower boundary: {d}.\n", .{ siteFileName, rchqng, rchqeg, rchqsg, rchqwg, rchgnug, rchgeug, rchgsug, rchgwug, rchgntg, rchgetg, rchgstg, rchgwtg, rchgdg });
        allocator.free(line);
        tokens.deinit();
        line = try readLine(siteFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 2) {
            const err = error.InvalidInputSiteFileLine5;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        // Read width of the W-E landscape (m)
        const dhi = try parseTokenToFloat(f32, error.InvalidGridWidthInSiteFile_WE, tokens.items[0], logFileWriter);
        // Read width of the N-S landscape (m)
        const dvi = try parseTokenToFloat(f32, error.InvalidGridWidthInSiteFile_NS, tokens.items[1], logFileWriter);
        try logSite.print("=> {s} line#5 inputs for grid cell size -> W-E width: {d} m, N-S width: {d} m. [End of {s} file.]\n", .{ siteFileName, dhi, dvi, siteFileName });
        allocator.free(line);
        tokens.deinit();
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                // Assign topography and environmental parameters
                blkc.alat[nx][ny] = alatg;
                blk2a.alti[nx][ny] = altig;
                blk2a.atcai[nx][ny] = atcag;
                blk2a.idtbl[nx][ny] = idtblg;
                blk2a.oxye[nx][ny] = oxyeg;
                blk2a.z2ge[nx][ny] = z2geg;
                blk2a.co2ei[nx][ny] = co2eig;
                blk2a.ch4e[nx][ny] = ch4eg;
                blk2a.z2oe[nx][ny] = z2oeg;
                blk2a.znh3e[nx][ny] = znh3eg;
                blkc.ietyp[nx][ny] = ietypg;
                blkc.isalt[nx][ny] = isaltg;
                blkc.iersn[nx][ny] = iersng;
                blkc.ncn[nx][ny] = ncng;
                blk2a.dtbli[nx][ny] = dtblig;
                blk2a.dtbldi[nx][ny] = dtbldig;
                blk2a.dtblg[nx][ny] = dtblgg;
                blk2a.rchqn[nx][ny] = rchqng;
                blk2a.rchqe[nx][ny] = rchqeg;
                blk2a.rchqs[nx][ny] = rchqsg;
                blk2a.rchqw[nx][ny] = rchqwg;
                blk2a.rchgnu[nx][ny] = rchgnug;
                blk2a.rchgeu[nx][ny] = rchgeug;
                blk2a.rchgsu[nx][ny] = rchgsug;
                blk2a.rchgwu[nx][ny] = rchgwug;
                blk2a.rchgnt[nx][ny] = rchgntg;
                blk2a.rchget[nx][ny] = rchgetg;
                blk2a.rchgst[nx][ny] = rchgstg;
                blk2a.rchgwt[nx][ny] = rchgwtg;
                blk2a.rchgd[nx][ny] = rchgdg;
                blk2a.dh[nx][ny] = dhi;
                blk2a.dv[nx][ny] = dvi;
                blk2a.co2e[nx][ny] = blk2a.co2ei[nx][ny];
                blk2a.h2ge[nx][ny] = 1.0e-03;
                // Calculate maximum daylenth for plant phenology
                // dylm = maximum daylength (h)
                if (blkc.alat[nx][ny] > 0.0) {
                    blkc.dylm[nx][ny] = try dylnFunc(blkc, 173, nx, ny);
                } else {
                    blkc.dylm[nx][ny] = try dylnFunc(blkc, 356, nx, ny);
                }
            }
        }
    }
}
