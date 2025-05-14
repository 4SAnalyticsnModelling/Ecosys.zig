const std = @import("std");

pub fn getRunAndLogFileArgs(allocator: std.mem.Allocator) anyerror![]const u8 {
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        std.debug.print(
            "error -> Missing Arguments. Ecosys job submission format should be: {s} <runFile>\n",
            .{args[0]},
        );
        return error.MissingArgument;
    }

    return args[1];
}
