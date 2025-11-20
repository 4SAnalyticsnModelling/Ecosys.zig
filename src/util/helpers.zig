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
///This struct helps writing out model input check files.
pub const OutFile = struct {
    buf: [1024]u8 = undefined,
    err_log: std.fs.File = undefined,
    run_log: std.fs.File = undefined,
    run_stat_log: std.fs.File = undefined,
    land_unit_log: std.fs.File = undefined,
    soil_log: std.fs.File = undefined,
    wthr_log: std.fs.File = undefined,
    plant_spp_log: std.fs.File = undefined,
    agr_silv_past_op_log: std.fs.File = undefined,
    till_log: std.fs.File = undefined,
    fert_log: std.fs.File = undefined,
    irrig_log: std.fs.File = undefined,
    daily_c_out_log: std.fs.File = undefined,
    daily_wtr_out_log: std.fs.File = undefined,
    daily_n_out_log: std.fs.File = undefined,
    daily_p_out_log: std.fs.File = undefined,
    daily_heat_out_log: std.fs.File = undefined,
    hrly_c_out_log: std.fs.File = undefined,
    hrly_wtr_out_log: std.fs.File = undefined,
    hrly_n_out_log: std.fs.File = undefined,
    hrly_p_out_log: std.fs.File = undefined,
    hrly_heat_out_log: std.fs.File = undefined,

    pub fn mkOutFiles(self: *OutFile, outdir: OutDir) !void {
        var fs = std.fs.cwd();
        const err_log_name = try std.fmt.bufPrint(&self.buf, "{s}{c}{s}", .{ outdir.err_dir, std.fs.path.sep, "err_log_file.txt" });
        self.err_log = try fs.createFile(err_log_name, .{});
        const run_log_name = try std.fmt.bufPrint(&self.buf, "{s}{c}{s}", .{ outdir.input_chk, std.fs.path.sep, "runscript_check.txt" });
        self.run_log = try fs.createFile(run_log_name, .{});
        const run_stat_log_name = try std.fmt.bufPrint(&self.buf, "{s}{c}{s}", .{ outdir.run_trck, std.fs.path.sep, "run_status.txt" });
        self.run_stat_log = try fs.createFile(run_stat_log_name, .{});
    }
};
///This is a custom power function for floating point numbers only.
pub fn power(base: f32, exponent: f32) f32 {
    return @exp(exponent * @log(base));
}
