const std = @import("std");
const input_parser = @import("util/input_parser.zig");
const error_check = @import("util/error_check.zig");
const utils = @import("util/utils.zig");
const iofiles = @import("io/iofiles.zig");
const CompletionTime = error_check.CompletionTime;
const RunArg = input_parser.RunArg;
const IoFiles = iofiles.IoFiles;
const Tokens = input_parser.Tokens;
const OutDir = utils.OutDir;
const ErrorLog = utils.ErrorLog;
const RunStatLog = utils.RunStatLog;
const LandUnit = @import("io/land_unit.zig").LandUnit;

///Ecosys main function
pub fn main() !void {
    const start_time_us: i64 = std.time.microTimestamp();
    //Create directory tree for saving the outputs
    var out: OutDir = OutDir{};
    try out.mkOutDirs();
    //Create the error log file in the outputs folder
    var err_log: ErrorLog = ErrorLog{};
    try err_log.init(&out);
    defer err_log.file_writer.close();
    err_log.file_writer.writer();
    //Initialize run args to store the runfile name from the run submission
    var run: RunArg = RunArg{};
    //Read and check ecosys run submission arguments and read ecosys runfile/runscript name from run submission arguments
    const runfile = try run.getRunfile();
    //Open runfile to read.
    try run.file_reader.open(err_log.file_writer.buf_writer, runfile);
    //Close the runfile later before the main function returns
    defer run.file_reader.close();
    //Open a buffered reader to read runfile
    run.file_reader.reader();
    //Initialize model runtime and completion tracking
    var runtime = CompletionTime.init(start_time_us, runfile, err_log.file_writer.buf_writer);
    //Generate run failure message, if the run fails before completion
    errdefer runtime.fail();
    //Read all input output file names in the runscript
    var io_files = IoFiles{};
    try io_files.getParentIoFiles(run.file_reader.buf_reader, runfile, err_log.file_writer.buf_writer);
    try io_files.getChildIoFiles(err_log.file_writer.buf_writer);
    //Read land unit data
    var land_unit = LandUnit{};
    try land_unit.loadLandUnitData(&io_files, err_log.file_writer.buf_writer);
    //std.debug.print("test start year {d}\n", .{io_files.start_yr});
    //std.debug.print("test scenario number {d}\n", .{io_files.scenario.num});
    //std.debug.print("test site file {s}\n", .{io_files.site_file.site.name[0..io_files.site_file.site.len]});
    const string_lit =
        \\test lat {d}, alt {d}, MAT {d}, wtd simulation {s}, max daylen {d}
        \\test O₂ conc {d}, N₂ conc {d}, init CO₂ conc {d}, CH₄ conc {d}, N₂O conc {d}, NH₃ conc {d}
        \\test koppen climate zone {d}, salinity simulation {s}, erosion simulation {s}, grid connection simulation {s}, natural WTDx {d}, artificial WTDx {d}, WTx slope {d}
        \\test surface boundary west {d}, north {d}, east {d}, south {d}, sub-surface boundary west {d}, north {d}, east {d}, south {d}, distance to WTx west {d}, north {d}, east {d}, south {d}, bottom drainage {d}
        \\
    ;

    for (io_files.grid_num.west..io_files.grid_num.east) |we| {
        for (io_files.grid_num.north..io_files.grid_num.south) |ns| {
            //std.debug.print("test soil file {s}\n", .{io_files.site_file.soil.name[we][ns][0..io_files.site_file.soil.len[we][ns]]});
            //std.debug.print("test land unit file {s}\n", .{io_files.site_file.land_unit.name[we][ns][0..io_files.site_file.land_unit.len[we][ns]]});
            std.debug.print(string_lit, .{ land_unit.loc.lat[we][ns], land_unit.loc.alt_init[we][ns], land_unit.loc.matc_init[we][ns], land_unit.loc.wt_opt_desc[land_unit.loc.wt_opt[we][ns]], land_unit.loc.max_daylength[we][ns], land_unit.atm_gas.o2conc[we][ns], land_unit.atm_gas.n2conc[we][ns], land_unit.atm_gas.co2conc_init[we][ns], land_unit.atm_gas.ch4conc[we][ns], land_unit.atm_gas.n2conc[we][ns], land_unit.atm_gas.nh3conc[we][ns], land_unit.opts.koppen_clim_zone[we][ns], land_unit.opts.salinity_opt_desc[land_unit.opts.salinity_opt[we][ns]], land_unit.opts.erosion_opt_desc[land_unit.opts.erosion_opt[we][ns]], land_unit.opts.grid_conn_opt_desc[land_unit.opts.grid_conn_opt[we][ns]], land_unit.opts.nat_wtdx_init[we][ns], land_unit.opts.art_wtdx_init[we][ns], land_unit.opts.nat_wtx_slope[we][ns], land_unit.bounds.surf.west[we][ns], land_unit.bounds.surf.north[we][ns], land_unit.bounds.surf.east[we][ns], land_unit.bounds.surf.south[we][ns], land_unit.bounds.sub_surf.west[we][ns], land_unit.bounds.sub_surf.north[we][ns], land_unit.bounds.sub_surf.east[we][ns], land_unit.bounds.sub_surf.south[we][ns], land_unit.bounds.dist_to_wtdx.west[we][ns], land_unit.bounds.dist_to_wtdx.north[we][ns], land_unit.bounds.dist_to_wtdx.east[we][ns], land_unit.bounds.dist_to_wtdx.south[we][ns], land_unit.bounds.bottom_drain[we][ns] });
        }
    }
    //for (0..io_files.scenario.num) |scenario| {
    //    for (0..io_files.scene.num[scenario]) |scene| {
    //        std.debug.print("test wthr net files {s}\n", .{io_files.wthr_file.wthr_net.name[scenario][scene][0..io_files.wthr_file.wthr_net.len[scenario][scene]]});
    //        for (io_files.grid_num.west..io_files.grid_num.east) |we| {
    //            for (io_files.grid_num.north..io_files.grid_num.south) |ns| {
    //                std.debug.print("test wthr files {s}\n", .{io_files.wthr_file.wthr.name[scenario][scene][we][ns][0..io_files.wthr_file.wthr.len[scenario][scene][we][ns]]});
    //            }
    //        }
    //        const soil_mgmt_file = io_files.soil_mgmt_file.soil_mgmt.name[scenario][scene][0..io_files.soil_mgmt_file.soil_mgmt.len[scenario][scene]];
    //        std.debug.print("test soil mgmt files {s}\n", .{soil_mgmt_file});
    //        if (!std.mem.eql(u8, soil_mgmt_file, "no")) {
    //            for (io_files.grid_num.west..io_files.grid_num.east) |we| {
    //                for (io_files.grid_num.north..io_files.grid_num.south) |ns| {
    //                    std.debug.print("test tillage files {s}\n", .{io_files.soil_mgmt_file.till.name[scenario][scene][we][ns][0..io_files.soil_mgmt_file.till.len[scenario][scene][we][ns]]});
    //                    std.debug.print("test fertilizer files {s}\n", .{io_files.soil_mgmt_file.fert.name[scenario][scene][we][ns][0..io_files.soil_mgmt_file.fert.len[scenario][scene][we][ns]]});
    //                    std.debug.print("test irrigation files {s}\n", .{io_files.soil_mgmt_file.irrig.name[scenario][scene][we][ns][0..io_files.soil_mgmt_file.irrig.len[scenario][scene][we][ns]]});
    //                }
    //            }
    //        }
    //        const plant_mgmt_file = io_files.plant_mgmt_file.plant_mgmt.name[scenario][scene][0..io_files.plant_mgmt_file.plant_mgmt.len[scenario][scene]];
    //        std.debug.print("test plant mgmt files {s}\n", .{plant_mgmt_file});
    //        if (!std.mem.eql(u8, plant_mgmt_file, "no")) {
    //            for (io_files.grid_num.west..io_files.grid_num.east) |we| {
    //                for (io_files.grid_num.north..io_files.grid_num.south) |ns| {
    //                    for (0..3) |plnt| {
    //                        if (io_files.plant_mgmt_file.plant.len[scenario][scene][we][ns][plnt] > 0) {
    //                            std.debug.print("test plant species {s}\n", .{io_files.plant_mgmt_file.plant.name[scenario][scene][we][ns][plnt][0..io_files.plant_mgmt_file.plant.len[scenario][scene][we][ns][plnt]]});
    //                            std.debug.print("test plant management operations {s}\n", .{io_files.plant_mgmt_file.operation.name[scenario][scene][we][ns][plnt][0..io_files.plant_mgmt_file.operation.len[scenario][scene][we][ns][plnt]]});
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //}
    //}
    //Generate a success message with run completing runtime, if the run completes with no error.
    try runtime.success();
}
