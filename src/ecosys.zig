const std = @import("std");
const offset: u32 = 1;
const CompletionTime = @import("util/errors.zig").CompletionTime;
const RunArg = @import("util/buffers.zig").RunArg;
const IOFiles = @import("io/iofiles.zig").IOFiles;
const FileReader = @import("util/buffers.zig").FileReader;
const FileWriter = @import("util/buffers.zig").FileWriter;
const Tokens = @import("util/buffers.zig").Tokens;
const OutDir = @import("util/helpers.zig").OutDir;
const OutFile = @import("util/helpers.zig").OutFile;
const open = @import("util/open.zig").open;

/// Ecosys main function
pub fn main() !void {
    const start_time_us: i64 = std.time.microTimestamp();
    // Initialize run args to store the runfile name from the run submission.
    var run: RunArg = RunArg{};
    // Read and check ecosys run submission arguments and read ecosys runfile/runscript name from run submission arguments.
    try run.getRunfile();
    // Create directory tree for saving the outputs
    var out: OutDir = OutDir{};
    try out.mkOutDirs();
    var outfile: OutFile = OutFile{};
    try outfile.mkOutFiles(out);
    // Create the error log file
    const log_err = outfile.err_log;
    defer log_err.close();
    var log_err_writer = FileWriter{};
    const err_log = log_err_writer.writer(log_err);
    // Initialize model runtime and completion tracking
    var runtime = CompletionTime.init(start_time_us, run.runfile, err_log);
    // Generate run failure message, if the run fails before completion.
    errdefer runtime.fail();
    // Unroll model variables.
    const run_script = try open(run.runfile, err_log);
    defer run_script.close();
    var run_reader = FileReader{};
    const runscript = run_reader.reader(run_script);
    // Create the runscript input check log file
    var log_run = outfile.run_log;
    defer log_run.close();
    var log_run_writer = FileWriter{};
    const run_log = log_run_writer.writer(log_run);
    _ = run_log;
    var io_files = IOFiles{};
    try io_files.getAllIOFiles(runscript, err_log);
    std.debug.print("test io files {s}\n", .{io_files.daily_heat_out[0][5]});
    // Generate a success message with run completing runtime, if the run completes with no error.
    try runtime.success();
}
