const std = @import("std");

///This function opens a file.
pub fn open(file_name: []const u8, err_log: *std.Io.Writer) !std.fs.File {
    const in_file = std.fs.cwd().openFile(file_name, .{}) catch |err| {
        try err_log.print("error: In {s} -> {s}.\n", .{ file_name, @errorName(err) });
        try err_log.flush();
        std.debug.print("error: In {s} -> {s}.\n", .{ file_name, @errorName(err) });
        return err;
    };
    return in_file;
}
