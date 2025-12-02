///This module contains helper functions to be used throughout other modules
const std = @import("std");
const config = @import("config");
const max_path_len = config.filepathx;
const max_io_buf = 1024;

///This struct helps create ecosys output directory tree
pub const OutDir = struct {
    par_dir: []const u8 = "outputs",
    err_dir: []const u8 = "outputs/error_logs",
    run_trck: []const u8 = "outputs/run_trackers",
    input_chk: []const u8 = "outputs/input_checks",
    outs: []const u8 = "outputs/modeled_outputs",
    ///This method creates a directory by forcing deletion of the previous version (if any) of the same directory
    fn createDir(path: []const u8) !void {
        const fs = std.fs.cwd();
        fs.deleteTree(path) catch {};
        try fs.makeDir(path);
    }
    ///This method creates all ecosys output directories
    pub fn mkOutDirs(self: *const OutDir) !void {
        try createDir(self.par_dir);
        try createDir(self.err_dir);
        try createDir(self.run_trck);
        try createDir(self.input_chk);
        try createDir(self.outs);
    }
};
///File reader
pub const FileReader = struct {
    read_buf: [max_io_buf]u8 = undefined,
    file: std.fs.File = undefined,
    file_reader: std.fs.File.Reader = undefined,
    buf_reader: *std.Io.Reader = undefined,

    ///Opens a file to read
    pub fn open(self: *FileReader, err_log: *std.Io.Writer, file_to_open: []const u8) !void {
        self.file = std.fs.cwd().openFile(file_to_open, .{ .mode = .read_only }) catch |err| {
            try err_log.print("error: {s} while opening {s} in read only mode\n", .{ @errorName(err), file_to_open });
            std.debug.print("\x1b[1;31merror: {s} while opening {s} in read only mode\x1b[0m\n", .{ @errorName(err), file_to_open });
            return err;
        };
    }
    ///Closes a file once done reading
    pub fn close(self: *FileReader) void {
        self.file.close();
    }
    ///Buffered file reader
    pub fn reader(self: *FileReader) void {
        self.file_reader = self.file.reader(&self.read_buf);
        self.buf_reader = &self.file_reader.interface;
    }
};
///File writer
pub const FileWriter = struct {
    write_buf: [max_io_buf]u8 = undefined,
    file: std.fs.File = undefined,
    file_writer: std.fs.File.Writer = undefined,
    buf_writer: *std.Io.Writer = undefined,
    err_log: *std.Io.Writer = undefined,
    is_err_log: bool = true,

    ///Create a file to write
    pub fn create(self: *FileWriter, file_to_open: []const u8) !void {
        self.file = std.fs.cwd().createFile(file_to_open, .{}) catch |err| {
            if (self.is_err_log == false) {
                try self.err_log.print("error: {s} while creating {s} in write mode\n", .{ @errorName(err), file_to_open });
            }
            std.debug.print("\x1b[1;31merror: {s} while creating {s} in write mode\x1b[0m\n", .{ @errorName(err), file_to_open });
            return err;
        };
    }
    ///Closes a file once done writing
    pub fn close(self: *FileWriter) void {
        self.file.close();
    }
    ///Buffered file writer
    pub fn writer(self: *FileWriter) void {
        self.file_writer = self.file.writer(&self.write_buf);
        self.buf_writer = &self.file_writer.interface;
    }
};
///Error log struct
pub const ErrorLog = struct {
    fmt_buf: [max_path_len]u8 = undefined,
    file_writer: FileWriter = FileWriter{},

    ///Initialize error_log
    pub fn init(self: *ErrorLog, outdir: *OutDir) !void {
        const err_log_name = try std.fmt.bufPrint(&self.fmt_buf, "{s}{c}{s}", .{ outdir.err_dir, std.fs.path.sep, "err_log.txt" });
        try self.file_writer.create(err_log_name);
    }
};
///Run status tracker log struct
pub const RunStatLog = struct {
    fmt_buf: [max_path_len]u8 = undefined,
    file_writer: FileWriter = FileWriter{},
    ///Initialize error_log;
    pub fn init(self: *ErrorLog, outdir: *OutDir) !void {
        const runstat_log_name = try std.fmt.bufPrint(&self.fmt_buf, "{s}{c}{s}", .{ outdir.run_trck, std.fs.path.sep, "run_status.txt" });
        try self.file_writer.create(runstat_log_name);
    }
};
///This is a custom power function for floating point numbers (f32 & f64) only
pub fn power(comptime T: type, base: T, exponent: T) T {
    if (T != f32 and T != f64) {
        @compileError("power function not implemented for " ++ @typeName(T)); //returns compile error for types other than f32 & f64
    }
    return @exp(exponent * @log(base));
}
test "custom power function for f32 & f64" {
    try std.testing.expectEqual(@as(f32, 4.0), power(f32, 2.0, 2.0));
    try std.testing.expectEqual(@as(f64, 4.0), power(f64, 2.0, 2.0));
}
