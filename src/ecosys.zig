const std = @import("std");
const offset: u32 = 1;
const CompletionTime = @import("util/errors.zig").CompletionTime;
const RunArg = @import("util/buffers.zig").RunArg;
const IOFiles = @import("io/iofiles.zig").IOFiles;
const FileReader = @import("util/buffers.zig").FileReader;
const FileWriter = @import("util/buffers.zig").FileWriter;
const Tokens = @import("util/buffers.zig").Tokens;
const OutDir = @import("util/helpers.zig").OutDir;
const LogFile = @import("util/helpers.zig").LogFile;

/// Ecosys main function
pub fn main() !void {
    const start_time_us: i64 = std.time.microTimestamp();
    // Initialize run args to store the runfile name from the run submission.
    var run: RunArg = RunArg{};
    // Read and check ecosys run submission arguments and read ecosys runfile/runscript name from run submission arguments.
    try run.getRunfile();
    // Open runfile to read.
    try run.open();
    defer run.close();
    // Create directory tree for saving the outputs
    var out: OutDir = OutDir{};
    try out.mkOutDirs();
    // Create the error and run status log files
    var logfile: LogFile = LogFile{};
    try logfile.create(out);
    defer logfile.close();
    // Create error log file writer
    var log_err_writer = FileWriter{};
    const err_log = log_err_writer.writer(logfile.err_log);
    // Initialize model runtime and completion tracking
    var runtime = CompletionTime.init(start_time_us, run.run, err_log);
    // Generate run failure message, if the run fails before completion.
    errdefer runtime.fail();
    // Unroll model variables.
    var run_reader = FileReader{};
    const runscript = run_reader.reader(run.runfile);
    var io_files = IOFiles{};
    try io_files.getAllIOFiles(runscript, err_log);
    std.debug.print("test io files {s}\n", .{io_files.daily_heat_out[0][5]});
    // Generate a success message with run completing runtime, if the run completes with no error.
    try runtime.success();
}
