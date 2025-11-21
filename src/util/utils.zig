const std = @import("std");
/// This struct helps create ecosys output directory tree.
pub const OutDir = struct {
    par_dir: []const u8 = "outputs",
    err_dir: []const u8 = "outputs/error_logs",
    run_trck: []const u8 = "outputs/run_trackers",
    input_chk: []const u8 = "outputs/input_checks",
    outs: []const u8 = "outputs/modeled_outputs",
    ///This method creates a directory by forcing deletion of the previous version (if any) of the same directory.
    fn createDir(path: []const u8) !void {
        const fs = std.fs.cwd();
        fs.deleteTree(path) catch {};
        try fs.makeDir(path);
    }
    ///This method creates all ecosys output directories.
    pub fn mkOutDirs(self: *const OutDir) !void {
        try createDir(self.par_dir);
        try createDir(self.err_dir);
        try createDir(self.run_trck);
        try createDir(self.input_chk);
        try createDir(self.outs);
    }
};
///Error log struct.
const ErrorLog = struct {
    fmt_buf: [256]u8 = undefined,
    log_buf: [1024]u8 = undefined,
    file: std.fs.File = undefined,
    file_writer: std.fs.File.Writer = undefined,
    buf_writer: *std.Io.Writer = undefined,
};
///Error log struct.
const RunStatLog = struct {
    fmt_buf: [256]u8 = undefined,
    log_buf: [1024]u8 = undefined,
    file: std.fs.File = undefined,
    file_writer: std.fs.File.Writer = undefined,
    buf_writer: *std.Io.Writer = undefined,
};
///This struct helps writing out error and run status logfiles.
pub const LogFile = struct {
    err_log: ErrorLog = ErrorLog{},
    runstat_log: RunStatLog = RunStatLog{},

    ///This method creates log files.
    pub fn create(self: *LogFile, outdir: *const OutDir) !void {
        const fs = std.fs.cwd();
        const fmt = std.fmt;

        const err_log_name = try fmt.bufPrint(&self.err_log.fmt_buf, "{s}{c}{s}", .{ outdir.err_dir, std.fs.path.sep, "err_log.txt" });
        self.err_log.file = try fs.createFile(err_log_name, .{});

        const runstat_log_name = try fmt.bufPrint(&self.runstat_log.fmt_buf, "{s}{c}{s}", .{ outdir.run_trck, std.fs.path.sep, "run_status.txt" });
        self.runstat_log.file = try fs.createFile(runstat_log_name, .{});
    }
    ///This method close log files.
    pub fn close(self: *LogFile) void {
        self.err_log.file.close();
        self.runstat_log.file.close();
    }
    ///This method creates buffered writers for the log files.
    pub fn writer(self: *LogFile) !void {
        self.err_log.file_writer = self.err_log.file.writer(&self.err_log.log_buf);
        self.err_log.buf_writer = &self.err_log.file_writer.interface;

        self.runstat_log.file_writer = self.runstat_log.file.writer(&self.runstat_log.log_buf);
        self.runstat_log.buf_writer = &self.runstat_log.file_writer.interface;
    }
};
///This is a custom power function for floating point numbers only.
pub fn power(base: f32, exponent: f32) f32 {
    return @exp(exponent * @log(base));
}
