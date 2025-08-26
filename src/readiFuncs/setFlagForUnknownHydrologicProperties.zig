const std = @import("std");
const Blk8a = @import("../globalStructs/blk8a.zig").Blk8a;
const Blkc = @import("../globalStructs/blkc.zig").Blkc;
/// This function sets flag if field capacity, wilting point, and/or vertical and lateral saturated hydraulic conductivity data is unknown.
pub fn setFlagForUnknownHydrologicProperties(logFileWriter: *std.Io.Writer, blk8a: *Blk8a, blkc: *Blkc, nx: usize, ny: usize) anyerror!void {
    // Log error message if this function fails
    errdefer {
        const err = error.FunctionFailed_setFlagForUnknownHydrologicProperties;
        logFileWriter.print("error: {s}\n", .{@errorName(err)}) catch {};
        std.debug.print("error: {s}\n", .{@errorName(err)});
    }
    for (blk8a.nu[ny][nx]..blk8a.nm[ny][nx]) |l| {
        // Set flag for unknown field capacity
        if (blk8a.fc[nx][ny][l] < 0.0) {
            blkc.isoil[nx][ny][0][l] = 1;
            blk8a.psifc[nx][ny] = -0.033;
        } else {
            blkc.isoil[nx][ny][0][l] = 0;
        }
        // Set flag for unknown wilting point
        if (blk8a.wp[nx][ny][l] < 0.0) {
            blkc.isoil[nx][ny][1][l] = 1;
            blk8a.psiwp[nx][ny] = -1.5;
        } else {
            blkc.isoil[nx][ny][1][l] = 0;
        }
        // Set flag for unknown saturated vertical hydraulic conductivity
        if (blk8a.scnv[nx][ny][l] < 0.0) {
            blkc.isoil[nx][ny][2][l] = 1;
        } else {
            blkc.isoil[nx][ny][2][l] = 0;
        }
        // Set flag for unknown saturated lateral hydraulic conductivity
        if (blk8a.scnh[nx][ny][l] < 0.0) {
            blkc.isoil[nx][ny][3][l] = 1;
        } else {
            blkc.isoil[nx][ny][3][l] = 0;
        }
    }
}
