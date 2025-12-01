///This module contains input parser helper methods to be used throughout other moduels
const std = @import("std");
const config = @import("config");
const utils = @import("utils.zig");
const max_path_len = config.filepathx;
const max_io_buf = 1024;
const max_tok_num = 256;
const FileReader = utils.FileReader;

///This struct helps check ecosys run submission arguments and parse the runfile name
pub const RunArg = struct {
    runfile_name: [max_path_len]u8 = undefined,
    file_reader: FileReader = FileReader{},

    ///This method gets the runfile name from run submission args
    pub fn getRunfile(self: *RunArg) ![]const u8 {
        const fba = std.heap.FixedBufferAllocator;
        var args_buf: [max_io_buf]u8 = undefined;
        var fba_args = fba.init(&args_buf);
        const allocator_args = fba_args.allocator();
        const args = try std.process.argsAlloc(allocator_args); //use of allocator is required for windows os. So allocator less option is not feasible in this case
        defer std.process.argsFree(allocator_args, args);
        if (args.len < 2) {
            std.debug.print(
                "\x1b[1;31merror -> Missing Arguments. Ecosys job submission format should be: {s} <runfile>\x1b[0m\n",
                .{args[0]},
            );
            return error.MissingArguments;
        }
        if (args[1].len >= self.runfile_name.len) {
            return error.RunfilePathTooLong;
        }
        @memcpy(self.runfile_name[0..args[1].len], args[1]);
        return self.runfile_name[0..args[1].len];
    }
};
const TokenErrors = error{
    TooManyTokens,
    TokenCountMismatch,
    PrintFailed,
    OutOfBounds,
    InvalidCharacter,
};
///This is a helper struct to tokenize items in a read line
pub const Tokens = struct {
    items: [max_tok_num][]const u8 = undefined, //using []const u8 since it's a pointer to actual line, not a storage, short-lived but memory efficient
    len: usize = 0,
    ///This method resets tokens
    pub fn reset(self: *Tokens) void {
        self.len = 0;
        self.items = undefined;
    }
    ///Logs an token count mismatch error to both err_log and stdout
    fn logTokenCountMismatch(comptime err: anyerror, err_log: *std.Io.Writer, context: []const u8, file_name: []const u8) TokenErrors!void {
        err_log.print("error: {s} while reading {s} in {s}\n", .{ @errorName(err), context, file_name }) catch {
            return error.PrintFailed;
        };
        err_log.flush() catch {
            return error.PrintFailed;
        };
        std.debug.print("\x1b[1;31merror: {s} while reading {s} in {s}\x1b[0m\n", .{ @errorName(err), context, file_name });
    }
    ///Checks token length, logs and returns error on mismatch
    fn expectsTokenLen(tok_len: usize, expected: usize, context: []const u8, file_name: []const u8, err_log: *std.Io.Writer) TokenErrors!void {
        if (tok_len != expected) {
            const err = error.TokenCountMismatch;
            try logTokenCountMismatch(err, err_log, context, file_name);
            return err;
        }
    }
    ///This method parses a line into a list of numbers/strings (called tokens hereafter) by eliminating spaces, tabs, or commas between tokens
    pub fn tokenizeLine(self: *Tokens, line: []const u8, expected: usize, context: []const u8, file_name: []const u8, err_log: *std.Io.Writer) TokenErrors!void {
        self.reset();
        var it = std.mem.tokenizeAny(u8, line, " \r\n");
        while (it.next()) |tok| {
            if (self.len >= self.items.len) {
                return error.TooManyTokens;
            }
            self.items[self.len] = tok;
            self.len += 1;
        }
        try expectsTokenLen(self.len, expected, context, file_name, err_log);
    }
    ///This method checks min max bounds for grids, plants, scenes etc.
    pub fn boundsCheck(conds: anytype, context: []const u8, file_name: []const u8, err_log: *std.Io.Writer) TokenErrors!void {
        inline for (conds) |ok| { // comptile unrolling, so don't use this method if there's a lot of conditions
            if (ok) {
                const err = error.OutOfBounds;
                try logTokenCountMismatch(err, err_log, context, file_name);
                return err;
            }
        }
    }
    ///This method logs parsing of strings => integer errors.
    pub fn parseTokToInt(comptime T: type, tok: []const u8, context: []const u8, file_name: []const u8, err_log: *std.Io.Writer) TokenErrors!T {
        return std.fmt.parseInt(T, tok, 10) catch {
            const err = error.InvalidCharacter;
            try logTokenCountMismatch(err, err_log, context, file_name);
            return err;
        };
    }
    ///This method logs parsing of strings => float errors.
    pub fn parseTokToFloat(comptime T: type, tok: []const u8, context: []const u8, file_name: []const u8, err_log: *std.Io.Writer) TokenErrors!T {
        return std.fmt.parseFloat(T, tok) catch {
            const err = error.InvalidCharacter;
            try logTokenCountMismatch(err, err_log, context, file_name);
            return err;
        };
    }
};
///File path check error set
const FilePathErrors = error{
    FilePathTooLong,
    PrintFailed,
};
///Check file path length
pub fn filePathLenCheck(path_len: usize, max_allowable_len: usize, context: []const u8, file_name: []const u8, err_log: *std.Io.Writer) FilePathErrors!void {
    if (path_len >= max_allowable_len) {
        const err = error.FilePathTooLong;
        err_log.print("error: {s} while reading {s} in {s}\n", .{ @errorName(err), context, file_name }) catch {
            return error.PrintFailed;
        };
        err_log.flush() catch {
            return error.PrintFailed;
        };
        std.debug.print("\x1b[1;31merror: {s} while reading {s} in {s}\x1b[0m\n", .{ @errorName(err), context, file_name });
        return err;
    }
}
