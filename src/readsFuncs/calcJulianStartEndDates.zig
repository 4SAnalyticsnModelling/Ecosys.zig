const std = @import("std");
const Blkc = @import("../globalStructs/blkc.zig").Blkc;
const Blk17 = @import("../globalStructs/blk17.zig").Blk17;
const Blkmain = @import("../localStructs/blkmain.zig").Blkmain;
const Files = @import("../globalStructs/files.zig").Files;

pub fn calcJulianStartEndDates(blk17: *Blk17, blkc: *Blkc, blkmain: *Blkmain, files: *Files, nScenario: u32) !void {
    blkc.lyrc = 365;
    blkc.lyrx = 365;

    const listId: [3]usize = .{ 0, 3, 6 };

    for (listId) |n0| {
        const n: u32 = @intCast(n0);
        const day: i32 = @intCast(files.idata[n]);
        const month: i32 = @intCast(files.idata[n + 1]);
        const year: i32 = @intCast(files.idata[n + 2]);
        const prevMonth: i32 = month - 1;
        const prevMonthId: usize = @intCast(prevMonth);
        const prevYear: i32 = year - 1;

        blkc.lpy = 0;
        if (@mod(year, 4) == 0) {
            if (month > 2) blkc.lpy = 1;
            if (n0 == 0) blkc.lyrc = 366;
        }

        var idy: i32 = undefined;

        if (month == 1) {
            idy = day;
        } else {
            idy = 30 * prevMonth + blk17.icor[prevMonthId] + day + blkc.lpy;
        }
        const idyU32: u32 = @intCast(idy);
        if (n0 == 0) blkc.istart = idyU32;
        if (n0 == 3) blkc.ifin = idyU32;
        if (n0 == 6) blkc.irun = idyU32;

        if (@mod(prevYear, 4) == 0) {
            if (n0 == 0) blkc.lyrx = 366;
        }
    }

    if (nScenario == 0) {
        if (std.mem.eql(u8, blkmain.data[20], "no")) {
            blkc.irun = blkc.istart;
        }
        blkmain.nscene = 1;
        blkc.ilast = blkc.istart - 1;
        blkc.iterm = blkc.ifin;
    } else {
        blkmain.nscene = 2;
        blkc.ilast = @min(blkc.istart - 1, @min(blkc.iterm, blkc.iend));
        blkc.iterm = blkc.ifin;
    }
    // std.debug.print("istart {}, ifin {}, irun {}, ilast {}, iterm {}\n", .{ blkc.istart, blkc.ifin, blkc.irun, blkc.ilast, blkc.iterm });
}
