const std = @import("std");
const offset: usize = 1;
const Site = @import("../dtypes/domain/site.zig").Site;
const tokenizeLine = @import("../util/tokenize_line.zig").tokenizeLine;
const handleError = @import("../util/handle_error.zig").handleError;
const checkTokenInLine = @import("../util/check_token_in_line.zig").checkTokenInLine;
const open = @import("../util/open.zig").open;
const parseTokenToInt = @import("../util/parse_tokens.zig").parseTokenToInt;
const parseTokenToFloat = @import("../util/parse_tokens.zig").parseTokenToFloat;
const parseGrids = @import("../util/parse_grids.zig").parseGrids;
const checkGrids = @import("../util/parse_grids.zig").checkGrids;
/// This function loads all site inputs.
pub fn siteLoader(allocator: std.mem.Allocator, err_log: *std.Io.Writer, run_log: *std.Io.Writer, run_script_buf: std.Io.Reader, site: *Site, grid_pos_west: usize, grid_pos_north: usize, grid_pos_east: usize, grid_pos_south: usize) !void {
    // Log error message if this function fails
    errdefer handleError(error.FunctionFailedSiteLoader, err_log) catch {};
    // Buffer for file I/O: read
    var in_buf: [1024]u8 = undefined;
    // Buffer for file I/O: write
    var out_buf: [1024]u8 = undefined;
    const runscript = &run_script_buf;
    var line = try runscript.takeDelimiterExclusive('\n');
    var tokens = try tokenizeLine(line, allocator);
    std.debug.print("test line in siteLoader function: {s}, line length: {d}.\n", .{ line, line.len });
    try checkTokenInLine(error.InvalidSiteFileInRunfile, tokens.items.len, 1, err_log);
    const site_name = try allocator.dupe(u8, tokens.items[0]);
    defer allocator.free(site_name);
    try run_log.print("=> Site file: {s}.\n", .{site_name});
    try run_log.flush();
    tokens.deinit(allocator);
    // Open site file
    const fs = std.fs.cwd();
    const sitefile = try open(site_name, err_log);
    defer sitefile.close();
    var site_buf = sitefile.reader(&in_buf);
    const site_file = &site_buf.interface;
    // Create a text file to write site file inputs to check if they are all appropriately read
    var log_site_file = try fs.createFile("outputs/input_checks/site.text", .{ .truncate = false });
    defer log_site_file.close();
    var log_site_buf = log_site_file.writer(&out_buf);
    const site_log = &log_site_buf.interface;
    while (true) {
        line = site_file.takeDelimiterExclusive('\n') catch |err| switch (err) {
            error.EndOfStream => break,
            else => return err,
        }; // break out of the loop at the EOF.
        tokens = try tokenizeLine(line, allocator);
        // Read grid cell positions in W, N, E, and S direction
        const grids = try parseGrids(error.InvalidGridPositions, tokens, 4, err_log, site_log);
        const start_grid_west_east = grids.grid_pos_west;
        const start_grid_north_south = grids.grid_pos_north;
        const end_grid_west_east = grids.grid_pos_east;
        const end_grid_north_south = grids.grid_pos_south;
        try checkGrids(error.InvalidGridsInSiteFile, err_log, start_grid_west_east, start_grid_north_south, end_grid_west_east, end_grid_north_south, grid_pos_west, grid_pos_north, grid_pos_east, grid_pos_south);
        // Free up memory allocated in tokenized line
        tokens.deinit(allocator);
        // Read each landscape unit file within the site file
        line = try site_file.takeDelimiterExclusive('\n');
        tokens = try tokenizeLine(line, allocator);
        try checkTokenInLine(error.InvalidLandscapeUnitNameInSiteFile, tokens.items.len, 1, err_log);
        const land_unit_name = try allocator.dupe(u8, tokens.items[0]);
        defer allocator.free(land_unit_name);
        const land_unit_file = try open(land_unit_name, err_log);
        defer land_unit_file.close();
        var land_unit_file_buf = land_unit_file.reader(&in_buf);
        const land_unit_buf = &land_unit_file_buf.interface;
        tokens.deinit(allocator);
        //Read site location.
        try readLocation(allocator, land_unit_buf, err_log, site_log, site, land_unit_name, start_grid_west_east, start_grid_north_south, end_grid_west_east, end_grid_north_south);
        //Read initial atmospheric gas concentrations.
        try readAtmGas(allocator, land_unit_buf, err_log, site_log, site, land_unit_name, start_grid_west_east, start_grid_north_south, end_grid_west_east, end_grid_north_south);
        // Read various site options (e.g., koppen climate zone, salinity, erosion, grid connectivity, wtdx etc.).
        try readSiteOptions(allocator, land_unit_buf, err_log, site_log, site, land_unit_name, start_grid_west_east, start_grid_north_south, end_grid_west_east, end_grid_north_south);
        //Read surface and sub-surface boundary conditions for water flux.
        try readBoundary(allocator, land_unit_buf, err_log, site_log, site, land_unit_name, start_grid_west_east, start_grid_north_south, end_grid_west_east, end_grid_north_south);
        //Read grid dimensions.
        try readGridDimension(allocator, land_unit_buf, err_log, site_log, site, land_unit_name, start_grid_west_east, start_grid_north_south, end_grid_west_east, end_grid_north_south);
    }
}
///This function reads site location inputs.
fn readLocation(allocator: std.mem.Allocator, land_unit_buf: *std.Io.Reader, err_log: *std.Io.Writer, site_log: *std.Io.Writer, site: *Site, land_unit_name: []const u8, start_grid_west_east: usize, start_grid_north_south: usize, end_grid_west_east: usize, end_grid_north_south: usize) !void {
    const wt_opt_desc: [5][]const u8 = .{ "no", "yes, natural, stationary", "yes, natural, mobile", "yes, artificial, stationary", "yes, artificial, mobile" };
    const line = try land_unit_buf.takeDelimiterExclusive('\n');
    var tokens = try tokenizeLine(line, allocator);
    try checkTokenInLine(error.InvalidInputLandscapeUnitFileLine1, tokens.items.len, 4, err_log);
    for (start_grid_west_east..end_grid_west_east) |nx| {
        for (start_grid_north_south..end_grid_north_south) |ny| {
            // Read latitude (deg)
            site.loc.lat[nx][ny] = try parseTokenToFloat(f32, error.InvalidLatitude, tokens.items[0], err_log);
            // Read altitude (m)
            site.loc.alt_init[nx][ny] = try parseTokenToFloat(f32, error.InvalidAltitude, tokens.items[1], err_log);
            // Read mean annual temperature (MAT) (⁰C) to be used as lower boundary initial temperature
            site.loc.matc_init[nx][ny] = try parseTokenToFloat(f32, error.InvalidMeanAnnualTemperature, tokens.items[2], err_log);
            // Read water table option; 0 = none; 1,2 = natural stationary, mobile; 3,4 = artificial stationary, mobile
            site.loc.wt_opt[nx][ny] = try parseTokenToInt(usize, error.InvalidWaterTableOption, tokens.items[3], err_log);
            if (site.loc.wt_opt[nx][ny] > 4) {
                const err = error.InvalidWaterTableOption;
                try err_log.print("error: {s}\n", .{@errorName(err)});
                try err_log.flush();
                return err;
            }
            try site_log.print("=> [Start of {s} file.] {s} line#1 inputs: grid cell position W-E: {}, N-S: {}, latitude: {d} degree, altitude: {d} m, MAT: {d}⁰C, water table simulation: {s}.\n", .{ land_unit_name, land_unit_name, nx + offset, ny + offset, site.loc.lat[nx][ny], site.loc.alt_init[nx][ny], site.loc.matc_init[nx][ny], wt_opt_desc[site.loc.wt_opt[nx][ny]] });
            try site_log.flush();
            tokens.deinit(allocator);
            // Calculate maximum daylength hour for plant phenology.
            if (site.loc.lat[nx][ny] > 0.0) {
                site.loc.max_daylength[nx][ny] = daylengthHours(site, 173, nx, ny);
            } else {
                site.loc.max_daylength[nx][ny] = daylengthHours(site, 356, nx, ny);
            }
            std.debug.print("daylength hours nx: {}, ny: {} = {d}\n", .{ nx, ny, site.loc.max_daylength[nx][ny] });
        }
    }
}
///This function returns daylength (hours) for a site location and day of year (doy).
pub fn daylengthHours(site: *Site, doy: usize, nx: usize, ny: usize) f32 {
    const lat_rad = deg2rad(site.loc.lat[nx][ny]);
    const declination_rad = solarDeclination(doy);
    const solar_altitude_rad = deg2rad(-0.833);
    const numerator = @sin(solar_altitude_rad) - @sin(lat_rad) * @sin(declination_rad);
    const denominator = @cos(lat_rad) * @cos(declination_rad);
    if (@abs(denominator) < 1e-7) {
        if (numerator <= 0.0) return 24.0 else return 0.0;
    }
    var cos_hour_angle = numerator / denominator;
    cos_hour_angle = std.math.clamp(cos_hour_angle, -1.0, 1.0);
    if (cos_hour_angle <= -1.0) return 24.0;
    if (cos_hour_angle >= 1.0) return 0.0;
    const hour_angle_rad = std.math.acos(cos_hour_angle);
    const daylength_hours = (24.0 / std.math.pi) * hour_angle_rad;
    return daylength_hours;
}
///This function converts angle units.
fn deg2rad(deg: f32) f32 {
    return deg * std.math.pi / 180.0;
}
///This function calculates solar declination (radians) using Spencer (1971) approximation.
fn solarDeclination(doy: usize) f32 {
    const n = @as(f32, @floatFromInt(doy));
    const gamma = 2.0 * std.math.pi * (n - 1.0) / 365.0;
    return 0.006918 - 0.399912 * @cos(gamma) + 0.070257 * @sin(gamma) - 0.006758 * @cos(2.0 * gamma) + 0.000907 * @sin(2.0 * gamma) - 0.002697 * @cos(3.0 * gamma) + 0.001480 * @sin(3.0 * gamma);
}
///This function reads initial atmospheric gas concentrations.
fn readAtmGas(allocator: std.mem.Allocator, land_unit_buf: *std.Io.Reader, err_log: *std.Io.Writer, site_log: *std.Io.Writer, site: *Site, land_unit_name: []const u8, start_grid_west_east: usize, start_grid_north_south: usize, end_grid_west_east: usize, end_grid_north_south: usize) !void {
    for (start_grid_west_east..end_grid_west_east) |nx| {
        for (start_grid_north_south..end_grid_north_south) |ny| {
            const line = try land_unit_buf.takeDelimiterExclusive('\n');
            var tokens = try tokenizeLine(line, allocator);
            try checkTokenInLine(error.InvalidInputLandscapeUnitFileLine2, tokens.items.len, 6, err_log);
            // Read atmospheric O2 concentration (ppm)
            site.atm_gas.o2conc[nx][ny] = try parseTokenToFloat(f32, error.InvalidAtmO2, tokens.items[0], err_log);
            // Read atmospheric N2 concentration (ppm)
            site.atm_gas.n2conc[nx][ny] = try parseTokenToFloat(f32, error.InvalidAtmN2, tokens.items[1], err_log);
            // Read atmospheric CO2 concentration (ppm)
            site.atm_gas.co2conc_init[nx][ny] = try parseTokenToFloat(f32, error.InvalidAtmCO2, tokens.items[2], err_log);
            site.atm_gas.co2conc[nx][ny] = site.atm_gas.co2conc_init[nx][ny];
            // Read atmospheric CH4 concentration (ppm)
            site.atm_gas.ch4conc[nx][ny] = try parseTokenToFloat(f32, error.InvalidAtmCH4, tokens.items[3], err_log);
            // Read atmospheric N2O concentration (ppm)
            site.atm_gas.n2oconc[nx][ny] = try parseTokenToFloat(f32, error.InvalidAtmN2O, tokens.items[4], err_log);
            // Read atmospheric NH3 concentration (ppm)
            site.atm_gas.nh3conc[nx][ny] = try parseTokenToFloat(f32, error.InvalidAtmNH3, tokens.items[5], err_log);
            site.atm_gas.h2conc[nx][ny] = 1.0e-3;
            try site_log.print("=> {s} line#2 inputs for atmospheric gas concentrations: grid cell position W-E: {}, N-S: {}, O2: {} ppm, N2: {} ppm, CO2: {d} ppm, CH4: {d} ppm, N2O: {d} ppm, NH3: {d} ppm.\n", .{ land_unit_name, nx + offset, ny + offset, site.atm_gas.o2conc[nx][ny], site.atm_gas.n2conc[nx][ny], site.atm_gas.co2conc_init[nx][ny], site.atm_gas.ch4conc[nx][ny], site.atm_gas.n2oconc[nx][ny], site.atm_gas.nh3conc[nx][ny] });
            try site_log.flush();
            tokens.deinit(allocator);
        }
    }
}
///This function reads various site options (e.g., koppen climate zone, salinity, erosion, grid connectivity, wtdx etc.).
fn readSiteOptions(allocator: std.mem.Allocator, land_unit_buf: *std.Io.Reader, err_log: *std.Io.Writer, site_log: *std.Io.Writer, site: *Site, land_unit_name: []const u8, start_grid_west_east: usize, start_grid_north_south: usize, end_grid_west_east: usize, end_grid_north_south: usize) !void {
    const salinity_opt_desc: [2][]const u8 = .{ "do not simulate salinity", "simulate salinity" };
    const erosion_opt_desc: [5][]const u8 = .{ "no change in elevation", "allow freeze-thaw to change elevation", "allow freeze-thaw + erosion to change elevation", "allow freeze-thaw + soc accumulation to change elevation", "allow freeze-thaw + soc accumulation + erosion to change elevation" };
    const grid_conn_opt_desc: [3][]const u8 = .{ "lateral connections between grid cells (and hence lateral flux simulations)", "not a valid option", "no lateral connection/flux simulation" };
    const line = try land_unit_buf.takeDelimiterExclusive('\n');
    var tokens = try tokenizeLine(line, allocator);
    try checkTokenInLine(error.InvalidInputLandscapeUnitFileLine3, tokens.items.len, 7, err_log);
    for (start_grid_west_east..end_grid_west_east) |nx| {
        for (start_grid_north_south..end_grid_north_south) |ny| {
            // Read Koppen climate zone.
            site.opt.koppen_clim_zone[nx][ny] = try parseTokenToInt(usize, error.InvalidKoppenClimateZone, tokens.items[0], err_log);
            // Read salinity options; 0 = do not simulate salinity; 1 = simulate salinity.
            site.opt.salinity_opt[nx][ny] = try parseTokenToInt(usize, error.InvalidSalinityOption, tokens.items[1], err_log);
            if (site.opt.salinity_opt[nx][ny] > 1) {
                const err = error.InvalidSalinityOption;
                try err_log.print("error: {s}\n", .{@errorName(err)});
                try err_log.flush();
                return err;
            }
            // Read erosion options; 0 = allow freeze-thaw to change elevation; 1 = allow freeze-thaw plus erosion to change elevation; 2 = allow freeze-thaw plus SOC accumulation to change elevation; 3 = allow freeze-thaw plus SOC accumulation plus erosion to change elevation, -1 = no change in elevation.
            site.opt.erosion_opt[nx][ny] = try parseTokenToInt(i32, error.InvalidErosionOption, tokens.items[2], err_log);
            if (site.opt.erosion_opt[nx][ny] > 3 or site.opt.erosion_opt[nx][ny] < -1) {
                const err = error.InvalidErosionOption;
                try err_log.print("error: {s}\n", .{@errorName(err)});
                try err_log.flush();
                return err;
            }
            const erosion_opt_for_desc: usize = @max(0, @min(4, site.opt.erosion_opt[nx][ny] + 1));
            // Read lateral mass and energy transport options; 1 = lateral connections between grid cells (and hence lateral flux simulations); 3 = no lateral connection/flux simulation.
            site.opt.grid_conn_opt[nx][ny] = try parseTokenToInt(usize, error.InvalidLateralFluxOption, tokens.items[3], err_log);
            if (site.opt.grid_conn_opt[nx][ny] != 1) {
                if (site.opt.grid_conn_opt[nx][ny] != 3) {
                    const err = error.InvalidLateralFluxOption;
                    try err_log.print("error: {s}\n", .{@errorName(err)});
                    try err_log.flush();
                    return err;
                }
            }
            // Read the depth of natural external water table (m).
            site.opt.nat_wtdx_init[nx][ny] = try parseTokenToFloat(f32, error.InvalidExternalWTD, tokens.items[4], err_log);
            // Read the depth of artificial water table to simulate artificial drainage (m).
            site.opt.art_wtdx_init[nx][ny] = try parseTokenToFloat(f32, error.InvalidArtificialWTD, tokens.items[5], err_log);
            // Slope of natural water table relative to landscape surface.
            site.opt.nat_wtx_slope[nx][ny] = try parseTokenToFloat(f32, error.InvalidWTDSlope, tokens.items[6], err_log);
            try site_log.print("=> {s} line#3 inputs: grid cell position W-E: {}, N-S: {}, Koppen climate zone: {}, salinity simulation: {s}, erosion/surface change simulation: {s}, grid cell connectivity: {s}, external WTD: {d} m, artificial WTD: {d} m, slope of WT relative to landscape surface: {d}. Note: WTD will be simulated only if water table option in line#1 is chosen AND external WTD in line#3 < depth of the lowest soil layer in soil file. Artificial drainage will be simulated only if artificial water table option in line#1 is chosen AND artificial WTD in line#3 < external WTD in line#3.\n", .{ land_unit_name, nx + offset, ny + offset, site.opt.koppen_clim_zone[nx][ny], salinity_opt_desc[site.opt.salinity_opt[nx][ny]], erosion_opt_desc[erosion_opt_for_desc], grid_conn_opt_desc[site.opt.grid_conn_opt[nx][ny] - offset], site.opt.nat_wtdx_init[nx][ny], site.opt.art_wtdx_init[nx][ny], site.opt.nat_wtx_slope[nx][ny] });
            try site_log.flush();
            tokens.deinit(allocator);
        }
    }
}
///This function reads surface and sub-surface boundary conditions.
fn readBoundary(allocator: std.mem.Allocator, land_unit_buf: *std.Io.Reader, err_log: *std.Io.Writer, site_log: *std.Io.Writer, site: *Site, land_unit_name: []const u8, start_grid_west_east: usize, start_grid_north_south: usize, end_grid_west_east: usize, end_grid_north_south: usize) !void {
    for (start_grid_west_east..end_grid_west_east) |nx| {
        for (start_grid_north_south..end_grid_north_south) |ny| {
            const line = try land_unit_buf.takeDelimiterExclusive('\n');
            var tokens = try tokenizeLine(line, allocator);
            try checkTokenInLine(error.InvalidInputLandscapeUnitFileLine4, tokens.items.len, 13, err_log);
            // Read surface boundary conditions for run-off simulation through N, E, S, and W boundary
            site.bound.surf_north[nx][ny] = try parseTokenToFloat(f32, error.InvalidSurfBoundCondNorth, tokens.items[0], err_log);
            site.bound.surf_east[nx][ny] = try parseTokenToFloat(f32, error.InvalidSurfBoundCondEast, tokens.items[1], err_log);
            site.bound.surf_south[nx][ny] = try parseTokenToFloat(f32, error.InvalidSurfBoundCondSouth, tokens.items[2], err_log);
            site.bound.surf_west[nx][ny] = try parseTokenToFloat(f32, error.InvalidSurfBoundCondWest, tokens.items[3], err_log);
            // Read sub-surface boundary conditions for sub-surface lateral flux simulations through N, E, S, and W boundary
            site.bound.sub_surf_north[nx][ny] = try parseTokenToFloat(f32, error.InvalidSubSurfBoundCondNorth, tokens.items[4], err_log);
            site.bound.sub_surf_east[nx][ny] = try parseTokenToFloat(f32, error.InvalidSubSurfBoundCondEast, tokens.items[5], err_log);
            site.bound.sub_surf_south[nx][ny] = try parseTokenToFloat(f32, error.InvalidSubSurfBoundCondSouth, tokens.items[6], err_log);
            site.bound.sub_surf_west[nx][ny] = try parseTokenToFloat(f32, error.InvalidSubSurfBoundCondWest, tokens.items[7], err_log);
            // Read lateral distance to external water table (natural or artificial) to the N, E, S, and W
            site.bound.dist_wtdx_north[nx][ny] = try parseTokenToFloat(f32, error.InvalidDistToExternalWTNorth, tokens.items[8], err_log);
            site.bound.dist_wtdx_east[nx][ny] = try parseTokenToFloat(f32, error.InvalidDistToExternalWTEast, tokens.items[9], err_log);
            site.bound.dist_wtdx_south[nx][ny] = try parseTokenToFloat(f32, error.InvalidDistToExternalWTSouth, tokens.items[10], err_log);
            site.bound.dist_wtdx_west[nx][ny] = try parseTokenToFloat(f32, error.InvalidDistToExternalWTWest, tokens.items[11], err_log);
            // Read lower boundary conditions for water flux simulations through lower boundary
            site.bound.bottom_drain[nx][ny] = try parseTokenToFloat(f32, error.InvalidLowerBoundCond, tokens.items[12], err_log);
            try site_log.print("=> {s} line#4 inputs for model boundary conditions: grid cell position W-E: {}, N-S: {}, multiplier for surface run-off/run-on simulation through N: {d}, E: {d}, S: {d}, and W: {d} boundary. Multiplier for sub-surface discharge/recharge simulation through N: {d}, E: {d}, S: {d}, and W: {d} boundary. Lateral distance to external WT (natural or artificial) to the N: {d} m, E: {d} m, S: {d} m, and W: {d} m direction. Multiplier for water flux simulation (e.g. deep percolation, capillary-rise) through lower boundary: {d}.\n", .{ land_unit_name, nx + offset, ny + offset, site.bound.surf_north[nx][ny], site.bound.surf_east[nx][ny], site.bound.surf_south[nx][ny], site.bound.surf_west[nx][ny], site.bound.sub_surf_north[nx][ny], site.bound.sub_surf_east[nx][ny], site.bound.sub_surf_south[nx][ny], site.bound.sub_surf_west[nx][ny], site.bound.dist_wtdx_north[nx][ny], site.bound.dist_wtdx_east[nx][ny], site.bound.dist_wtdx_south[nx][ny], site.bound.dist_wtdx_west[nx][ny], site.bound.bottom_drain[nx][ny] });
            try site_log.flush();
            tokens.deinit(allocator);
        }
    }
}
///This function reads grid deminsions.
fn readGridDimension(allocator: std.mem.Allocator, land_unit_buf: *std.Io.Reader, err_log: *std.Io.Writer, site_log: *std.Io.Writer, site: *Site, land_unit_name: []const u8, start_grid_west_east: usize, start_grid_north_south: usize, end_grid_west_east: usize, end_grid_north_south: usize) !void {
    const line = try land_unit_buf.takeDelimiterExclusive('\n');
    var tokens = try tokenizeLine(line, allocator);
    try checkTokenInLine(error.InvalidInputLandscapeFileLine5, tokens.items.len, 2, err_log);
    for (start_grid_west_east..end_grid_west_east) |nx| {
        for (start_grid_north_south..end_grid_north_south) |ny| {
            // Read width of the W-E landscape (m)
            site.grid_dim.west_east[nx][ny] = try parseTokenToFloat(f32, error.InvalidGridWidthInLandscapeFile_WE, tokens.items[0], err_log);
            // Read width of the N-S landscape (m)
            site.grid_dim.north_south[nx][ny] = try parseTokenToFloat(f32, error.InvalidGridWidthInLandscapeFile_NS, tokens.items[1], err_log);
            try site_log.print("=> {s} line#5 inputs for grid cell size: grid cell position W-E: {}, N-S: {}, W-E dimension: {d} m, N-S dimension: {d} m. [End of {s} file.]\n", .{ land_unit_name, nx + offset, ny + offset, site.grid_dim.west_east[nx][ny], site.grid_dim.north_south[nx][ny], land_unit_name });
            try site_log.flush();
        }
    }
    tokens.deinit(allocator);
}
