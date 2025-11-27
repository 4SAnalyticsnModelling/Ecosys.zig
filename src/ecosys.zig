const std = @import("std");
const input_parser = @import("util/input_parser.zig");
const error_check = @import("util/error_check.zig");
const utils = @import("util/utils.zig");
const iofiles = @import("io/iofiles.zig");
const CompletionTime = error_check.CompletionTime;
const RunArg = input_parser.RunArg;
const IOFiles = iofiles.IOFiles;
const Tokens = input_parser.Tokens;
const OutDir = utils.OutDir;
const ErrorLog = utils.ErrorLog;
const RunStatLog = utils.RunStatLog;

/// Ecosys main function
pub fn main() !void {
    const start_time_us: i64 = std.time.microTimestamp();
    // Create directory tree for saving the outputs.
    var out: OutDir = OutDir{};
    try out.mkOutDirs();
    // Create the error log file in the outputs folder.
    var err_log: ErrorLog = ErrorLog{};
    try err_log.init(&out);
    defer err_log.file_writer.close();
    err_log.file_writer.writer();
    // Initialize run args to store the runfile name from the run submission.
    var run: RunArg = RunArg{};
    // Read and check ecosys run submission arguments and read ecosys runfile/runscript name from run submission arguments.
    const runfile = try run.getRunfile();
    std.debug.print("test runfile name {s}\n", .{runfile});
    // Open runfile to read.
    try run.file_reader.open(err_log.file_writer.buf_writer, runfile);
    // Close the runfile later before the main function returns.
    defer run.file_reader.close();
    // Open a buffered reader to read runfile.
    run.file_reader.reader();
    // Initialize model runtime and completion tracking
    var runtime = CompletionTime.init(start_time_us, runfile, err_log.file_writer.buf_writer);
    // Generate run failure message, if the run fails before completion.
    errdefer runtime.fail();
    // Read all input output file names in the runscript.
    var io_files = IOFiles{};
    try io_files.getParentIOFiles(run.file_reader.buf_reader, runfile, err_log.file_writer.buf_writer);
    try io_files.getChildIOFiles(err_log.file_writer.buf_writer);
    std.debug.print("test start year {d}\n", .{io_files.start_yr});
    std.debug.print("test scenario number {d}\n", .{io_files.scenario.num});
    std.debug.print("test site file {s}\n", .{io_files.site_file.site.name[0..io_files.site_file.site.len]});
    for (io_files.grid_num.west..io_files.grid_num.east) |nwe| {
        for (io_files.grid_num.north..io_files.grid_num.south) |nns| {
            std.debug.print("test soil file {s}\n", .{io_files.site_file.soil.name[nwe][nns][0..io_files.site_file.soil.len[nwe][nns]]});
            std.debug.print("test land unit file {s}\n", .{io_files.site_file.land_unit.name[nwe][nns][0..io_files.site_file.land_unit.len[nwe][nns]]});
        }
    }
    for (0..io_files.scenario.num) |scenario_id| {
        for (0..io_files.scene.num[scenario_id]) |scene_id| {
            std.debug.print("test wthr net files {s}\n", .{io_files.wthr_file.wthr_net.name[scenario_id][scene_id][0..io_files.wthr_file.wthr_net.len[scenario_id][scene_id]]});
            for (io_files.grid_num.west..io_files.grid_num.east) |nwe| {
                for (io_files.grid_num.north..io_files.grid_num.south) |nns| {
                    std.debug.print("test wthr files {s}\n", .{io_files.wthr_file.wthr.name[scenario_id][scene_id][nwe][nns][0..io_files.wthr_file.wthr.len[scenario_id][scene_id][nwe][nns]]});
                }
            }
            const soil_mgmt_file = io_files.soil_mgmt_file.soil_mgmt.name[scenario_id][scene_id][0..io_files.soil_mgmt_file.soil_mgmt.len[scenario_id][scene_id]];
            std.debug.print("test soil mgmt files {s}\n", .{soil_mgmt_file});
            if (!std.mem.eql(u8, soil_mgmt_file, "no")) {
                for (io_files.grid_num.west..io_files.grid_num.east) |nwe| {
                    for (io_files.grid_num.north..io_files.grid_num.south) |nns| {
                        std.debug.print("test tillage files {s}\n", .{io_files.soil_mgmt_file.till.name[scenario_id][scene_id][nwe][nns][0..io_files.soil_mgmt_file.till.len[scenario_id][scene_id][nwe][nns]]});
                        std.debug.print("test fertilizer files {s}\n", .{io_files.soil_mgmt_file.fert.name[scenario_id][scene_id][nwe][nns][0..io_files.soil_mgmt_file.fert.len[scenario_id][scene_id][nwe][nns]]});
                        std.debug.print("test irrigation files {s}\n", .{io_files.soil_mgmt_file.irrig.name[scenario_id][scene_id][nwe][nns][0..io_files.soil_mgmt_file.irrig.len[scenario_id][scene_id][nwe][nns]]});
                    }
                }
            }
            const plant_mgmt_file = io_files.plant_mgmt_file.plant_mgmt.name[scenario_id][scene_id][0..io_files.plant_mgmt_file.plant_mgmt.len[scenario_id][scene_id]];
            std.debug.print("test plant mgmt files {s}\n", .{plant_mgmt_file});
            if (!std.mem.eql(u8, plant_mgmt_file, "no")) {
                for (io_files.grid_num.west..io_files.grid_num.east) |nwe| {
                    for (io_files.grid_num.north..io_files.grid_num.south) |nns| {
                        for (0..2) |plant_id| {
                            std.debug.print("test plant species {s}\n", .{io_files.plant_mgmt_file.plant.name[scenario_id][scene_id][nwe][nns][plant_id][0..io_files.plant_mgmt_file.plant.len[scenario_id][scene_id][nwe][nns][plant_id]]});
                            std.debug.print("test plant management operations {s}\n", .{io_files.plant_mgmt_file.operation.name[scenario_id][scene_id][nwe][nns][plant_id][0..io_files.plant_mgmt_file.operation.len[scenario_id][scene_id][nwe][nns][plant_id]]});
                        }
                    }
                }
            }
        }
    }
    // Generate a success message with run completing runtime, if the run completes with no error.
    try runtime.success();
}
