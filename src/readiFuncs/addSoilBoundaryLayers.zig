const std = @import("std");
const config = @import("config");
const jz = config.soillayersmax;
const Blk8a = @import("../globalStructs/blk8a.zig").Blk8a;
const Blkc = @import("../globalStructs/blkc.zig").Blkc;
/// This function calculates derived soil properties from input soil properties.
pub fn addSoilBoundaryLayers(logFileWriter: std.fs.File.Writer, blk8a: *Blk8a, blkc: *Blkc, nx: usize, ny: usize) anyerror!void {
    // Log error message if this function fails
    errdefer {
        const err = error.FunctionFailed_addSoilBoundaryLayers;
        logFileWriter.print("error: {s}\n", .{@errorName(err)}) catch {};
        std.debug.print("error: {s}\n", .{@errorName(err)});
    }
    for (blk8a.nm[nx][ny]..jz) |l| {
        blk8a.cdpth[nx][ny][l] = 2.0 * blk8a.cdpth[nx][ny][l - 1] - blk8a.cdpth[nx][ny][l - 2];
        blk8a.bkdsi[nx][ny][l] = blk8a.bkdsi[nx][ny][l - 1];
        blk8a.fc[nx][ny][l] = blk8a.fc[nx][ny][l - 1];
        blk8a.wp[nx][ny][l] = blk8a.wp[nx][ny][l - 1];
        blk8a.scnv[nx][ny][l] = blk8a.scnv[nx][ny][l - 1];
        blk8a.scnh[nx][ny][l] = blk8a.scnh[nx][ny][l - 1];
        blk8a.csand[nx][ny][l] = blk8a.csand[nx][ny][l - 1];
        blk8a.csilt[nx][ny][l] = blk8a.csilt[nx][ny][l - 1];
        blk8a.cclay[nx][ny][l] = blk8a.cclay[nx][ny][l - 1];
        blk8a.fhol[nx][ny][l] = blk8a.fhol[nx][ny][l - 1];
        blk8a.rock[nx][ny][l] = blk8a.rock[nx][ny][l - 1];
        blk8a.ph[nx][ny][l] = blk8a.ph[nx][ny][l - 1];
        blk8a.cec[nx][ny][l] = blk8a.cec[nx][ny][l - 1];
        blk8a.aec[nx][ny][l] = blk8a.aec[nx][ny][l - 1];
        blk8a.corgc[nx][ny][l] = 0.25 * blk8a.corgc[nx][ny][l - 1];
        blk8a.corgr[nx][ny][l] = 0.25 * blk8a.corgr[nx][ny][l - 1];
        blk8a.corgn[nx][ny][l] = 0.25 * blk8a.corgn[nx][ny][l - 1];
        blk8a.corgp[nx][ny][l] = 0.25 * blk8a.corgp[nx][ny][l - 1];
        blk8a.cnh4[nx][ny][l] = blk8a.cnh4[nx][ny][l - 1];
        blk8a.cno3[nx][ny][l] = blk8a.cno3[nx][ny][l - 1];
        blk8a.cpo4[nx][ny][l] = blk8a.cpo4[nx][ny][l - 1];
        blk8a.cal[nx][ny][l] = blk8a.cal[nx][ny][l - 1];
        blk8a.cfe[nx][ny][l] = blk8a.cfe[nx][ny][l - 1];
        blk8a.cca[nx][ny][l] = blk8a.cca[nx][ny][l - 1];
        blk8a.cmg[nx][ny][l] = blk8a.cmg[nx][ny][l - 1];
        blk8a.cna[nx][ny][l] = blk8a.cna[nx][ny][l - 1];
        blk8a.cka[nx][ny][l] = blk8a.cka[nx][ny][l - 1];
        blk8a.cso4[nx][ny][l] = blk8a.cso4[nx][ny][l - 1];
        blk8a.ccl[nx][ny][l] = blk8a.ccl[nx][ny][l - 1];
        blk8a.caloh[nx][ny][l] = blk8a.caloh[nx][ny][l - 1];
        blk8a.cfeoh[nx][ny][l] = blk8a.cfeoh[nx][ny][l - 1];
        blk8a.ccaco[nx][ny][l] = blk8a.ccaco[nx][ny][l - 1];
        blk8a.ccaso[nx][ny][l] = blk8a.ccaso[nx][ny][l - 1];
        blk8a.calpo[nx][ny][l] = blk8a.calpo[nx][ny][l - 1];
        blk8a.cfepo[nx][ny][l] = blk8a.cfepo[nx][ny][l - 1];
        blk8a.ccapd[nx][ny][l] = blk8a.ccapd[nx][ny][l - 1];
        blk8a.ccaph[nx][ny][l] = blk8a.ccaph[nx][ny][l - 1];
        blk8a.gkc4[nx][ny][l] = blk8a.gkc4[nx][ny][l - 1];
        blk8a.gkch[nx][ny][l] = blk8a.gkch[nx][ny][l - 1];
        blk8a.gkca[nx][ny][l] = blk8a.gkca[nx][ny][l - 1];
        blk8a.gkcm[nx][ny][l] = blk8a.gkcm[nx][ny][l - 1];
        blk8a.gkcn[nx][ny][l] = blk8a.gkcn[nx][ny][l - 1];
        blk8a.gkck[nx][ny][l] = blk8a.gkck[nx][ny][l - 1];
        blk8a.thw[nx][ny][l] = blk8a.thw[nx][ny][l - 1];
        blk8a.thi[nx][ny][l] = blk8a.thi[nx][ny][l - 1];
        blkc.isoil[nx][ny][l][0] = blkc.isoil[nx][ny][l - 1][0];
        blkc.isoil[nx][ny][l][1] = blkc.isoil[nx][ny][l - 1][1];
        blkc.isoil[nx][ny][l][2] = blkc.isoil[nx][ny][l - 1][2];
        blkc.isoil[nx][ny][l][3] = blkc.isoil[nx][ny][l - 1][3];
        blk8a.rsc[nx][ny][l][1] = 0.0;
        blk8a.rsn[nx][ny][l][1] = 0.0;
        blk8a.rsp[nx][ny][l][1] = 0.0;
        blk8a.rsc[nx][ny][l][0] = 0.0;
        blk8a.rsn[nx][ny][l][0] = 0.0;
        blk8a.rsp[nx][ny][l][0] = 0.0;
        blk8a.rsc[nx][ny][l][2] = 0.0;
        blk8a.rsn[nx][ny][l][2] = 0.0;
        blk8a.rsp[nx][ny][l][2] = 0.0;
    }
}
