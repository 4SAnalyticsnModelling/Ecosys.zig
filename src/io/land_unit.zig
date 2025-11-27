const std = @import("std");
const config = @import("config");
const input_parser = @import("../util/input_parser.zig");
const utils = @import("../util/utils.zig");
const nwe: usize = config.nwex;
const nns: usize = config.nnsx;
const Tokens = input_parser.Tokens;
const FileReader = utils.FileReader;
const IoFiles = @import("iofiles.zig").IoFiles;

///This struct defines site variables.
pub const Site = struct {
    loc: Location,
    atm_gas: AtmGas,
    opt: SiteOptions,
    bound: Boundary,
    grid_dim: GridDimension,

    pub fn init() Site {
        return std.mem.zeroInit(Site, .{});
    }
};
///Landscape unit location.
const Location = struct {
    lat: [nwe][nns]f32, //latitude (deg)
    alt_init: [nwe][nns]f32, //altitude or elevation (m)
    matc_init: [nwe][nns]f32, //Mean Annual Temperature (⁰C)
    wt_opt: [nwe][nns]u32, //water table simulation option; 0 = none; 1,2 = natural stationary, mobile; 3,4 = artificial stationary, mobile
    max_daylength: [nwe][nns]f32, //max. day length (h)
    wt_opt_desc: [5][]const u8 = .{ "no", "yes, natural, stationary", "yes, natural, mobile", "yes, artificial, stationary", "yes, artificial, mobile" }, //description of various wt_opt
    tokens: Tokens = Tokens{},

    ///This method loads landscape unit location inputs
    fn loadLocation(self: *Location, land_unit_name: []const u8, reader: *std.Io.Reader, io_files: *IoFiles, err_log: *std.Io.Writer) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        try self.tokens.tokenizeLine(line);
        if (self.tokens.len != 4) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while reading landscape unit location in {s}\n", .{ @errorName(err), land_unit_name });
            std.debug.print("\x1b[1;31merror: {s} while reading landscape unit location in {s}\x1b[0m\n", .{ @errorName(err), land_unit_name });
            return err;
        }
        for (io_files.grid_num.west..io_files.grid_num.east) |we| {
            for (io_files.grid_num.north..io_files.grid_num.south) |ns| {
                const fields = [_]*[nwe][nns]f32{ &self.lat, &self.alt_init, &self.matc_init };
                for (self.tokens.items[0..fields.len], 0..) |tok, i| {
                    fields[i][we][ns] = std.fmt.parseFloat(f32, tok) catch |err| {
                        try err_log.print("error: {s} while parsing land unit location in {s}\n", .{ @errorName(err), land_unit_name });
                        std.debug.print("\x1b[1;31merror: {s} while parsing land unit location in {s}\x1b[0m\n", .{ @errorName(err), land_unit_name });
                        return err;
                    };
                }
                self.wt_opt[we][ns] = std.fmt.parseInt(u32, self.tokens.items[3], 10) catch |err| {
                    try err_log.print("error: {s} while parsing water table option in {s}\n", .{ @errorName(err), land_unit_name });
                    std.debug.print("\x1b[1;31merror: {s} while parsing water table option in {s}\x1b[0m\n", .{ @errorName(err), land_unit_name });
                    return err;
                };
                if (self.wt_opt[we][ns] > 4) {
                    const err = error.InvalidOption;
                    try err_log.print("error: {s} while loading water table option in {s}\n", .{ @errorName(err), land_unit_name });
                    std.debug.print("\x1b[1;31merror: {s} while loading water table option in {s}\x1b[0m\n", .{ @errorName(err), land_unit_name });
                    return err;
                }
                //Calculate maximum daylength hour for plant phenology
                const doy_max = if (self.lat[we][ns] > 0.0) 173 else 356;
                self.max_daylength[we][ns] = self.daylengthHours(doy_max, we, ns);
            }
        }
    }
    ///This function returns daylength (hours) for a site location and day of year (doy)
    pub fn daylengthHours(self: *Location, doy: u32, we: usize, ns: usize) f32 {
        const lat_rad = deg2rad(self.lat[we][ns]);
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
    ///This function converts angle units
    fn deg2rad(deg: f32) f32 {
        return deg * std.math.pi / 180.0;
    }
    ///This function calculates solar declination (radians) using Spencer (1971) approximation
    fn solarDeclination(doy: u32) f32 {
        const n = @as(f32, @floatFromInt(doy));
        const gamma = 2.0 * std.math.pi * (n - 1.0) / 365.0;
        return 0.006918 - 0.399912 * @cos(gamma) + 0.070257 * @sin(gamma) - 0.006758 * @cos(2.0 * gamma) + 0.000907 * @sin(2.0 * gamma) - 0.002697 * @cos(3.0 * gamma) + 0.001480 * @sin(3.0 * gamma);
    }
};
///This struct defines various site options (e.g., koppen climate zone, salinity, erosion, grid connectivity, wtdx etc.).
const SiteOptions = struct {
    koppen_clim_zone: [nwe][nns]u32, // Koppen climate zone
    salinity_opt: [nwe][nns]u32, // slainity simulation option
    erosion_opt: [nwe][nns]i32, // erosion simulation option
    grid_conn_opt: [nwe][nns]u32, // grid lateral connectivity option
    nat_wtdx_init: [nwe][nns]f32, // natural external water table depth (m) relative to grid surface
    art_wtdx_init: [nwe][nns]f32, // depth of artificial drainage (m) relative to grid surface
    nat_wtx_slope: [nwe][nns]f32, // natural external water table slope (m) relative to grid surface
};
///This struct defines model site atmospheric gas concentrations.
const AtmGas = struct {
    o2conc: [nwe][nns]f32, // O₂ conc. (ppm)
    n2conc: [nwe][nns]f32, // N₂ conc. (ppm)
    co2conc_init: [nwe][nns]f32, // initial CO₂ conc. (ppm)
    co2conc: [nwe][nns]f32, // ambient CO₂ conc. (ppm)
    ch4conc: [nwe][nns]f32, // CH₄ conc. (ppm)
    n2oconc: [nwe][nns]f32, // N₂O conc. (ppm)
    nh3conc: [nwe][nns]f32, // NH₃ conc. (ppm)
    h2conc: [nwe][nns]f32, // H₂ conc. (ppm)
};
///This struct defines model boundary conditions and grid size.
const Boundary = struct {
    surf_north: [nwe][nns]f32, // N boundary condition for surface run-off/run-on
    surf_east: [nwe][nns]f32, // E boundary condition for surface run-off/run-on
    surf_south: [nwe][nns]f32, // S boundary condition for surface run-off/run-on
    surf_west: [nwe][nns]f32, // W boundary condition for surface run-off/run-on
    sub_surf_north: [nwe][nns]f32, // N boundary condition for sub-surface lateral discharge/recharge
    sub_surf_east: [nwe][nns]f32, // E boundary condition for sub-surface lateral discharge/recharge
    sub_surf_south: [nwe][nns]f32, // S boundary condition for sub-surface lateral discharge/recharge
    sub_surf_west: [nwe][nns]f32, // W boundary condition for sub-surface lateral discharge/recharge
    dist_wtdx_north: [nwe][nns]f32, // distance to external water table (m) to the N
    dist_wtdx_east: [nwe][nns]f32, // distance to external water table (m) to the E
    dist_wtdx_south: [nwe][nns]f32, // distance to external water table (m) to the S
    dist_wtdx_west: [nwe][nns]f32, // distance to external water table (m) to the W
    bottom_drain: [nwe][nns]f32, // lower boundary condition for water flow
};
///This struct defines model grid dimensions.
const GridDimension = struct {
    west_east: [nwe][nns]f32, // west to east dimension (m)
    north_south: [nwe][nns]f32, // north to south dimension (m)
};
