const std = @import("std");
///This struct helps check ecosys run submission arguments and read the runfile name.
pub const RunArg = struct {
    buf: [1024]u8 = undefined,
    run: []const u8 = undefined,
    runfile: std.fs.File = undefined,

    pub fn getRunfile(self: *RunArg) !void {
        const fba = std.heap.FixedBufferAllocator;
        var args_buf: [1024]u8 = undefined;
        var fba_args = fba.init(&args_buf);
        const allocator_args = fba_args.allocator();
        const args = try std.process.argsAlloc(allocator_args);
        defer std.process.argsFree(allocator_args, args);
        if (args.len < 2) {
            std.debug.print(
                "error -> Missing Arguments. Ecosys job submission format should be: {s} <runFile>\n",
                .{args[0]},
            );
            return error.MissingArguments;
        }
        const src: []const u8 = args[1];
        if (src.len > self.buf.len) {
            return error.RunfileNameTooLong;
        }
        const dst = self.buf[0..src.len];
        @memcpy(dst, src);
        self.run = dst;
    }

    pub fn open(self: *RunArg) !void {
        self.runfile = try std.fs.cwd().openFile(self.run, .{});
    }

    pub fn close(self: *RunArg) void {
        self.runfile.close();
    }
};
///This is a helper struct for file read.
pub const FileReader = struct {
    buf: [1024]u8 = undefined,
    buf_reader: std.fs.File.Reader = undefined,

    pub fn reader(self: *FileReader, file: std.fs.File) *std.Io.Reader {
        self.buf_reader = file.reader(&self.buf);
        return &self.buf_reader.interface;
    }
};
///This is a helper struct for file write.
pub const FileWriter = struct {
    buf: [1024]u8 = undefined,
    buf_writer: std.fs.File.Writer = undefined,

    pub fn writer(self: *FileWriter, file: std.fs.File) *std.Io.Writer {
        self.buf_writer = file.writer(&self.buf);
        return &self.buf_writer.interface;
    }
};
///This is a helper struct to tokenize items in a read line.
pub const Tokens = struct {
    items: [128][]const u8 = undefined,
    len: usize = 0,

    pub fn reset(self: *Tokens) void {
        self.len = 0;
        self.items = undefined;
    }
    pub fn tokenizeLine(self: *Tokens, line: []const u8) !void {
        self.reset();
        var it = std.mem.tokenizeAny(u8, line, " \r\n");
        while (it.next()) |tok| {
            if (self.len > self.items.len) {
                return error.TooManyTokens;
            }
            self.items[self.len] = tok;
            self.len += 1;
        }
    }
};
