const std = @import("std");
const ecosys_ng = @import("ecosys-ng");
const util = ecosys_ng.util;
const io = ecosys_ng.io;
const utils = util.utils;
const parser = util.input_parser;
const err_handler = util.err_handler;
const geo_attr = io.geo_attr;
///ecosys-ng main function
pub fn main() !void {
    const start_time_us: i64 = std.time.microTimestamp();
    //Create directory tree for saving the outputs
    var out: utils.OutDir = utils.OutDir{};
    try out.mkOutDirs();
    //Create the error log file in the outputs folder
    var err_log: utils.ErrorLog = utils.ErrorLog{};
    try err_log.init(&out);
    defer err_log.file_writer.close();
    err_log.file_writer.writer();
    //Initialize run args to store the runfile name from the run submission
    var run: parser.RunArg = parser.RunArg{};
    //Read and check ecosys run submission arguments and read ecosys runfile/runscript name from run submission arguments
    const runfile = try run.getRunfile();
    //Open runfile to read.
    try run.file_reader.open(err_log.file_writer.buf_writer, runfile);
    //Close the runfile later before the main function returns
    defer run.file_reader.close();
    //Open a buffered reader to read runfile
    run.file_reader.reader();
    //Initialize model runtime and completion tracking
    var runtime = err_handler.CompletionTime.init(start_time_us, runfile, err_log.file_writer.buf_writer);
    //Generate run failure message, if the run fails before completion
    errdefer runtime.fail();
    var geo_attr_ = geo_attr.LatLonRangeAndTileSpecs{};
    try geo_attr_.read(runfile, run.file_reader.buf_reader, err_log.file_writer.buf_writer);
    std.debug.print("test tilespec print: lat_max_ud: {d}\n", .{geo_attr_.lat_max_ud});
    try runtime.success();
}
