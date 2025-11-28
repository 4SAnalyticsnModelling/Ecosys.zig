///This module contains struct and methods that help writing out all model inputs with description and units (both files and data) to check if all inputs are appropriate
const std = @import("std");
const config = @import("config");
const utils = @import("../util/utils.zig");
const max_path_len = config.filepathx;
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
    buf_print: [max_path_len + 40]u8 = undefined, //the additional 40 bytes is safety net for parent directory names e.g. outputs/input_chk
    file_name: []const u8 = undefined,
    file_writer: FileWriter = FileWriter{},

    ///Crafts I/O file names' check file name/path
    fn craftIoFilesChkFileName(self: *IoFileNameChk, runfile_name: []const u8, outdir: *const OutDir) !void {
        const basename = std.fs.path.basename(runfile_name);
        const ext = std.fs.path.extension(basename);
        self.file_name = basename[0 .. basename.len - ext.len];
        self.file_name = try std.fmt.bufPrint(&self.buf_print, "{s}/{s}.txt", .{ outdir.input_chk, self.file_name });
    }
    ///Flushes out I/O file names or other input data in runfile/runscript with descriptions
    fn flushGlobalIoFileNamesAndParams(self: *IoFileNameChk, io_files: *const IoFiles) !void {
        try self.file_writer.buf_writer.print(io_file_name_desc.global_params, .{ 0, io_files.grid_num.west, io_files.grid_num.north, io_files.grid_num.east, io_files.grid_num.south, 1, io_files.site_file.site.name[0..io_files.site_file.site.len], 2, io_files.start_yr, 3, io_files.scenario.num, io_files.scenario.repeat });
    }
    ///Flushes out scenario level data in runfile/runscript with descriptions
    fn flushScenarioParams(self: *IoFileNameChk, io_files: *const IoFiles, line_num: usize, scenario: usize) !void {
        try self.file_writer.buf_writer.print(io_file_name_desc.scenario_params, .{ line_num, io_files.scene.num[scenario], io_files.scene.repeat[scenario] });
    }
    ///Flushes out scene I/O file names in runfile/runscript with descriptions
    fn flushSceneIoFileNames(self: *IoFileNameChk, io_files: *const IoFiles, line_num: usize, scenario: usize, scene: usize) !void {
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
        try self.file_writer.buf_writer.print(io_file_name_desc.scene_params, .{ line_num, wthr_net_file, line_num + 1, opts_file, line_num + 2, soil_mgmt_file, line_num + 3, plant_mgmt_file, line_num + 4, hrly_c_file, line_num + 5, hrly_wtr_file, line_num + 6, hrly_n_file, line_num + 7, hrly_p_file, line_num + 8, hrly_heat_file, line_num + 9, daily_c_file, line_num + 10, daily_wtr_file, line_num + 11, daily_n_file, line_num + 12, daily_p_file, line_num + 13, daily_heat_file });
    }
    ///Spits out all parent I/O file names within the runfile/runscript into the relevant input check file
    pub fn spitParentIoFileNames(self: *IoFileNameChk, io_files: *const IoFiles, outdir: *const OutDir, runfile_name: []const u8) !void {
        try self.craftIoFilesChkFileName(runfile_name, outdir);
        try self.file_writer.create(self.file_name);
        defer self.file_writer.close();
        self.file_writer.writer();
        try self.flushGlobalIoFileNamesAndParams(io_files);
        for (0..io_files.scenario.num) |scenario| {
            var line_num = 4 + scenario * io_files.scene.num[scenario] * 14;
            try self.flushScenarioParams(io_files, line_num, scenario);
            line_num += 1;
            for (0..io_files.scene.num[scenario]) |scene| {
                try self.flushSceneIoFileNames(io_files, line_num, scenario, scene);
                line_num += 14;
            }
            line_num += 1;
        }
        try self.file_writer.buf_writer.flush();
    }
};
///Writes out description of inputs in land unit files to check
pub const LandUnitChk = struct {
    buf_print: [max_path_len + 40]u8 = undefined, //the additional 40 bytes is safety net for parent directory names e.g. outputs/input_chk
    file_name: []const u8 = undefined,
    file_writer: FileWriter = FileWriter{},

    ///Crafts land unit input check file paths and names
    fn craftLandUnitChkFileNames(self: *LandUnitChk, io_files: *const IoFiles, outdir: *const OutDir, we: usize, ns: usize) !void {
        const rawname = io_files.site_file.land_unit.name[we][ns][0..io_files.site_file.land_unit.len[we][ns]];
        const basename = std.fs.path.basename(rawname);
        const ext = std.fs.path.extension(basename);
        self.file_name = basename[0 .. basename.len - ext.len];
        self.file_name = try std.fmt.bufPrint(&self.buf_print, "{s}/{d}{d}{s}.txt", .{ outdir.input_chk, we, ns, self.file_name });
    }
    ///Flushes out land unit input data with descriptions and units
    fn flushLandUnitInputs(self: *LandUnitChk, land_unit: *const LandUnit, we: usize, ns: usize) !void {
        try self.file_writer.buf_writer.print(land_unit_data_desc.loc_atm_gas_opts, .{ land_unit.loc.lat[we][ns], land_unit.loc.alt_init[we][ns], land_unit.loc.asp[we][ns], land_unit.loc.surf_slop[we][ns], land_unit.loc.snowpack_init[we][ns], land_unit.loc.matc_init[we][ns], land_unit.loc.wt_opt_desc[land_unit.loc.wt_opt[we][ns]], land_unit.atm_gas.o2conc[we][ns], land_unit.atm_gas.n2conc[we][ns], land_unit.atm_gas.co2conc_init[we][ns], land_unit.atm_gas.ch4conc[we][ns], land_unit.atm_gas.n2conc[we][ns], land_unit.atm_gas.nh3conc[we][ns], land_unit.opts.koppen_clim_zone[we][ns], land_unit.opts.salinity_opt_desc[land_unit.opts.salinity_opt[we][ns]], land_unit.opts.erosion_opt_desc[land_unit.opts.erosion_opt[we][ns]], land_unit.opts.grid_conn_opt_desc[land_unit.opts.grid_conn_opt[we][ns]], land_unit.opts.nat_wtdx_init[we][ns], land_unit.opts.art_wtdx_init[we][ns], land_unit.opts.nat_wtx_slope[we][ns] });
        try self.file_writer.buf_writer.print(land_unit_data_desc.bounds_grid_dims, .{ land_unit.bounds.surf.west[we][ns], land_unit.bounds.surf.north[we][ns], land_unit.bounds.surf.east[we][ns], land_unit.bounds.surf.south[we][ns], land_unit.bounds.sub_surf.west[we][ns], land_unit.bounds.sub_surf.north[we][ns], land_unit.bounds.sub_surf.east[we][ns], land_unit.bounds.sub_surf.south[we][ns], land_unit.bounds.dist_to_wtdx.west[we][ns], land_unit.bounds.dist_to_wtdx.north[we][ns], land_unit.bounds.dist_to_wtdx.east[we][ns], land_unit.bounds.dist_to_wtdx.south[we][ns], land_unit.bounds.bottom_drain[we][ns], land_unit.grid_dim.west_east[we][ns], land_unit.grid_dim.north_south[we][ns] });
    }
    ///Spits out land unit inputs in respective input check files
    pub fn spitLandUnitInputs(self: *LandUnitChk, land_unit: *const LandUnit, io_files: *const IoFiles, outdir: *const OutDir, we: usize, ns: usize) !void {
        try self.craftLandUnitChkFileNames(io_files, outdir, we, ns);
        try self.file_writer.create(self.file_name);
        defer self.file_writer.close();
        self.file_writer.writer();
        try self.flushLandUnitInputs(land_unit, we, ns);
        try self.file_writer.buf_writer.flush();
    }
};
