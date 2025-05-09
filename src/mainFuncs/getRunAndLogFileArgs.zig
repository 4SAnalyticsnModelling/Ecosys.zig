const std = @import("std");

pub fn getRunAndLogFileArgs(allocator: std.mem.Allocator) anyerror!struct {
    runFile: []const u8,
    errorLogFile: []const u8,
} {
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 3) {
        std.debug.print(
            "error -> Missing Arguments. Ecosys job submission format should be: {s} <runFile> <errorLogFile>\n",
            .{args[0]},
        );
        return error.MissingArguments;
    }

    return .{
        .runFile = args[1],
        .errorLogFile = args[2],
    };
}
