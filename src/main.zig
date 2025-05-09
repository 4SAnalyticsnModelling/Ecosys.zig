const std = @import("std");
const Blkmain = @import("localStructs/blkmain.zig").Blkmain;
const getRunAndLogFileArgs = @import("mainFuncs/getRunAndLogFileArgs.zig").getRunAndLogFileArgs;
const tokenizeLine = @import("ecosysUtils/tokenizeLine.zig").tokenizeLine;
const readLine = @import("ecosysUtils/readLine.zig").readLine;

pub fn main() anyerror!void {
    var buffer: [2048]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buffer);
    const allocator = fba.allocator();

    const input = try getRunAndLogFileArgs(allocator);

    // Create the errorLogfile
    const fs = std.fs.cwd();
    var log = try fs.createFile(input.errorLogFile, .{ .read = false });
    defer log.close();
    const logw = log.writer();

    const file = fs.openFile(input.runFile, .{}) catch |err| {
        try logw.print("error -> Failed to open the runfile: {s}", .{@errorName(err)});
        return;
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
    const line1 = try readLine(file, allocator);
    const tokens1 = try tokenizeLine(line1, allocator);
    defer tokens1.deinit();

    nhw = try std.fmt.parseInt(usize, tokens1.items[0], 10);
    nhe = try std.fmt.parseInt(usize, tokens1.items[1], 10);
    nvn = try std.fmt.parseInt(usize, tokens1.items[2], 10);
    nvs = try std.fmt.parseInt(usize, tokens1.items[3], 10);
    std.debug.print("nhw: {}; nhe: {}; nvn: {}; nvs: {}\n", .{ nhw, nhe, nvn, nvs });

    // Read site file
    const line2 = try readLine(file, allocator);
    const tokens2 = try tokenizeLine(line2, allocator);
    defer tokens2.deinit();

    blkmain.data[0] = tokens2.items[0];
    std.debug.print("blkmain.data[0]: {s}\n", .{blkmain.data[0]});

    // Read topography file
    const line3 = try readLine(file, allocator);
    const tokens3 = try tokenizeLine(line3, allocator);
    defer tokens3.deinit();

    blkmain.data[1] = tokens3.items[0];
    std.debug.print("blkmain.data[1]: {s}\n", .{blkmain.data[1]});

    // Read the number of the model scenarios to be executed
    const line4 = try readLine(file, allocator);
    const tokens4 = try tokenizeLine(line4, allocator);
    defer tokens4.deinit();

    nax = try std.fmt.parseInt(usize, tokens4.items[0], 10);
    ndx = try std.fmt.parseInt(usize, tokens4.items[1], 10);
    std.debug.print("nax: {}; ndx: {}\n", .{ nax, ndx });

    const line5 = try readLine(file, allocator);
    const tokens5 = try tokenizeLine(line5, allocator);
    defer tokens5.deinit();

    nay = try std.fmt.parseInt(u32, tokens5.items[0], 10);
    ndy = try std.fmt.parseInt(u32, tokens5.items[1], 10);
    std.debug.print("nay: {}; ndy: {}\n", .{ nay, ndy });

    for (0..nax) |nex| {
        blkmain.na[nex] = nay;
        blkmain.nd[nex] = ndy;
        std.debug.print("na[nex]: {}; nd[nex]: {}\n", .{ blkmain.na[nex], blkmain.nd[nex] });
    }
}
