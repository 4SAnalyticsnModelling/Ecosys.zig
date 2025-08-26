const std = @import("std");

pub fn readLine(reader: *std.Io.Reader) ![]const u8 {
    return reader.takeDelimiterExclusive('\n');
}
