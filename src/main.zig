const std = @import("std");
const config = @import("../build.zig");

pub fn main() anyerror!void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("ewgridsmax (jx): {}\n", .{config.jx});
    try stdout.print("nsgridsmax (jy): {}\n", .{config.jy});
    try stdout.print("soillayermax (jz): {}\n", .{config.jz});
    try stdout.print("pftmax (jp): {}\n", .{config.jp});
    try stdout.print("jh: {}\n", .{config.jh});
    try stdout.print("jv: {}\n", .{config.jv});
    try stdout.print("jd: {}\n", .{config.jd});
    try stdout.print("jc: {}\n", .{config.jc});
    try stdout.print("js: {}\n", .{config.js});
}
