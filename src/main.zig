const std = @import("std");
const Blkmain = @import("localStructs/blkmain.zig").Blkmain;
const getRunAndLogFileArgs = @import("mainFuncs/getRunAndLogFileArgs.zig").getRunAndLogFileArgs;
const tokenizeLine = @import("ecosysUtils/tokenizeLine.zig").tokenizeLine;
const readLine = @import("ecosysUtils/readLine.zig").readLine;

pub fn main() anyerror!void {
    var buffer: [10 * 1024]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    const input = try getRunAndLogFileArgs(allocator);

    // Create the errorLogfile
    const fs = std.fs.cwd();
    var log = try fs.createFile(input.errorLogFile, .{ .read = false });
    defer log.close();
    const logw = log.writer();

    const file = fs.openFile(input.runFile, .{}) catch |err| {
        try logw.print("error -> Runfile not found or failed to open the runfile: {s}\n", .{@errorName(err)});
        return error.RunFileNotFoundOrFailedToOpenRunFile;
    };

    defer file.close();

    var blkmain: Blkmain = Blkmain.init();
    var nhe: usize = 0;
    var nhw: usize = 0;
    var nvn: usize = 0;
    var nvs: usize = 0;
    var nax: usize = 0;
    var ndx: usize = 0;
    var nay: u32 = 0;
    var ndy: u32 = 0;

    // Read number of E-W and N-S grid cells
    var line = try readLine(file, allocator);
    defer allocator.free(line);

    var tokens = try tokenizeLine(line, allocator);
    defer tokens.deinit();

    nhw = try std.fmt.parseInt(usize, tokens.items[0], 10);
    nhe = try std.fmt.parseInt(usize, tokens.items[1], 10);
    nvn = try std.fmt.parseInt(usize, tokens.items[2], 10);
    nvs = try std.fmt.parseInt(usize, tokens.items[3], 10);
    std.debug.print("nhw: {}; nhe: {}; nvn: {}; nvs: {}\n", .{ nhw, nhe, nvn, nvs });

    // Read site file
    line = try readLine(file, allocator);
    defer allocator.free(line);

    tokens = try tokenizeLine(line, allocator);
    defer tokens.deinit();

    blkmain.data[0] = tokens.items[0];
    std.debug.print("blkmain.data[0]: {s}\n", .{blkmain.data[0]});

    // Read topography file
    line = try readLine(file, allocator);
    defer allocator.free(line);

    tokens = try tokenizeLine(line, allocator);
    defer tokens.deinit();

    blkmain.data[1] = tokens.items[0];
    std.debug.print("blkmain.data[1]: {s}\n", .{blkmain.data[1]});

    // Read the number of the model scenarios to be executed
    line = try readLine(file, allocator);
    defer allocator.free(line);

    tokens = try tokenizeLine(line, allocator);
    defer tokens.deinit();

    nax = try std.fmt.parseInt(usize, tokens.items[0], 10);
    ndx = try std.fmt.parseInt(usize, tokens.items[1], 10);
    std.debug.print("nax: {}; ndx: {}\n", .{ nax, ndx });

    line = try readLine(file, allocator);
    defer allocator.free(line);

    tokens = try tokenizeLine(line, allocator);
    defer tokens.deinit();

    nay = try std.fmt.parseInt(u32, tokens.items[0], 10);
    ndy = try std.fmt.parseInt(u32, tokens.items[1], 10);
    std.debug.print("nay: {}; ndy: {}\n", .{ nay, ndy });

    // For each scene in each model scenario
    for (0..nax) |nex| {
        blkmain.na[nex] = nay;
        blkmain.nd[nex] = ndy;
        std.debug.print("na[{}]: {}; nd[{}]: {}\n", .{ nex, nex, blkmain.na[nex], blkmain.nd[nex] });

        for (0..blkmain.na[nex]) |ne| {
            // Read weather file
            line = try readLine(file, allocator);
            defer allocator.free(line);

            tokens = try tokenizeLine(line, allocator);
            defer tokens.deinit();

            blkmain.datac[nex][ne][2] = tokens.items[0];
            std.debug.print("datac[{}][{}][2]: {s}\n", .{ nex, ne, blkmain.datac[nex][ne][2] });

            // Read weather options
            line = try readLine(file, allocator);
            defer allocator.free(line);

            tokens = try tokenizeLine(line, allocator);
            defer tokens.deinit();

            blkmain.datac[nex][ne][3] = tokens.items[0];
            std.debug.print("datac[{}][{}][3]: {s}\n", .{ nex, ne, blkmain.datac[nex][ne][3] });

            // Read land management file
            line = try readLine(file, allocator);
            defer allocator.free(line);

            tokens = try tokenizeLine(line, allocator);
            defer tokens.deinit();

            blkmain.datac[nex][ne][8] = tokens.items[0];
            std.debug.print("datac[{}][{}][8]: {s}\n", .{ nex, ne, blkmain.datac[nex][ne][8] });

            // Read plant management file
            line = try readLine(file, allocator);
            defer allocator.free(line);

            tokens = try tokenizeLine(line, allocator);
            defer tokens.deinit();

            blkmain.datac[nex][ne][9] = tokens.items[0];
            std.debug.print("datac[{}][{}][9]: {s}\n", .{ nex, ne, blkmain.datac[nex][ne][9] });

            // Read output control files
            for (20..30) |n| {
                line = try readLine(file, allocator);
                defer allocator.free(line);

                tokens = try tokenizeLine(line, allocator);
                defer tokens.deinit();

                blkmain.datac[nex][ne][n] = tokens.items[0];
                std.debug.print("datac[{}][{}][{}]: {s}\n", .{ nex, ne, n, blkmain.datac[nex][ne][n] });
            }
        }
    }
}
