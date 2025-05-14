const std = @import("std");
const Blk2a = @import("../globalStructs/blk2a.zig").Blk2a;
const Blkc = @import("../globalStructs/blkc.zig").Blkc;
const Blkmain = @import("../localStructs/blkmain.zig").Blkmain;
const readLine = @import("../ecosysUtils/readLine.zig").readLine;
const tokenizeLine = @import("../ecosysUtils/tokenizeLine.zig").tokenizeLine;
const flatIndex = @import("../ecosysUtils/flatIndex.zig").flatIndex;
const dylnFunc = @import("dylnFunc.zig").dylnFunc;
/// This function reads site cluster data
pub fn readSiteFile(allocator: std.mem.Allocator, logFileWriter: std.fs.File.Writer, siteClusterName: []const u8, blk2a: *Blk2a, blkc: *Blkc) anyerror!void {
    // alatg, altig, atcag = latitude, altitude, mat(deg c)
    // idtblg = water table flag
    //   0 = none
    //   1,2 = natural stationary, mobile
    //   3,4 = artificial stationary, mobile
    // oxyeg, z2geg, co2eig, ch4eg, z2oeg, znh3eg = atm o2, n2, co2, ch4, n2o, nh3 (ppm)
    // ietypg, isaltg, iersng = koppen climate zone, salt, erosion options
    // ncng = 1: lateral connections between grid cells, 3: no connections
    // dtblig, dtbldig = depth of natural, artificial water table (idtblg)
    // dtblgg = slope of natural water table relative to landscape surface
    // rchqng, rchqeg, rchqsg, rchqwg = boundary condns for n, e, s, w surface runoff
    // rchgnug, rchgeug, rchgsug, rchgwug = boundary condns for n, e, s, w subsurface flow
    // rchgntg, rchgetg, rchgstg, rchgwtg = n, e, s, w distance to water table (m)
    // rchgdg = lower boundary conditions for water flow
    // dhi = width of each w-e landscape column
    // dvi = width of each n-s landscape row
    // iersng = erosion options
    //   0 = allow freeze-thaw to change elevation
    //   1 = allow freeze-thaw plus erosion to change elevation
    //   2 = allow freeze-thaw plus soc accumulation to change elevation
    //   3 = allow freeze-thaw plus soc accumulation plus erosion to change elevation
    //   -1 = no change in elevation
    //
    // Open site cluster file
    const fs = std.fs.cwd();
    const siteClusterFile = fs.openFile(siteClusterName, .{}) catch |err| {
        try logFileWriter.print("error -> Site cluster file not found or failed to open the site cluster file: {s}\n", .{@errorName(err)});
        return error.SiteClusterFileNotFoundOrFailedToOpenSiteClusterFile;
    };
    defer siteClusterFile.close();
    var nh1: u32 = 0;
    var nh2: u32 = 0;
    var nv1: u32 = 0;
    var nv2: u32 = 0;
    var xi: u32 = 0;
    var alatg: f32 = 0.0;
    var altig: f32 = 0.0;
    var atcag: f32 = 0.0;
    var idtblg: u32 = 0;
    var oxyeg: f32 = 0.0;
    var z2geg: f32 = 0.0;
    var co2eig: f32 = 0.0;
    var ch4eg: f32 = 0.0;
    var z2oeg: f32 = 0.0;
    var znh3eg: f32 = 0.0;
    var ietypg: u32 = 0;
    var isaltg: u32 = 0;
    var iersng: i32 = 0;
    var ncng: u32 = 0;
    var dtblig: f32 = 0.0;
    var dtbldig: f32 = 0.0;
    var dtblgg: f32 = 0.0;
    var rchqng: f32 = 0.0;
    var rchqeg: f32 = 0.0;
    var rchqsg: f32 = 0.0;
    var rchqwg: f32 = 0.0;
    var rchgnug: f32 = 0.0;
    var rchgeug: f32 = 0.0;
    var rchgsug: f32 = 0.0;
    var rchgwug: f32 = 0.0;
    var rchgntg: f32 = 0.0;
    var rchgetg: f32 = 0.0;
    var rchgstg: f32 = 0.0;
    var rchgwtg: f32 = 0.0;
    var rchgdg: f32 = 0.0;
    var dhi: f32 = 0.0;
    var dvi: f32 = 0.0;
    // Read grid position of each site in the site cluster file
    while (true) {
        var line = readLine(siteClusterFile, allocator) catch break; // break out of the loop at the EOF.
        var tokens = try tokenizeLine(line, allocator);
        nh1 = try std.fmt.parseInt(u32, tokens.items[0], 10) - 1;
        nv1 = try std.fmt.parseInt(u32, tokens.items[1], 10) - 1;
        nh2 = try std.fmt.parseInt(u32, tokens.items[2], 10);
        nv2 = try std.fmt.parseInt(u32, tokens.items[3], 10);
        allocator.free(line);
        tokens.deinit();
        // Read each site file in the site cluster
        line = try readLine(siteClusterFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        const siteFileName: []const u8 = tokens.items[0];
        const siteFile = fs.openFile(siteFileName, .{}) catch |err| {
            try logFileWriter.print("error -> Site file not found or failed to open the site file: {s}\n", .{@errorName(err)});
            return error.SiteFileNotFoundOrFailedToOpenSiteFile;
        };
        defer siteFile.close();
        allocator.free(line);
        tokens.deinit();
        line = try readLine(siteFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        alatg = try std.fmt.parseFloat(f32, tokens.items[0]);
        altig = try std.fmt.parseFloat(f32, tokens.items[1]);
        atcag = try std.fmt.parseFloat(f32, tokens.items[2]);
        idtblg = try std.fmt.parseInt(u32, tokens.items[3], 10);
        allocator.free(line);
        tokens.deinit();
        line = try readLine(siteFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        oxyeg = try std.fmt.parseFloat(f32, tokens.items[0]);
        z2geg = try std.fmt.parseFloat(f32, tokens.items[1]);
        co2eig = try std.fmt.parseFloat(f32, tokens.items[2]);
        ch4eg = try std.fmt.parseFloat(f32, tokens.items[3]);
        z2oeg = try std.fmt.parseFloat(f32, tokens.items[4]);
        znh3eg = try std.fmt.parseFloat(f32, tokens.items[5]);
        allocator.free(line);
        tokens.deinit();
        line = try readLine(siteFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        ietypg = try std.fmt.parseInt(u32, tokens.items[0], 10);
        isaltg = try std.fmt.parseInt(u32, tokens.items[1], 10);
        iersng = try std.fmt.parseInt(i32, tokens.items[2], 10);
        ncng = try std.fmt.parseInt(u32, tokens.items[3], 10);
        dtblig = try std.fmt.parseFloat(f32, tokens.items[4]);
        dtbldig = try std.fmt.parseFloat(f32, tokens.items[5]);
        dtblgg = try std.fmt.parseFloat(f32, tokens.items[6]);
        allocator.free(line);
        tokens.deinit();
        line = try readLine(siteFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        rchqng = try std.fmt.parseFloat(f32, tokens.items[0]);
        rchqeg = try std.fmt.parseFloat(f32, tokens.items[1]);
        rchqsg = try std.fmt.parseFloat(f32, tokens.items[2]);
        rchqwg = try std.fmt.parseFloat(f32, tokens.items[3]);
        rchgnug = try std.fmt.parseFloat(f32, tokens.items[4]);
        rchgeug = try std.fmt.parseFloat(f32, tokens.items[5]);
        rchgsug = try std.fmt.parseFloat(f32, tokens.items[6]);
        rchgwug = try std.fmt.parseFloat(f32, tokens.items[7]);
        rchgntg = try std.fmt.parseFloat(f32, tokens.items[8]);
        rchgetg = try std.fmt.parseFloat(f32, tokens.items[9]);
        rchgstg = try std.fmt.parseFloat(f32, tokens.items[10]);
        rchgwtg = try std.fmt.parseFloat(f32, tokens.items[11]);
        rchgdg = try std.fmt.parseFloat(f32, tokens.items[12]);
        allocator.free(line);
        tokens.deinit();
        line = try readLine(siteFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        dhi = try std.fmt.parseFloat(f32, tokens.items[0]);
        dvi = try std.fmt.parseFloat(f32, tokens.items[1]);
        allocator.free(line);
        tokens.deinit();
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                // Assign topography and environmental parameters
                blkc.alat[nx][ny] = alatg;
                blk2a.alti[nx][ny] = altig;
                blk2a.atcai[nx][ny] = atcag;
                blk2a.idtbl[nx][ny] = idtblg;
                blk2a.oxye[nx][ny] = oxyeg;
                blk2a.z2ge[nx][ny] = z2geg;
                blk2a.co2ei[nx][ny] = co2eig;
                blk2a.ch4e[nx][ny] = ch4eg;
                blk2a.z2oe[nx][ny] = z2oeg;
                blk2a.znh3e[nx][ny] = znh3eg;
                blkc.ietyp[nx][ny] = ietypg;
                blkc.ncn[nx][ny] = ncng;
                blk2a.dtbli[nx][ny] = dtblig;
                blk2a.dtbldi[nx][ny] = dtbldig;
                blk2a.dtblg[nx][ny] = dtblgg;
                blk2a.rchqn[nx][ny] = rchqng;
                blk2a.rchqe[nx][ny] = rchqeg;
                blk2a.rchqs[nx][ny] = rchqsg;
                blk2a.rchqw[nx][ny] = rchqwg;
                blk2a.rchgnu[nx][ny] = rchgnug;
                blk2a.rchgeu[nx][ny] = rchgeug;
                blk2a.rchgsu[nx][ny] = rchgsug;
                blk2a.rchgwu[nx][ny] = rchgwug;
                blk2a.rchgnt[nx][ny] = rchgntg;
                blk2a.rchget[nx][ny] = rchgetg;
                blk2a.rchgst[nx][ny] = rchgstg;
                blk2a.rchgwt[nx][ny] = rchgwtg;
                blk2a.rchgd[nx][ny] = rchgdg;
                blk2a.dh[nx][ny] = dhi;
                blk2a.dv[nx][ny] = dvi;
                blk2a.co2e[nx][ny] = blk2a.co2ei[nx][ny];
                blk2a.h2ge[nx][ny] = 1.0e-03;
                std.debug.print("dh[{}][{}]: {}, dv[{}][{}]: {}\n", .{ nx, ny, blk2a.dh[nx][ny], nx, ny, blk2a.dv[nx][ny] });
                std.debug.print("alti[{}][{}]: {}\n", .{ nx, ny, blk2a.alti[nx][ny] });
                // Calculate maximum daylenth for plant phenology
                // dylm = maximum daylength (h)
                if (blkc.alat[nx][ny] > 0.0) {
                    xi = 173;
                } else {
                    xi = 356;
                }
                blkc.dylm[nx][ny] = try dylnFunc(blkc, xi, nx, ny);
            }
        }
    }
}
