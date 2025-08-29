const std = @import("std");
const Blk8a = @import("../globalStructs/blk8a.zig").Blk8a;
const powf = @import("../ecosysUtils/powerFunc.zig").powf;
const offset: u32 = 1;
/// This function calculates derived soil properties from input soil properties.
pub fn calcDerivedSoilPropertiesFromInput(logFileWriter: *std.Io.Writer, blk8a: *Blk8a, nx: usize, ny: usize) !void {
    // Log error message if this function fails
    errdefer {
        const err = error.FunctionFailed_calcDerivedSoilPropertiesFromInput;
        logFileWriter.print("error: {s}\n", .{@errorName(err)}) catch {};
        logFileWriter.flush() catch {};
        std.debug.print("error: {s}\n", .{@errorName(err)});
    }
    for (0..blk8a.nl[ny][nx]) |l| {
        blk8a.bkds[nx][ny][l + offset] = blk8a.bkdsi[nx][ny][l];
        if (blk8a.bkds[nx][ny][l + offset] == 0.0) {
            blk8a.fhol[nx][ny][l] = 0.0;
        }
        blk8a.fmpr[nx][ny][l + offset] = (1.0 - blk8a.rock[nx][ny][l]) * (1.0 - blk8a.fhol[nx][ny][l]); // fmpr = micropore or soil matrix fraction excluding rocks and macropores.
        blk8a.scnv[nx][ny][l + offset] *= 0.098 * blk8a.fmpr[nx][ny][l + offset]; // vertical Ksat converted to m2 MPa-1 h-1.
        blk8a.scnh[nx][ny][l] *= 0.098 * blk8a.fmpr[nx][ny][l + offset]; // lateral Ksat converted to m2 MPa-1 h-1.
        blk8a.cclay[nx][ny][l] = @max(0.0, 1e3 - (blk8a.csand[nx][ny][l] + blk8a.csilt[nx][ny][l]));
        blk8a.corgc[nx][ny][l + offset] *= 1e3; // SOC converted to g Mg-1.
        blk8a.corgr[nx][ny][l + offset] *= 1e3; // POC converted to g Mg-1.
        blk8a.corgci[nx][ny][l] = blk8a.corgc[nx][ny][l + offset];
        blk8a.fholi[nx][ny][l] = blk8a.fhol[nx][ny][l];
        blk8a.csand[nx][ny][l] *= 1e-3 * @max(0.0, (1.0 - blk8a.corgc[nx][ny][l + offset] / 0.55e6)); // sand content converted to g Mg-1 and corrected for SOC.
        blk8a.csilt[nx][ny][l] *= 1e-3 * @max(0.0, (1.0 - blk8a.corgc[nx][ny][l + offset] / 0.55e6)); // silt content converted to g Mg-1 and corrected for SOC.
        blk8a.cclay[nx][ny][l] *= 1e-3 * @max(0.0, (1.0 - blk8a.corgc[nx][ny][l + offset] / 0.55e6)); // Clay content converted to g Mg-1 and corrected for SOC.
        blk8a.cec[nx][ny][l] *= 10.0; // CEC converted to mol Mg-1.
        blk8a.aec[nx][ny][l] *= 10.0; // AEC converted to mol Mg-1.
        // All solute concentrations below converted to mol Mg-1.
        blk8a.cnh4[nx][ny][l] /= 14.0;
        blk8a.cno3[nx][ny][l] /= 14.0;
        blk8a.cpo4[nx][ny][l] /= 31.0;
        blk8a.cal[nx][ny][l] /= 27.0;
        blk8a.cfe[nx][ny][l] /= 56.0;
        blk8a.cca[nx][ny][l] /= 40.0;
        blk8a.cmg[nx][ny][l] /= 24.3;
        blk8a.cna[nx][ny][l] /= 23.0;
        blk8a.cka[nx][ny][l] /= 39.1;
        blk8a.cso4[nx][ny][l] /= 32.0;
        blk8a.ccl[nx][ny][l] /= 35.5;
        blk8a.calpo[nx][ny][l] /= 31.0;
        blk8a.cfepo[nx][ny][l] /= 31.0;
        blk8a.ccapd[nx][ny][l] /= 31.0;
        blk8a.ccaph[nx][ny][l] /= 31.0 * 3.0;
        blk8a.caloh[nx][ny][l] /= 27.0;
        blk8a.cfeoh[nx][ny][l] /= 56.0;
        blk8a.ccaco[nx][ny][l] /= 40.0;
        blk8a.ccaso[nx][ny][l] /= 40.0;
        // Estimate SON, SOP, and CEC if unknown
        // Source: Biochemistry 130:117-131
        if (blk8a.corgn[nx][ny][l + offset] < 0.0) {
            blk8a.corgn[nx][ny][l + offset] = @min(0.125 * blk8a.corgc[nx][ny][l + offset], 8.9e2 * powf(blk8a.corgc[nx][ny][l + offset] / 1e4, 0.80));
        }
        if (blk8a.corgp[nx][ny][l + offset] < 0.0) {
            blk8a.corgp[nx][ny][l + offset] = @min(0.0125 * blk8a.corgc[nx][ny][l + offset], 1.2e2 * powf(blk8a.corgc[nx][ny][l + offset] / 1.0e4, 0.52));
        }
        if (blk8a.cec[nx][ny][l] < 0.0) {
            blk8a.cec[nx][ny][l] = 10.0 * (200.0 * 2.0 * blk8a.corgc[nx][ny][l + offset] / 1.0e6 + 80.0 * blk8a.cclay[nx][ny][l] + 20.0 * blk8a.csilt[nx][ny][l] + 5.0 * blk8a.csand[nx][ny][l]);
        }
    }
    blk8a.corgc[nx][ny][0] = 0.55e6;
    blk8a.fmpr[nx][ny][0] = 1.0;
}
