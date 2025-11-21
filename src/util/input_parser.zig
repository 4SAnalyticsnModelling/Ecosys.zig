const std = @import("std");
///This struct helps check ecosys run submission arguments and parse the runfile name.
pub const RunArg = struct {
    run_buf: [1024]u8 = undefined,
    read_buf: [1024]u8 = undefined,
    run: []const u8 = undefined,
    runfile: std.fs.File = undefined,
    buf_reader: std.fs.File.Reader = undefined,
    buffered_reader: *std.Io.Reader = undefined,
    ///This method gets the runfile name from run submission args.
    pub fn getRunfile(self: *RunArg) !void {
        const fba = std.heap.FixedBufferAllocator;
        var args_buf: [1024]u8 = undefined;
        var fba_args = fba.init(&args_buf);
        const allocator_args = fba_args.allocator();
        const args = try std.process.argsAlloc(allocator_args);
        defer std.process.argsFree(allocator_args, args);
        if (args.len < 2) {
            std.debug.print(
                "\x1b[1;31merror -> Missing Arguments. Ecosys job submission format should be: {s} <runfile>\x1b[0m\n",
                .{args[0]},
            );
            return error.MissingArguments;
        }
        const src: []const u8 = args[1];
        if (src.len > self.run_buf.len) {
            return error.RunfileNameTooLong;
        }
        const dst = self.run_buf[0..src.len];
        @memcpy(dst, src);
        self.run = dst;
    }
    ///This method opens the runfile.
    pub fn open(self: *RunArg) !void {
        self.runfile = try std.fs.cwd().openFile(self.run, .{});
    }
    ///This method closes the runfile.
    pub fn close(self: *RunArg) void {
        self.runfile.close();
    }
    ///This method sets up a buffered reader interface for reading the runfile.
    pub fn reader(self: *RunArg) !void {
        self.buf_reader = self.runfile.reader(&self.read_buf);
        self.buffered_reader = &self.buf_reader.interface;
    }
};
///This is a helper struct to tokenize items in a read line.
pub const Tokens = struct {
    items: [128][]const u8 = undefined,
    len: usize = 0,
    ///This method resets tokens.
    pub fn reset(self: *Tokens) void {
        self.len = 0;
        self.items = undefined;
    }
    ///This method parses a line into a list of numbers/strings (called tokens hereafter) by eliminating spaces, tabs, or commas between tokens.
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
