const std = @import("std");
const config = @import("config");
const Blk1u = @import("globalStructs/blk1u.zig").Blk1u;

pub fn modifyBlk1u(blk1u: *Blk1u) void {
        blk1u.tkcz[0][0][0] = 3.0;
	reModifyBlk1u(blk1u);
    }

pub fn reModifyBlk1u(blk1u: *Blk1u) void {
        blk1u.tkcz[0][0][0] += 6.0;
    }

pub fn main() anyerror!void {
    const stdout = std.io.getStdOut().writer();
    var blk1u = Blk1u.init();

    try stdout.print("Initial blk1u.tkcz[0][0][0]: {}\n", .{blk1u.tkcz[0][0][0]});

    modifyBlk1u(&blk1u);

    try stdout.print("Modified blk1u.tkcz[0][0][0]: {}\n", .{blk1u.tkcz[0][0][0]});
    try stdout.print("ewgridsmax (jx): {}\n", .{config.ewgridsmax});
}
