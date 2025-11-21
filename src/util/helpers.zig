const std = @import("std");
/// This struct helps create ecosys output directory tree.
pub const OutDir = struct {
    par_dir: []const u8 = "outputs",
    err_dir: []const u8 = "outputs/error_logs",
    run_trck: []const u8 = "outputs/run_trackers",
    input_chk: []const u8 = "outputs/input_checks",
    outs: []const u8 = "outputs/modeled_outputs",

    fn createDir(path: []const u8) !void {
        const fs = std.fs.cwd();
        fs.deleteTree(path) catch {};
        try fs.makeDir(path);
    }

    pub fn mkOutDirs(self: OutDir) !void {
        try createDir(self.par_dir);
        try createDir(self.err_dir);
        try createDir(self.run_trck);
        try createDir(self.input_chk);
        try createDir(self.outs);
    }
};
///This struct helps writing out error and run status logfiles.
pub const LogFile = struct {
    err_buf: [1024]u8 = undefined,
    run_stat_buf: [1024]u8 = undefined,
    err_log_buf: [1024]u8 = undefined,
    run_stat_log_buf: [1024]u8 = undefined,
    err_log: std.fs.File = undefined,
    run_stat_log: std.fs.File = undefined,
    buf_err_log_writer: std.fs.File.Writer = undefined,
    buffered_err_log_writer: *std.Io.Writer = undefined,
    buf_run_stat_log_writer: std.fs.File.Writer = undefined,
    buffered_run_stat_log_writer: *std.Io.Writer = undefined,

    pub fn create(self: *LogFile, outdir: OutDir) !void {
        var fs = std.fs.cwd();
        const err_log_name = try std.fmt.bufPrint(&self.err_buf, "{s}{c}{s}", .{ outdir.err_dir, std.fs.path.sep, "err_log.txt" });
        self.err_log = try fs.createFile(err_log_name, .{});
        const run_stat_log_name = try std.fmt.bufPrint(&self.run_stat_buf, "{s}{c}{s}", .{ outdir.run_trck, std.fs.path.sep, "run_status.txt" });
        self.run_stat_log = try fs.createFile(run_stat_log_name, .{});
    }

    pub fn close(self: *LogFile) void {
        self.err_log.close();
        self.run_stat_log.close();
    }

    pub fn writer(self: *LogFile) !void {
        self.buf_err_log_writer = self.err_log.writer(&self.err_log_buf);
        self.buffered_err_log_writer = &self.buf_err_log_writer.interface;
        self.buf_run_stat_log_writer = self.run_stat_log.writer(&self.run_stat_log_buf);
        self.buffered_run_stat_log_writer = &self.buf_run_stat_log_writer.interface;
    }
};
///This is a custom power function for floating point numbers only.
pub fn power(base: f32, exponent: f32) f32 {
    return @exp(exponent * @log(base));
}
