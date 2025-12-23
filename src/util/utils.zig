///This module contains helper functions to be used throughout other modules
const std = @import("std");
const print = std.debug.print;
const max_io_buf = 10 * 1024;
const max_path_len = 1024;

///This struct helps create ecosys output directory tree
pub const OutDir = struct {
    par_dir: []const u8 = "outputs",
    data_bin_dir: []const u8 = "tiles",
    err_dir: []const u8 = "outputs/error_logs",
    run_trck: []const u8 = "outputs/run_trackers",
    outs: []const u8 = "outputs/modeled_outputs",
    ///This method creates a directory only if there is no existing previous version of it
    fn createDir(path: []const u8) !void {
        std.fs.cwd().makePath(path) catch |err| switch (err) {
            error.PathAlreadyExists => return,
            else => return err,
        };
    }
    ///This method creates all ecosys output directories
    pub fn mkOutDirs(self: *const OutDir) !void {
        try createDir(self.par_dir);
        try createDir(self.err_dir);
        try createDir(self.run_trck);
        try createDir(self.data_bin_dir);
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
            print("\x1b[1;31merror:\x1b[0m {s} while opening {s} in read only mode\n", .{ @errorName(err), file_to_open });
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
            print("\x1b[1;31merror:\x1b[0m {s} while creating {s} in write mode\n", .{ @errorName(err), file_to_open });
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
    try std.testing.expectApproxEqAbs(@as(f32, 0.72478), power(f32, 0.2, 0.2), 0.0001);
}
///Convert geographical to XY coordinates
pub fn toXY(geo_ud: i32, min_geo_ud: i32, dgeo_ud: i32) usize {
    const result = @divFloor(geo_ud - min_geo_ud, dgeo_ud);
    return @intCast(result);
}
test "toXY from lat lon" {
    const lat_ud: i32 = 53_546_100; // 53.5461 deg
    const lon_ud: i32 = -113_493_800; // -113.4938 deg
    const min_lat_ud: i32 = 53_000_000; // 53.0000 deg
    const min_lon_ud: i32 = -114_000_000; // -114.0000 deg
    const dlat_ud: i32 = 10_000; // 0.01 deg
    const dlon_ud: i32 = 10_000; // 0.01 deg

    try std.testing.expectEqual(@as(usize, 54), toXY(lat_ud, min_lat_ud, dlat_ud));
    try std.testing.expectEqual(@as(usize, 50), toXY(lon_ud, min_lon_ud, dlon_ud));
}
///Morton (z-order) indexing, interleave bits of a 16-bit integer with zeros: abcdef -> a0b0c0d0e0f0
fn part1by1(x_in: u32) u32 {
    var x = x_in & 0x0000_FFFF;
    x = (x | (x << 8)) & 0x00FF_00FF;
    x = (x | (x << 4)) & 0x0F0F_0F0F;
    x = (x | (x << 2)) & 0x3333_3333;
    x = (x | (x << 1)) & 0x5555_5555;
    return x;
}
///Morton id from x, y coordinates
pub fn morton2D(x: usize, y: usize) usize {
    // valid for x,y up to 65535 (more than enough here)
    const xx: u32 = @intCast(x);
    const yy: u32 = @intCast(y);
    const m: u32 = (part1by1(xx) | (part1by1(yy) << 1));
    return @intCast(m);
}
test "morton2D basics and bit interleave" {
    try std.testing.expectEqual(@as(usize, 0), morton2D(0, 0));
    try std.testing.expectEqual(@as(usize, 1), morton2D(1, 0)); //x=0001(1), y=0000(0) => 0b0000_0001(1)
    try std.testing.expectEqual(@as(usize, 2), morton2D(0, 1)); //x=0000(0), y=0001(1) => 0b0000_0010(2)
    try std.testing.expectEqual(@as(usize, 14), morton2D(2, 3)); //x=0010(2), y=0011(3) => 0b0000_1110(14)
    try std.testing.expectEqual(@as(usize, 0xFFFF_FFFF), morton2D(65535, 65535));
}
///Flat 1D id to x, y coordinates
pub fn flatIdToXY(id: usize, nx_ny: usize) struct { x: usize, y: usize } {
    return .{ .x = id % nx_ny, .y = id / nx_ny };
}
test "flatIdToXY row/column mapping" {
    const nx: usize = 5;
    try std.testing.expectEqual(@as(usize, 0), flatIdToXY(0, nx).x);
    try std.testing.expectEqual(@as(usize, 0), flatIdToXY(0, nx).y);

    try std.testing.expectEqual(@as(usize, nx - 1), flatIdToXY(nx - 1, nx).x);
    try std.testing.expectEqual(@as(usize, 0), flatIdToXY(nx - 1, nx).y);

    try std.testing.expectEqual(@as(usize, 0), flatIdToXY(nx, nx).x);
    try std.testing.expectEqual(@as(usize, 1), flatIdToXY(nx, nx).y);

    const p = flatIdToXY(17, nx);
    try std.testing.expectEqual(@as(usize, 2), p.x);
    try std.testing.expectEqual(@as(usize, 3), p.y);
}
///Morton id from flat 1D id
pub fn mortonId(id: usize, nx_ny: usize) usize {
    const p = flatIdToXY(id, nx_ny);
    return morton2D(p.x, p.y);
}
test "mortonId matches morton2D(flatIdToXY)" {
    const nx: usize = 4;
    var id: usize = 0;
    while (id < nx * nx) : (id += 1) {
        const p = flatIdToXY(id, nx);
        try std.testing.expectEqual(morton2D(p.x, p.y), mortonId(id, nx));
    }

    try std.testing.expectEqual(morton2D(nx - 1, 0), mortonId(nx - 1, nx));
    try std.testing.expectEqual(morton2D(0, 1), mortonId(nx, nx));
}
///Check if an integer is a power of two
pub fn requirePowerOfTwo(n: usize) !void {
    if (n == 0 or (n & (n - 1)) != 0) {
        return error.NotPowerOfTwoTileSpecsNotValid;
    }
}
test "requirePowerOfTwo accepts powers of two and rejects others" {
    // ok cases
    try requirePowerOfTwo(1);
    try requirePowerOfTwo(2);
    try requirePowerOfTwo(4);
    try requirePowerOfTwo(8);
    try requirePowerOfTwo(16);
    try requirePowerOfTwo(64);

    // error cases
    try std.testing.expectError(error.NotPowerOfTwoTileSpecsNotValid, requirePowerOfTwo(0));
    try std.testing.expectError(error.NotPowerOfTwoTileSpecsNotValid, requirePowerOfTwo(3));
    try std.testing.expectError(error.NotPowerOfTwoTileSpecsNotValid, requirePowerOfTwo(6));
    try std.testing.expectError(error.NotPowerOfTwoTileSpecsNotValid, requirePowerOfTwo(12));
}
///Convert n-dimensional ids to flat ids
pub fn toFlatId(comptime ndims: usize, shape: [ndims]usize, indices: [ndims]usize) usize {
    var idx: usize = 0;
    inline for (indices, 0..) |iv, k| {
        const dim = shape[k];
        if (k == 0) idx = iv else idx = idx * dim + iv;
    }
    return idx;
}
test "toFlatId row-major mapping" {
    // 2D: shape 4x3
    const shape2 = .{ 4, 3 };
    try std.testing.expectEqual(@as(usize, 0), toFlatId(2, shape2, .{ 0, 0 }));
    try std.testing.expectEqual(@as(usize, 3), toFlatId(2, shape2, .{ 1, 0 }));
    try std.testing.expectEqual(@as(usize, 11), toFlatId(2, shape2, .{ 3, 2 })); // last cell

    // 3D: shape 2x3x4
    const shape3 = .{ 2, 3, 4 };
    // ((0 * 3) + 2) * 4 + 1 = 9
    try std.testing.expectEqual(@as(usize, 9), toFlatId(3, shape3, .{ 0, 2, 1 }));
    // ((1 * 3) + 2) * 4 + 3 = 23 (last cell)
    try std.testing.expectEqual(@as(usize, 23), toFlatId(3, shape3, .{ 1, 2, 3 }));
}
