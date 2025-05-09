const std = @import("std");

pub fn tokenizeLine(line: []const u8, allocator: std.mem.Allocator) anyerror!std.ArrayList([]const u8) {
    var tokensList = std.ArrayList([]const u8).init(allocator);

    var start: usize = 0;
    var i: usize = 0;

    while (i <= line.len) : (i += 1) {
        const atLineEnd: bool = i == line.len;
        const c = if (atLineEnd) 0 else line[i];

        // Treat comma or ASCII whitespace as a delimiter
        if (atLineEnd or c == ',' or std.ascii.isWhitespace(c)) {
            if (start < i) {
                try tokensList.append(line[start..i]);
            }
            start = i + 1;
        }
    }

    return tokensList;
}
