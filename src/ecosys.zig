const std = @import("std");
const CompletionTime = @import("util/error_check.zig").CompletionTime;
const RunArg = @import("util/input_parser.zig").RunArg;
const IOFiles = @import("io/iofiles.zig").IOFiles;
const Tokens = @import("util/input_parser.zig").Tokens;
const OutDir = @import("util/utils.zig").OutDir;
const LogFile = @import("util/utils.zig").LogFile;

/// Ecosys main function
pub fn main() !void {
    const start_time_us: i64 = std.time.microTimestamp();
    // Initialize run args to store the runfile name from the run submission.
    var run: RunArg = RunArg{};
    // Read and check ecosys run submission arguments and read ecosys runfile/runscript name from run submission arguments.
    try run.getRunfile();
    // Open runfile to read.
    try run.open();
    // Close the runfile later before the functoin returns.
    defer run.close();
    try run.reader();
    // Create directory tree for saving the outputs.
    var out: OutDir = OutDir{};
    try out.mkOutDirs();
    // Create the error and run status log files in the outputs folder.
    var logfile: LogFile = LogFile{};
    try logfile.create(&out);
    defer logfile.close();
    try logfile.writer();
    // Initialize model runtime and completion tracking
    var runtime = CompletionTime.init(start_time_us, run.run, logfile.err_log.buf_writer);
    // Generate run failure message, if the run fails before completion.
    errdefer runtime.fail();
    // Read all input output file names in the runscript.
    var io_files = IOFiles{};
    try io_files.getAllIOFiles(run.buffered_reader, &run, logfile.err_log.buf_writer);
    std.debug.print("test io files {s}\n", .{io_files.daily_out_file.heat[0][5]});
    // Generate a success message with run completing runtime, if the run completes with no error.
    try runtime.success();
}
