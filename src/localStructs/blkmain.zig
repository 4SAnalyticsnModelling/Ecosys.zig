const std = @import("std");
const config = @import("config");
const jx = config.ewgridsmax;
const jy = config.nsgridsmax;
const jp = config.pftmax;

pub const Blkmain = struct {
    datac: [250][250][30][]const u8 = undefined,
    outfilp: [jx][jy][jp][10][]const u8 = undefined,
    datap: [jx][jy][jp][]const u8 = undefined,
    datam: [jx][jy][jp][]const u8 = undefined,
    dataz: [jx][jy][jp][]const u8 = undefined,
    outfils: [jx][jy][10][]const u8 = undefined,
    data: [30][]const u8 = undefined,
    datax: [jp][]const u8 = undefined,
    datay: [jp][]const u8 = undefined,
    outs: [10][]const u8 = undefined,
    outp: [10][]const u8 = undefined,
    choice: [20][102][]const u8 = undefined,
    na: [250]u32 = [_]u32{0} ** 250,
    nd: [250]u32 = [_]u32{0} ** 250,
    cdate: []const u8 = undefined,

    pub fn init() Blkmain {
        return .{};
    }
};
