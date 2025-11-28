///This module contains all structs and methods that help in loading landscape unit data within the landscape unit file under a site file
const std = @import("std");
const config = @import("config");
const input_parser = @import("../util/input_parser.zig");
const utils = @import("../util/utils.zig");
const nwe: usize = config.nwex;
const nns: usize = config.nnsx;
const Tokens = input_parser.Tokens;
const FileReader = utils.FileReader;
const IoFiles = @import("iofiles.zig").IoFiles;

///Landscape unit location
const Location = struct {
    lat: [nwe][nns]f32 = undefined, //latitude (deg)
    alt_init: [nwe][nns]f32 = undefined, //altitude or elevation (m)
    asp: [nwe][nns]f32 = undefined, //aspect of the surface (⁰)
    surf_slop: [nwe][nns]f32 = undefined, //slope of the surface (⁰)
    snowpack_init: [nwe][nns]f32 = undefined, //depth of initial snowpack (m)
    matc_init: [nwe][nns]f32 = undefined, //Mean Annual Temperature (⁰C)
    wt_opt: [nwe][nns]usize = undefined,
    wt_opt_desc: [5][]const u8 = .{ "no", "yes, natural, stationary", "yes, natural, mobile", "yes, artificial, stationary", "yes, artificial, mobile" },
    max_daylength: [nwe][nns]f32 = undefined, //max. day length (h)
    //
    ///This method loads landscape unit location inputs
    fn loadLocation(self: *Location, land_unit_name: []const u8, line: []const u8, err_log: *std.Io.Writer, we: usize, ns: usize) !void {
        var tokens = Tokens{};
        try tokens.tokenizeLine(line);
        if (tokens.len != 7) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while loading landscape unit location in {s}\n", .{ @errorName(err), land_unit_name });
            std.debug.print("\x1b[1;31merror: {s} while loading landscape unit location in {s}\x1b[0m\n", .{ @errorName(err), land_unit_name });
            return err;
        }
        const fields = [_]*[nwe][nns]f32{ &self.lat, &self.alt_init, &self.asp, &self.surf_slop, &self.snowpack_init, &self.matc_init };
        for (tokens.items[0..fields.len], 0..) |tok, i| {
            fields[i][we][ns] = std.fmt.parseFloat(f32, tok) catch |err| {
                try err_log.print("error: {s} while parsing land unit location in {s}\n", .{ @errorName(err), land_unit_name });
                std.debug.print("\x1b[1;31merror: {s} while parsing land unit location in {s}\x1b[0m\n", .{ @errorName(err), land_unit_name });
                return err;
            };
        }
        self.wt_opt[we][ns] = std.fmt.parseInt(usize, tokens.items[tokens.len - 1], 10) catch |err| {
            try err_log.print("error: {s} while parsing water table option in {s}\n", .{ @errorName(err), land_unit_name });
            std.debug.print("\x1b[1;31merror: {s} while parsing water table option in {s}\x1b[0m\n", .{ @errorName(err), land_unit_name });
            return err;
        };
        if (self.wt_opt[we][ns] >= self.wt_opt_desc.len) {
            const err = error.InvalidOption;
            try err_log.print("error: {s} while loading water table option in {s}\n", .{ @errorName(err), land_unit_name });
            std.debug.print("\x1b[1;31merror: {s} while loading water table option in {s}\x1b[0m\n", .{ @errorName(err), land_unit_name });
            return err;
        }
        //Calculate maximum daylength hour for plant phenology
        const doy_max_daylen: usize = if (self.lat[we][ns] > 0.0) 173 else 356;
        self.max_daylength[we][ns] = self.daylengthHours(doy_max_daylen, we, ns);
    }
    ///This function returns daylength (hours) for a site location and day of year (doy)
    pub fn daylengthHours(self: *Location, doy: usize, we: usize, ns: usize) f32 {
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
    fn solarDeclination(doy: usize) f32 {
        const n = @as(f32, @floatFromInt(doy));
        const gamma = 2.0 * std.math.pi * (n - 1.0) / 365.0;
        return 0.006918 - 0.399912 * @cos(gamma) + 0.070257 * @sin(gamma) - 0.006758 * @cos(2.0 * gamma) + 0.000907 * @sin(2.0 * gamma) - 0.002697 * @cos(3.0 * gamma) + 0.001480 * @sin(3.0 * gamma);
    }
};
///Landscape unit's atmospheric gas concentrations
const AtmGas = struct {
    o2conc: [nwe][nns]f32 = undefined, //O₂ conc. (ppm)
    n2conc: [nwe][nns]f32 = undefined, //N₂ conc. (ppm)
    co2conc_init: [nwe][nns]f32 = undefined, //initial CO₂ conc. (ppm)
    co2conc: [nwe][nns]f32 = undefined, //ambient CO₂ conc. (ppm)
    ch4conc: [nwe][nns]f32 = undefined, //CH₄ conc. (ppm)
    n2oconc: [nwe][nns]f32 = undefined, //N₂O conc. (ppm)
    nh3conc: [nwe][nns]f32 = undefined, //NH₃ conc. (ppm)
    h2conc: [nwe][nns]f32 = undefined, //H₂ conc. (ppm)

    ///This method loads atmospheric gas conc. data
    fn loadAtmGas(self: *AtmGas, land_unit_name: []const u8, line: []const u8, err_log: *std.Io.Writer, we: usize, ns: usize) !void {
        var tokens = Tokens{};
        try tokens.tokenizeLine(line);
        if (tokens.len != 6) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while loading atmospheric gas concentrations in {s}\n", .{ @errorName(err), land_unit_name });
            std.debug.print("\x1b[1;31merror: {s} while loading atmospheric gas concentrations in {s}\x1b[0m\n", .{ @errorName(err), land_unit_name });
            return err;
        }
        const fields = [_]*[nwe][nns]f32{ &self.o2conc, &self.n2conc, &self.co2conc_init, &self.ch4conc, &self.n2oconc, &self.nh3conc };
        for (tokens.items[0..fields.len], 0..) |tok, i| {
            fields[i][we][ns] = std.fmt.parseFloat(f32, tok) catch |err| {
                try err_log.print("error: {s} while parsing atmospheric gas concentrations in {s}\n", .{ @errorName(err), land_unit_name });
                std.debug.print("\x1b[1;31merror: {s} while parsing atmospheric gas concentrations in {s}\x1b[0m\n", .{ @errorName(err), land_unit_name });
                return err;
            };
        }
        self.co2conc[we][ns] = self.co2conc_init[we][ns];
        self.h2conc[we][ns] = 1e-3;
    }
};
///Landscape unit's various options (e.g., koppen climate zone, salinity, erosion, grid connectivity, wtdx etc.)
const LandUnitOptions = struct {
    koppen_clim_zone: [nwe][nns]usize = undefined, //Koppen climate zone
    salinity_opt: [nwe][nns]usize = undefined, //slainity simulation option
    salinity_opt_desc: [2][]const u8 = .{ "do not simulate salinity", "simulate salinity" },
    erosion_opt: [nwe][nns]usize = undefined, //erosion simulation option
    erosion_opt_desc: [5][]const u8 = .{ "no change in elevation", "allow freeze-thaw to change elevation", "allow freeze-thaw + erosion to change elevation", "allow freeze-thaw + soc accumulation to change elevation", "allow freeze-thaw + soc accumulation + erosion to change elevation" },
    grid_conn_opt: [nwe][nns]usize = undefined, //grid lateral connectivity option
    grid_conn_opt_desc: [2][]const u8 = .{ "no lateral connection/flux simulation", "lateral connections between grid cells (and hence lateral flux simulations)" },
    nat_wtdx_init: [nwe][nns]f32 = undefined, //natural external water table depth (m) relative to grid surface
    art_wtdx_init: [nwe][nns]f32 = undefined, //depth of artificial drainage (m) relative to grid surface
    nat_wtx_slope: [nwe][nns]f32 = undefined, //natural external water table slope (m) relative to grid surface

    ///This method loads various landscape unit's options data
    fn loadLandUnitOption(self: *LandUnitOptions, land_unit_name: []const u8, line: []const u8, err_log: *std.Io.Writer, we: usize, ns: usize) !void {
        var tokens = Tokens{};
        try tokens.tokenizeLine(line);
        if (tokens.len != 7) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while loading landscape unit options in {s}\n", .{ @errorName(err), land_unit_name });
            std.debug.print("\x1b[1;31merror: {s} while loading landscape unit options in {s}\x1b[0m\n", .{ @errorName(err), land_unit_name });
            return err;
        }
        const fields_int = [_]*[nwe][nns]usize{ &self.koppen_clim_zone, &self.erosion_opt, &self.salinity_opt, &self.grid_conn_opt };
        const fields_float = [_]*[nwe][nns]f32{ &self.nat_wtdx_init, &self.art_wtdx_init, &self.nat_wtx_slope };
        for (tokens.items[0..fields_int.len], 0..) |tok, i| {
            fields_int[i][we][ns] = std.fmt.parseInt(usize, tok, 10) catch |err| {
                try err_log.print("error: {s} while parsing landscape unit options in {s}\n", .{ @errorName(err), land_unit_name });
                std.debug.print("\x1b[1;31merror: {s} while parsing landscape unit options in {s}\x1b[0m\n", .{ @errorName(err), land_unit_name });
                return err;
            };
        }
        for (tokens.items[fields_int.len .. fields_float.len + fields_int.len], 0..) |tok, i| {
            fields_float[i][we][ns] = std.fmt.parseFloat(f32, tok) catch |err| {
                try err_log.print("error: {s} while parsing landscape unit options in {s}\n", .{ @errorName(err), land_unit_name });
                std.debug.print("\x1b[1;31merror: {s} while parsing landscape unit options in {s}\x1b[0m\n", .{ @errorName(err), land_unit_name });
                return err;
            };
        }
        if (self.salinity_opt[we][ns] >= self.salinity_opt_desc.len) {
            const err = error.InvalidOption;
            try err_log.print("error: {s} while loading salinity option in {s}\n", .{ @errorName(err), land_unit_name });
            std.debug.print("\x1b[1;31merror: {s} while loading salinity option in {s}\x1b[0m\n", .{ @errorName(err), land_unit_name });
            return err;
        }
        if (self.erosion_opt[we][ns] >= self.erosion_opt_desc.len) {
            const err = error.InvalidOption;
            try err_log.print("error: {s} while loading erosion option in {s}\n", .{ @errorName(err), land_unit_name });
            std.debug.print("\x1b[1;31merror: {s} while loading erosion option in {s}\x1b[0m\n", .{ @errorName(err), land_unit_name });
            return err;
        }
        if (self.grid_conn_opt[we][ns] >= self.grid_conn_opt_desc.len) {
            const err = error.InvalidOption;
            try err_log.print("error: {s} while loading grid connectivity option in {s}\n", .{ @errorName(err), land_unit_name });
            std.debug.print("\x1b[1;31merror: {s} while loading grid connectivity option in {s}\x1b[0m\n", .{ @errorName(err), land_unit_name });
            return err;
        }
    }
};
///Boundary conditions for surface run-off/run-on
const SurfBounds = struct {
    west: [nwe][nns]f32 = undefined,
    north: [nwe][nns]f32 = undefined,
    east: [nwe][nns]f32 = undefined,
    south: [nwe][nns]f32 = undefined,
};
///Boundary conditions for sub-surface lateral discharge/recharge
const SubSurfBounds = struct {
    west: [nwe][nns]f32 = undefined,
    north: [nwe][nns]f32 = undefined,
    east: [nwe][nns]f32 = undefined,
    south: [nwe][nns]f32 = undefined,
};
///Distances (m) to external water table
const DistToWtdx = struct {
    west: [nwe][nns]f32 = undefined,
    north: [nwe][nns]f32 = undefined,
    east: [nwe][nns]f32 = undefined,
    south: [nwe][nns]f32 = undefined,
};
///Landscape unit's boundary conditions
const BoundaryCondition = struct {
    surf: SurfBounds = SurfBounds{},
    sub_surf: SubSurfBounds = SubSurfBounds{},
    dist_to_wtdx: DistToWtdx = DistToWtdx{},
    bottom_drain: [nwe][nns]f32 = undefined, //lower boundary condition for water flow

    ///This method loads landscape unit's boundary conditions data
    fn loadBoundaryCondition(self: *BoundaryCondition, land_unit_name: []const u8, line: []const u8, err_log: *std.Io.Writer, we: usize, ns: usize) !void {
        var tokens = Tokens{};
        try tokens.tokenizeLine(line);
        if (tokens.len != 13) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while loading boundary conditions in {s}\n", .{ @errorName(err), land_unit_name });
            std.debug.print("\x1b[1;31merror: {s} while loading boundary conditions in {s}\x1b[0m\n", .{ @errorName(err), land_unit_name });
            return err;
        }
        const fields = [_]*[nwe][nns]f32{ &self.surf.west, &self.surf.north, &self.surf.east, &self.surf.south, &self.sub_surf.west, &self.sub_surf.north, &self.sub_surf.east, &self.sub_surf.south, &self.dist_to_wtdx.west, &self.dist_to_wtdx.north, &self.dist_to_wtdx.east, &self.dist_to_wtdx.south, &self.bottom_drain };
        for (tokens.items[0..fields.len], 0..) |tok, i| {
            fields[i][we][ns] = std.fmt.parseFloat(f32, tok) catch |err| {
                try err_log.print("error: {s} while parsing boundary conditions in {s}\n", .{ @errorName(err), land_unit_name });
                std.debug.print("\x1b[1;31merror: {s} while parsing boundary conditions in {s}\x1b[0m\n", .{ @errorName(err), land_unit_name });
                return err;
            };
        }
    }
};
///Landscape unit's grid dimensions
const GridDimension = struct {
    west_east: [nwe][nns]f32 = undefined, //west to east dimension (m)
    north_south: [nwe][nns]f32 = undefined, //north to south dimension (m)

    ///This method loads landscape unit's grid dimension data
    fn loadGridDims(self: *GridDimension, land_unit_name: []const u8, line: []const u8, err_log: *std.Io.Writer, we: usize, ns: usize) !void {
        var tokens = Tokens{};
        try tokens.tokenizeLine(line);
        if (tokens.len != 2) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while loading grid dimensions in {s}\n", .{ @errorName(err), land_unit_name });
            std.debug.print("\x1b[1;31merror: {s} while loading grid dimensions in {s}\x1b[0m\n", .{ @errorName(err), land_unit_name });
            return err;
        }
        const fields = [_]*[nwe][nns]f32{ &self.west_east, &self.north_south };
        for (tokens.items[0..fields.len], 0..) |tok, i| {
            fields[i][we][ns] = std.fmt.parseFloat(f32, tok) catch |err| {
                try err_log.print("error: {s} while parsing grid dimensions in {s}\n", .{ @errorName(err), land_unit_name });
                std.debug.print("\x1b[1;31merror: {s} while parsing grid dimensions in {s}\x1b[0m\n", .{ @errorName(err), land_unit_name });
                return err;
            };
        }
    }
};
///All landscape unit data
pub const LandUnit = struct {
    loc: Location = Location{},
    atm_gas: AtmGas = AtmGas{},
    opts: LandUnitOptions = LandUnitOptions{},
    bounds: BoundaryCondition = BoundaryCondition{},
    grid_dim: GridDimension = GridDimension{},
    file_reader: FileReader = FileReader{},
    ///This method loads all landscape unit file data
    pub fn loadLandUnitData(self: *LandUnit, io_files: *const IoFiles, err_log: *std.Io.Writer) !void {
        for (io_files.grid_num.west..io_files.grid_num.east) |we| {
            for (io_files.grid_num.north..io_files.grid_num.south) |ns| {
                const land_unit_name = io_files.site_file.land_unit.name[we][ns][0..io_files.site_file.land_unit.len[we][ns]];
                try self.file_reader.open(err_log, land_unit_name);
                defer self.file_reader.close();
                self.file_reader.reader();
                var line = try self.file_reader.buf_reader.takeDelimiterInclusive('\n');
                try self.loc.loadLocation(land_unit_name, line, err_log, we, ns);
                line = try self.file_reader.buf_reader.takeDelimiterInclusive('\n');
                try self.atm_gas.loadAtmGas(land_unit_name, line, err_log, we, ns);
                line = try self.file_reader.buf_reader.takeDelimiterInclusive('\n');
                try self.opts.loadLandUnitOption(land_unit_name, line, err_log, we, ns);
                line = try self.file_reader.buf_reader.takeDelimiterInclusive('\n');
                try self.bounds.loadBoundaryCondition(land_unit_name, line, err_log, we, ns);
                line = try self.file_reader.buf_reader.takeDelimiterInclusive('\n');
                try self.grid_dim.loadGridDims(land_unit_name, line, err_log, we, ns);
            }
        }
    }
};
