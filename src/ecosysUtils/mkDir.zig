const std = @import("std");

pub fn mkDir(path: []const u8) anyerror!void {
    const cwd = std.fs.cwd();
    var dir = cwd.openDir(path, .{}) catch |err| {
        if (err == error.PathNotFound) {
            try cwd.makeDir(path);
            return;
        } else {
            try cwd.deleteTree(path);
            try cwd.makeDir(path);
            return;
        }
    };
    defer dir.close();
}
