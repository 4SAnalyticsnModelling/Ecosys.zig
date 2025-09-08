const std = @import("std");
const Blkc = @import("../globalStructs/blkc.zig").Blkc;
const Files = @import("../globalStructs/files.zig").Files;
const Blkmain = @import("../localStructs/blkmain.zig").Blkmain;

/// This function sets the increments in start and end dates for successive scenarios from loops for scenes, scenarios in runscript
pub fn setDateIncrement(blkc: *Blkc, files: *Files, nay: u32, nScenario: u32) !void {
    files.idata[2] += nay * nScenario;
    files.idata[5] = files.idata[2];
    blkc.iyrc = files.idata[2];
    // std.debug.print("start year: {d}; end year: {d}\n", .{ files.idata[2], files.idata[5] });
}
