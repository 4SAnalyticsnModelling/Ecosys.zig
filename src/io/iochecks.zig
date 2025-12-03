///This module contains struct and methods that help writing out all model inputs with description and units (both files and data) to check if all inputs are appropriate
const std = @import("std");
const config = @import("config");
const utils = @import("../util/utils.zig");
const print = std.debug.print;
const max_path_len = config.filepathx;
const max_path_len_safe = max_path_len + 40; //the additional 40 bytes is safety net for parent directory names e.g. outputs/input_chk
const IoFiles = @import("iofiles.zig").IoFiles;
const LandUnit = @import("land_unit.zig").LandUnit;
const RunArg = @import("../util/input_parser.zig").RunArg;
const OutDir = utils.OutDir;
const FileReader = utils.FileReader;
const FileWriter = utils.FileWriter;
const LandUnitDataDesc = @import("iodata_desc.zig").LandUnitDataDesc;
const IoFileNameDesc = @import("iodata_desc.zig").IoFileNameDesc;
const io_file_name_desc = IoFileNameDesc{};
const land_unit_data_desc = LandUnitDataDesc{};

///Writes out description of I/O file names
pub const IoFileNameChk = struct {
    path_buf: [max_path_len_safe]u8 = undefined,
    file_name: []const u8 = undefined,
    file_writer: FileWriter = FileWriter{},
    line_count: usize = 0,

    ///Build I/O file names' check file name/path
    fn buildCheckFilePath(self: *IoFileNameChk, runfile_name: []const u8, outdir: *const OutDir) !void {
        const basename = std.fs.path.basename(runfile_name);
        const ext = std.fs.path.extension(basename);
        self.file_name = basename[0 .. basename.len - ext.len];
        self.file_name = try std.fmt.bufPrint(&self.path_buf, "{s}/{s}.txt", .{ outdir.input_chk, self.file_name });
    }
    ///Write I/O file names or other input data in runfile/runscript with descriptions
    fn writeGlobalParams(self: *IoFileNameChk, io_files: *const IoFiles) !void {
        try self.file_writer.buf_writer.print(io_file_name_desc.global_params, .{ self.line_count, io_files.grid_num.west, io_files.grid_num.north, io_files.grid_num.east, io_files.grid_num.south, self.line_count + 1, io_files.site_file.site.name[0..io_files.site_file.site.len], self.line_count + 2, io_files.start_yr, self.line_count + 3, io_files.scenario.num, io_files.scenario.repeat });
        self.line_count = 4;
    }
    ///Write scenario level data in runfile/runscript with descriptions
    fn writeScenarioParams(self: *IoFileNameChk, io_files: *const IoFiles, scenario: usize) !void {
        try self.file_writer.buf_writer.print(io_file_name_desc.scenario_params, .{ self.line_count, io_files.scene.num[scenario], io_files.scene.repeat[scenario] });
    }
    ///Write scene I/O file names in runfile/runscript with descriptions
    fn writeSceneFileNames(self: *IoFileNameChk, io_files: *const IoFiles, scenario: usize, scene: usize) !void {
        const wthr_net_file = io_files.wthr_file.wthr_net.name[scenario][scene][0..io_files.wthr_file.wthr_net.len[scenario][scene]];
        const opts_file = io_files.opt_file.name[scenario][scene][0..io_files.opt_file.len[scenario][scene]];
        const soil_mgmt_file = io_files.soil_mgmt_file.soil_mgmt.name[scenario][scene][0..io_files.soil_mgmt_file.soil_mgmt.len[scenario][scene]];
        const plant_mgmt_file = io_files.plant_mgmt_file.plant_mgmt.name[scenario][scene][0..io_files.plant_mgmt_file.plant_mgmt.len[scenario][scene]];
        const hrly_c_file = io_files.hourly_out_file.carbon.name[scenario][scene][0..io_files.hourly_out_file.carbon.len[scenario][scene]];
        const hrly_wtr_file = io_files.hourly_out_file.water.name[scenario][scene][0..io_files.hourly_out_file.water.len[scenario][scene]];
        const hrly_n_file = io_files.hourly_out_file.nitrogen.name[scenario][scene][0..io_files.hourly_out_file.nitrogen.len[scenario][scene]];
        const hrly_p_file = io_files.hourly_out_file.phosphorus.name[scenario][scene][0..io_files.hourly_out_file.phosphorus.len[scenario][scene]];
        const hrly_heat_file = io_files.hourly_out_file.heat.name[scenario][scene][0..io_files.hourly_out_file.heat.len[scenario][scene]];
        const daily_c_file = io_files.daily_out_file.carbon.name[scenario][scene][0..io_files.daily_out_file.carbon.len[scenario][scene]];
        const daily_wtr_file = io_files.daily_out_file.water.name[scenario][scene][0..io_files.daily_out_file.water.len[scenario][scene]];
        const daily_n_file = io_files.daily_out_file.nitrogen.name[scenario][scene][0..io_files.daily_out_file.nitrogen.len[scenario][scene]];
        const daily_p_file = io_files.daily_out_file.phosphorus.name[scenario][scene][0..io_files.daily_out_file.phosphorus.len[scenario][scene]];
        const daily_heat_file = io_files.daily_out_file.heat.name[scenario][scene][0..io_files.daily_out_file.heat.len[scenario][scene]];
        try self.file_writer.buf_writer.print(io_file_name_desc.scene_params, .{ self.line_count, wthr_net_file, self.line_count + 1, opts_file, self.line_count + 2, soil_mgmt_file, self.line_count + 3, plant_mgmt_file, self.line_count + 4, hrly_c_file, self.line_count + 5, hrly_wtr_file, self.line_count + 6, hrly_n_file, self.line_count + 7, hrly_p_file, self.line_count + 8, hrly_heat_file, self.line_count + 9, daily_c_file, self.line_count + 10, daily_wtr_file, self.line_count + 11, daily_n_file, self.line_count + 12, daily_p_file, self.line_count + 13, daily_heat_file });
    }
    ///Write all parent I/O file names within the runfile/runscript into the relevant input check file
    pub fn writeCheckFile(self: *IoFileNameChk, io_files: *const IoFiles, outdir: *const OutDir, runfile_name: []const u8) !void {
        try self.buildCheckFilePath(runfile_name, outdir);
        try self.file_writer.create(self.file_name);
        defer self.file_writer.close();
        self.file_writer.writer();
        try self.writeGlobalParams(io_files);
        for (0..io_files.scenario.num) |scenario| {
            try self.writeScenarioParams(io_files, scenario);
            self.line_count += 1;
            for (0..io_files.scene.num[scenario]) |scene| {
                try self.writeSceneFileNames(io_files, scenario, scene);
                self.line_count += 14;
            }
        }
        try self.file_writer.buf_writer.flush();
    }
};
///Option error set
const OptsErrors = error{
    InvalidOption,
    PrintFailed,
};
///Water table options
const WtOpts = enum {
    no_water_table,
    yes_natural_stationary,
    yes_natural_mobile,
    yes_artificial_stationary,
    yes_artificial_mobile,
};
pub const WtMode = union(WtOpts) {
    no_water_table,
    yes_natural_stationary,
    yes_natural_mobile,
    yes_artificial_stationary,
    yes_artificial_mobile,

    fn wtModeFromInt(val: usize, file_name: []const u8, err_log: *std.Io.Writer) OptsErrors![]const u8 {
        return switch (val) {
            @intFromEnum(WtMode.no_water_table) => "no water table simulation",
            @intFromEnum(WtMode.yes_natural_stationary) => "yes, natural, stationary",
            @intFromEnum(WtMode.yes_natural_mobile) => "yes, natural, mobile",
            @intFromEnum(WtMode.yes_artificial_stationary) => "yes, artificial, stationary",
            @intFromEnum(WtMode.yes_artificial_mobile) => "yes, artificial, mobile",
            else => {
                const err = error.InvalidOption;
                err_log.print("error: {s} in reading water table option {d} in {s}. Allowed water table options are: 0=no water table simulation, 1=yes, natural, stationary, 2=yes, natural, mobile, 3=yes, artificial, stationary, and 4=yes, artificial, mobile\n", .{ @errorName(err), val, file_name }) catch {
                    return error.PrintFailed;
                };
                defer err_log.flush() catch {};
                print("\x1b[1;31merror:\x1b[0m {s} in reading water table option {d} in {s}. Allowed water table options are: 0=no water table simulation, 1=yes, natural, stationary, 2=yes, natural, mobile, 3=yes, artificial, stationary, and 4=yes, artificial, mobile\n", .{ @errorName(err), val, file_name });
                return err;
            },
        };
    }
};
test "water table simulation options" {
    var buf: [1024]u8 = undefined;
    var err_log = std.Io.Writer.fixed(&buf);
    const wt_opt_0 = try WtMode.wtModeFromInt(0, "land unit", &err_log);
    try std.testing.expect(std.mem.containsAtLeast(u8, wt_opt_0, 1, "no water table simulation"));
    const wt_opt_4 = try WtMode.wtModeFromInt(4, "land unit", &err_log);
    try std.testing.expect(std.mem.containsAtLeast(u8, wt_opt_4, 1, "yes, artificial, mobile"));
    try std.testing.expectError(error.InvalidOption, WtMode.wtModeFromInt(7, "land unit", &err_log));
    try std.testing.expect(std.mem.containsAtLeast(u8, err_log.buffered(), 1, "InvalidOption in reading water table option 7"));
}
///Salinity simulation options
const SalinityOpts = enum {
    no_salinity_simulation,
    simulate_salinity,
};
pub const SalinityMode = union(SalinityOpts) {
    no_salinity_simulation,
    simulate_salinity,

    fn salinityModeFromInt(val: usize, file_name: []const u8, err_log: *std.Io.Writer) OptsErrors![]const u8 {
        return switch (val) {
            @intFromEnum(SalinityMode.no_salinity_simulation) => "no salinity simulation",
            @intFromEnum(SalinityMode.simulate_salinity) => "simulate salinity",
            else => {
                const err = error.InvalidOption;
                err_log.print("error: {s} in reading salinity simulation option {d} in {s}. Allowed salinity simulation options are: 0=no salinity simulation, and 1=simulate salinity\n", .{ @errorName(err), val, file_name }) catch {
                    return error.PrintFailed;
                };
                defer err_log.flush() catch {};
                print("\x1b[1;31merror:\x1b[0m {s} in reading salinity simulation option {d} in {s}. Allowed salinity simulation options are: 0=no salinity simulation, and 1=simulate salinity\n", .{ @errorName(err), val, file_name });
                return err;
            },
        };
    }
};
///Surface elevation change simulation options
const SurfElevChangeOpts = enum {
    no_change_in_elevation,
    freeze_thaw_changes_elevation,
    freeze_thaw_and_erosion_change_elevation,
    freeze_thaw_and_soc_change_elevation,
    freeze_thaw_soc_and_erosion_change_elevation,
};
pub const SurfElevChangeMode = union(SurfElevChangeOpts) {
    no_change_in_elevation,
    freeze_thaw_changes_elevation,
    freeze_thaw_and_erosion_change_elevation,
    freeze_thaw_and_soc_change_elevation,
    freeze_thaw_soc_and_erosion_change_elevation,

    fn surfElevChangeModeFromInt(val: usize, file_name: []const u8, err_log: *std.Io.Writer) OptsErrors![]const u8 {
        return switch (val) {
            @intFromEnum(SurfElevChangeMode.no_change_in_elevation) => "no change in elevation",
            @intFromEnum(SurfElevChangeMode.freeze_thaw_changes_elevation) => "allow freeze-thaw to change elevation",
            @intFromEnum(SurfElevChangeMode.freeze_thaw_and_erosion_change_elevation) => "allow freeze-thaw + erosion to change elevation",
            @intFromEnum(SurfElevChangeMode.freeze_thaw_and_soc_change_elevation) => "allow freeze-thaw + SOC accumulation to change elevation",
            @intFromEnum(SurfElevChangeMode.freeze_thaw_soc_and_erosion_change_elevation) => "allow freeze-thaw + SOC accumulation + erosion to change elevation",
            else => {
                const err = error.InvalidOption;
                err_log.print("error: {s} in reading soil surface elevation change simulation option {d} in {s}. Allowed surface elevation change simulation options are: 0=no change in elevation, 1=allow freeze-thaw to change elevation, 2=allow freeze-thaw + erosion to change elevation, 3=allow freeze-thaw + SOC accumulation to change elevation, 4=allow freeze-thaw + SOC accumulation to change elevation, and 5=allow freeze-thaw + SOC accumulation + erosion to change elevation\n", .{ @errorName(err), val, file_name }) catch {
                    return error.PrintFailed;
                };
                defer err_log.flush() catch {};
                print("\x1b[1;31merror:\x1b[0m {s} in surface elevation change simulation option {d} in {s}. Allowed soil surface elevation change simulation options are: 0=no change in elevation, 1=allow freeze-thaw to change elevation, 2=allow freeze-thaw + erosion to change elevation, 3=allow freeze-thaw + SOC accumulation to change elevation, 4=allow freeze-thaw + SOC accumulation to change elevation, and 5=allow freeze-thaw + SOC accumulation + erosion to change elevation\n", .{ @errorName(err), val, file_name });
                return err;
            },
        };
    }
};
///Grid lateral connectivity (lateral flux simulation) options
const GridLatConnOpts = enum {
    no_lateral_connection_between_adjacent_grids,
    adjacent_grids_laterally_connected,
};
pub const GridLatConnMode = union(GridLatConnOpts) {
    no_lateral_connection_between_adjacent_grids,
    adjacent_grids_laterally_connected,

    fn gridLatConnModeFromInt(val: usize, file_name: []const u8, err_log: *std.Io.Writer) OptsErrors![]const u8 {
        return switch (val) {
            @intFromEnum(GridLatConnMode.no_lateral_connection_between_adjacent_grids) => "no lateral connection between adjacent grids (no lateral flux simulation between adjacent grids)",
            @intFromEnum(GridLatConnMode.adjacent_grids_laterally_connected) => "adjacent grids are connected laterally (allow lateral flux simulation between adjacent grids)",
            else => {
                const err = error.InvalidOption;
                err_log.print("error: {s} in reading grid lateral connectivity option {d} in {s}. Allowed grid lateral connectivity options are: 0=no lateral connection between adjacent grids (no lateral flux simulation between adjacent grids), and 1=adjacent grids are connected laterally (allow lateral flux simulation between adjacent grids)\n", .{ @errorName(err), val, file_name }) catch {
                    return error.PrintFailed;
                };
                defer err_log.flush() catch {};
                print("\x1b[1;31merror:\x1b[0m {s} in reading grid lateral connectivity option {d} in {s}. Allowed grid lateral connectivity options are: 0=no lateral connection between adjacent grids (no lateral flux simulation between adjacent grids), and 1=adjacent grids are connected laterally (allow lateral flux simulation between adjacent grids)\n", .{ @errorName(err), val, file_name });
                return err;
            },
        };
    }
};
///Writes out description of inputs in land unit files to check
pub const LandUnitChk = struct {
    path_buf: [max_path_len_safe]u8 = undefined,
    file_name: []const u8 = undefined,
    file_writer: FileWriter = FileWriter{},

    ///Build land unit input check file paths and names
    fn buildCheckFilePath(self: *LandUnitChk, io_files: *const IoFiles, outdir: *const OutDir, we: usize, ns: usize) !void {
        const rawname = io_files.site_file.land_unit.name[we][ns][0..io_files.site_file.land_unit.len[we][ns]];
        const basename = std.fs.path.basename(rawname);
        const ext = std.fs.path.extension(basename);
        self.file_name = basename[0 .. basename.len - ext.len];
        self.file_name = try std.fmt.bufPrint(&self.path_buf, "{s}/{d}{d}{s}.txt", .{ outdir.input_chk, we, ns, self.file_name });
    }
    ///Write land unit input data with descriptions and units
    fn writeInputs(self: *LandUnitChk, land_unit: *const LandUnit, io_files: *const IoFiles, err_log: *std.Io.Writer, we: usize, ns: usize) !void {
        const wt_opt_desc = WtMode.wtModeFromInt(land_unit.loc.wt_opt[we][ns], io_files.site_file.land_unit.name[we][ns][0..io_files.site_file.land_unit.len[we][ns]], err_log) catch {
            return error.InvalidOption;
        };
        const salinity_opt_desc = SalinityMode.salinityModeFromInt(land_unit.opts.salinity_opt[we][ns], io_files.site_file.land_unit.name[we][ns][0..io_files.site_file.land_unit.len[we][ns]], err_log) catch {
            return error.InvalidOption;
        };
        const surf_elev_change_opt_desc = SurfElevChangeMode.surfElevChangeModeFromInt(land_unit.opts.surf_elev_change_opt[we][ns], io_files.site_file.land_unit.name[we][ns][0..io_files.site_file.land_unit.len[we][ns]], err_log) catch {
            return error.InvalidOption;
        };
        const grid_conn_opt_desc = GridLatConnMode.gridLatConnModeFromInt(land_unit.opts.grid_conn_opt[we][ns], io_files.site_file.land_unit.name[we][ns][0..io_files.site_file.land_unit.len[we][ns]], err_log) catch {
            return error.InvalidOption;
        };
        try self.file_writer.buf_writer.print(land_unit_data_desc.loc_atm_gas_opts, .{ land_unit.loc.lat[we][ns], land_unit.loc.alt_init[we][ns], land_unit.loc.asp[we][ns], land_unit.loc.surf_slop[we][ns], land_unit.loc.snowpack_init[we][ns], land_unit.loc.matc_init[we][ns], wt_opt_desc, land_unit.atm_gas.o2conc[we][ns], land_unit.atm_gas.n2conc[we][ns], land_unit.atm_gas.co2conc_init[we][ns], land_unit.atm_gas.ch4conc[we][ns], land_unit.atm_gas.n2conc[we][ns], land_unit.atm_gas.nh3conc[we][ns], land_unit.opts.koppen_clim_zone[we][ns], salinity_opt_desc, surf_elev_change_opt_desc, grid_conn_opt_desc, land_unit.opts.nat_wtdx_init[we][ns], land_unit.opts.art_wtdx_init[we][ns], land_unit.opts.nat_wtx_slope[we][ns] });
        try self.file_writer.buf_writer.print(land_unit_data_desc.bounds_grid_dims, .{ land_unit.bounds.surf.west[we][ns], land_unit.bounds.surf.north[we][ns], land_unit.bounds.surf.east[we][ns], land_unit.bounds.surf.south[we][ns], land_unit.bounds.sub_surf.west[we][ns], land_unit.bounds.sub_surf.north[we][ns], land_unit.bounds.sub_surf.east[we][ns], land_unit.bounds.sub_surf.south[we][ns], land_unit.bounds.dist_to_wtdx.west[we][ns], land_unit.bounds.dist_to_wtdx.north[we][ns], land_unit.bounds.dist_to_wtdx.east[we][ns], land_unit.bounds.dist_to_wtdx.south[we][ns], land_unit.bounds.bottom_drain[we][ns], land_unit.grid_dim.west_east[we][ns], land_unit.grid_dim.north_south[we][ns] });
    }
    ///Write land unit inputs in respective input check files
    pub fn writeCheckFile(self: *LandUnitChk, land_unit: *const LandUnit, io_files: *const IoFiles, outdir: *const OutDir, err_log: *std.Io.Writer, we: usize, ns: usize) !void {
        try self.buildCheckFilePath(io_files, outdir, we, ns);
        try self.file_writer.create(self.file_name);
        defer self.file_writer.close();
        self.file_writer.writer();
        try self.writeInputs(land_unit, io_files, err_log, we, ns);
        try self.file_writer.buf_writer.flush();
    }
};
