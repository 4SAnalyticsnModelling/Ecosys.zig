const std = @import("std");
const Filec = @import("../globalStructs/filec.zig").Filec;
const Files = @import("../globalStructs/files.zig").Files;
const Blkc = @import("../globalStructs/blkc.zig").Blkc;
const Blk17 = @import("../globalStructs/blk17.zig").Blk17;
const Blkmain = @import("../localStructs/blkmain.zig").Blkmain;
const mainUtils = @import("../mainFuncs/mainUtils.zig");
const copyTo = mainUtils.copyTo;

pub fn runEcosys(runFilePath: []const u8) !void {
    const fs = std.fs.cwd();
    const allocator = std.heap.pageAllocator;

    // initialize preallocated structs
    // var filec = Filec.init();
    // var files = Files.init();
    // var blkc = Blkc.init();
    // const blk17 = Blk17.init();
    // var blkmain = Blkmain.init();
    //
    // open file and set up buffered reader
    const file = try fs.openFile(runFilePath, .{ .read = true });
    defer file.close();
    var reader = std.io.BufferedReader(file.reader()).reader();

    // collect tokens from each line until the end of run file (EOF)
    var tokensList = std.ArrayList([]u8).init(allocator);
    defer tokensList.deinit();
    var lineBuf = std.ArrayList([]u8).init(allocator);
    defer lineBuf.deinit();

    while (true) {
        // read a line (including newline) or break on EOF
        try reader.readUntilDelimiterAlloc(allocator, &lineBuf, 1024) catch |err| {
            if (err == std.io.Error.EndOfStream) {
                break;
            } else {
                return err;
            }
        };
        // tokenize this line
        const line = lineBuf.items;
        var start: usize = 0;
        var i: usize = 0;

        while (i <= line.len) : (i += 1) {
            const atEnd = i == line.len;
            const c = if (atEnd) 0 else line[i];
            // treat comma or any ASCII whitespace as a delimiter
            if (atEnd or c == ',' or std.ascii.isSpace(c)) {
                if (start < i) {
                    // append non-empty token
                    try tokensList.append(line[start..i]);
                }
                start = i + 1;
                lineBuf.clear();
            }
        }

        // now parse collected tokens
        const tokens = tokensList.items;
        var ti: usize = 0;
        std.debug.print("tokens: {}\n", .{tokens[ti]});
        ti += 1;

        // }
        // }
        // for (_: usize = 0; _ < @intCast(usize, nd[nex]); _ += 1) {
        //     for (nex: usize = 0; nex < @intCast(usize, nax); nex += 1) {
        //         for (nt: usize = 0; nt < @intCast(usize, nd[nex]); nt += 1) {
        //             for (ne: usize = 0; ne < @intCast(usize, na[nex]); ne += 1) {
        //                 try soil(&na, &nd, nt+1, ne+1, nax, ndx, _, nex, nhw, nhe, nvn, nvs);
        //                 igo += 1;
        //             }
        //         }
        //     }
        // }
    }
}
