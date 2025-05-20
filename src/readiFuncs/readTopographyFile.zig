const std = @import("std");
const config = @import("config");
const jz = config.soillayersmax;
const Blk11a = @import("../globalStructs/blk11a.zig").Blk11a;
const Blk2a = @import("../globalStructs/blk2a.zig").Blk2a;
const Blk8a = @import("../globalStructs/blk8a.zig").Blk8a;
const Blk8b = @import("../globalStructs/blk8b.zig").Blk8b;
const readLine = @import("../ecosysUtils/readLine.zig").readLine;
const tokenizeLine = @import("../ecosysUtils/tokenizeLine.zig").tokenizeLine;
const parseTokenToInt = @import("../ecosysUtils/parseTokenToInt.zig").parseTokenToInt;
const parseTokenToFloat = @import("../ecosysUtils/parseTokenToFloat.zig").parseTokenToFloat;
/// This function reads topography data
pub fn readTopographyFile(allocator: std.mem.Allocator, logFileWriter: std.fs.File.Writer, topographyName: []const u8, blk11a: *Blk11a, blk2a: *Blk2a, blk8a: *Blk8a, blk8b: *Blk8b, nhw: u32, nvn: u32, nhe: u32, nvs: u32) anyerror!void {
    // Log error message if this function fails
    errdefer {
        const err = error.FunctionFailed_readTopographyFile;
        logFileWriter.print("error: {s}\n", .{@errorName(err)}) catch {};
        std.debug.print("error: {s}\n", .{@errorName(err)});
    }
    // Open topography file
    const fs = std.fs.cwd();
    const topographyFile = fs.openFile(topographyName, .{}) catch |err| {
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        return error.TopographyFileNotFoundOrFailedToOpenTopographyFile;
    };
    defer topographyFile.close();
    // Create a log file to write topography file inputs to check if they are all appropriately read
    var logTopofile = try fs.createFile("outputs/checkPointLogs/topographyFileInputCheckLog", .{ .read = false });
    defer logTopofile.close();
    const logTopo = logTopofile.writer();
    const ixtyp1flag: [12][]const u8 = .{ "other/default", "maize", "wheat", "soybean", "new straw", "old straw", "compost", "green manure", "new deciduous", "new coniferous", "old deciduous", "old coniferous" };
    const ixtyp2flag: [3][]const u8 = .{ "other/default", "ruminant", "non-ruminant" };
    const isoilrflag: [2][]const u8 = .{ "natural", "reconstructed" };
    var gridCount: u32 = 0;
    while (true) {
        var line = readLine(topographyFile, allocator) catch break; // break out of the loop at the EOF.
        var tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 7) {
            const err = error.InvalidInputInTopographyFileLine1;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        // Read grid cell positions in W, N, E, and S direction
        const nh1 = try parseTokenToInt(u32, error.InvalidGridCellPositionInTopographyFile_W, tokens.items[0], logFileWriter) - 1;
        const nv1 = try parseTokenToInt(u32, error.InvalidGridCellPositionInTopographyFile_N, tokens.items[1], logFileWriter) - 1;
        const nh2 = try parseTokenToInt(u32, error.InvalidGridCellPositionInTopographyFile_E, tokens.items[2], logFileWriter);
        const nv2 = try parseTokenToInt(u32, error.InvalidGridCellPositionInTopographyFile_S, tokens.items[3], logFileWriter);
        try logTopo.print("=> Grid cell positions: W: {}, N: {}, E: {}, S: {}.\n", .{ nh1, nv1, nh2, nv2 });
        if (nh1 > nh2 or nv1 > nv2 or nh1 < nhw or nh2 > nhe or nv1 < nvn or nv2 > nvs) {
            const err = error.InvalidInputForGridCellPositionsInTopographyFile;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                // Read aspect in degrees
                blk2a.asp[nx][ny] = try parseTokenToFloat(f32, error.InvalidAspectInTopographyFile, tokens.items[4], logFileWriter);
                // Read slope in degrees
                blk2a.sl[nx][ny] = try parseTokenToFloat(f32, error.InvalidSlopeInTopographyFile, tokens.items[5], logFileWriter);
                // Read initial snowpack depth (cm)
                blk11a.dpths[nx][ny] = try parseTokenToFloat(f32, error.InvalidInitSnowDpthInTopographyFile, tokens.items[6], logFileWriter);
                try logTopo.print("=> Grid cell position W-E: {}, N-S: {}, aspect: {d} degree, slope: {d} degree, initial snowpack depth: {d} cm.\n", .{ nx, ny, blk2a.asp[nx][ny], blk2a.sl[nx][ny], blk11a.dpths[nx][ny] });
            }
        }
        allocator.free(line);
        tokens.deinit();
        // Read each soil file in the topography file
        line = try readLine(topographyFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 1) {
            const err = error.InvalidInputForSoilFileNameInTopographyFile;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        const soilFileName: []const u8 = tokens.items[0];
        const soilFile = fs.openFile(soilFileName, .{}) catch |err| {
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return error.SoilFileNotFoundOrFailedToOpenSoilFile;
        };
        defer soilFile.close();
        allocator.free(line);
        tokens.deinit();
        line = try readLine(soilFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 20) {
            const err = error.InvalidInputSoilFileLine1;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                // Read water potential at field capacity (MPa)
                blk8a.psifc[nx][ny] = try parseTokenToFloat(f32, error.InvalidWaterPotentialAtFieldCapacity, tokens.items[0], logFileWriter);
                // Read water potential at wilting point (Mpa)
                blk8a.psiwp[nx][ny] = try parseTokenToFloat(f32, error.InvalidWaterPotentialAtWiltingPoint, tokens.items[1], logFileWriter);
                // Read wet soil albedo
                blk8a.albs[nx][ny] = try parseTokenToFloat(f32, error.InvalidWetSoilAlbedo, tokens.items[2], logFileWriter);
                // Read litter pH
                blk8a.ph[nx][ny][0] = try parseTokenToFloat(f32, error.InvalidLitterpH, tokens.items[3], logFileWriter);
                // Read C in fine surface litter (g m-2)
                blk8a.rsc[nx][ny][0][1] = try parseTokenToFloat(f32, error.InvalidCarbonInFineSurfaceLitter, tokens.items[4], logFileWriter);
                // Read N in fine surface litter (g m-2)
                blk8a.rsn[nx][ny][0][1] = try parseTokenToFloat(f32, error.InvalidNitrogenInFineSurfaceLitter, tokens.items[5], logFileWriter);
                // Read P in fine surface litter (g m-2)
                blk8a.rsp[nx][ny][0][1] = try parseTokenToFloat(f32, error.InvalidPhosphorusInFineSurfaceLitter, tokens.items[6], logFileWriter);
                // Read C in woody surface litter (g m-2)
                blk8a.rsc[nx][ny][0][0] = try parseTokenToFloat(f32, error.InvalidCarbonInWoodySurfaceLitter, tokens.items[7], logFileWriter);
                // Read N in woody surface litter (g m-2)
                blk8a.rsn[nx][ny][0][0] = try parseTokenToFloat(f32, error.InvalidNitrogenInWoodySurfaceLitter, tokens.items[8], logFileWriter);
                // Read P in woody surface litter (g m-2)
                blk8a.rsp[nx][ny][0][0] = try parseTokenToFloat(f32, error.InvalidPhosphorusInWoodySurfaceLitter, tokens.items[9], logFileWriter);
                // Read C in manure surface litter (g m-2)
                blk8a.rsc[nx][ny][0][2] = try parseTokenToFloat(f32, error.InvalidCarbonInManureSurfaceLitter, tokens.items[10], logFileWriter);
                // Read N in manure surface litter (g m-2)
                blk8a.rsn[nx][ny][0][2] = try parseTokenToFloat(f32, error.InvalidNitrogenInManureSurfaceLitter, tokens.items[11], logFileWriter);
                // Read P in manure surface litter (g m-2)
                blk8a.rsp[nx][ny][0][2] = try parseTokenToFloat(f32, error.InvalidPhosphorusInManureSurfaceLitter, tokens.items[12], logFileWriter);
                // Read plant litter type (e.g. maize, wheat, deciduous, coniferous etc. denoted by integer flags)
                blk8b.ixtyp[nx][ny][0] = try parseTokenToInt(u32, error.InvalidPlantLitterType, tokens.items[13], logFileWriter);
                if (blk8b.ixtyp[nx][ny][0] > 11) blk8b.ixtyp[nx][ny][0] = 0;
                blk8b.ixtyp[nx][ny][0] = @max(0, blk8b.ixtyp[nx][ny][0]);
                // Read manure type (e.g. ruminant, non-ruminant etc. denoted by integer flags)
                blk8b.ixtyp[nx][ny][1] = try parseTokenToInt(u32, error.InvalidManureType, tokens.items[14], logFileWriter);
                if (blk8b.ixtyp[nx][ny][1] > 2) blk8b.ixtyp[nx][ny][1] = 0;
                blk8b.ixtyp[nx][ny][1] = @max(0, blk8b.ixtyp[nx][ny][1]);
                // Read layer number for soil surface layer
                blk8a.nui[nx][ny] = try parseTokenToInt(u32, error.InvalidNumberOfSoilSurfaceLayer, tokens.items[15], logFileWriter);
                blk8a.nu[nx][ny] = blk8a.nui[nx][ny];
                // Read layer number for maximum rooting layer
                blk8a.nj[nx][ny] = try parseTokenToInt(u32, error.InvalidNumberOfMaximumRootingLayer, tokens.items[16], logFileWriter);
                blk8a.nk[nx][ny] = blk8a.nj[nx][ny] + 1;
                // Read number of soil layers below rooting depth (nj) with data in soil file
                const nl1 = try parseTokenToInt(u32, error.InvalidNumberOfLayersBelowRootingDepthWithData, tokens.items[17], logFileWriter);
                // Read number of soil layers below rooting depth (nj) without data in soil file
                const nl2 = try parseTokenToInt(u32, error.InvalidNumberOfLayersBelowRootingDepthWithoutData, tokens.items[18], logFileWriter);
                // Read natural(0) or reconstructed(1) soil profile
                blk8a.isoilr[nx][ny] = try parseTokenToInt(u32, error.InvalidNaturalOrReconstructedSoilProfileFlag, tokens.items[19], logFileWriter);
                if (blk8a.isoilr[nx][ny] > 1) {
                    const err = error.InvalidNaturalOrReconstructedSoilProfileFlag;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                blk8a.nm[nx][ny] = blk8a.nj[nx][ny] + nl1;
                blk8a.nli[nx][ny] = blk8a.nm[nx][ny] + nl2;
                if (blk8a.nli[nx][ny] >= jz) {
                    const err = error.TotalNumberOfVerticalSoilLayerExceedsMaximumSoilLayerAllowedDuringCompilation;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                blk8a.nl[nx][ny] = blk8a.nli[nx][ny];
                try logTopo.print("=> [Start of {s} file] grid cell position W-E: {}, N-S: {}, water potential at field capacity: {d} MPa, water potential at wilting point: {d} MPa, wet soil albedo: {d}, litter pH: {d}, C: {} gm-2, N :{} gm-2, P: {} gm-2 in fine surface litter, C: {} gm-2, N: {} gm-2, P: {} gm-2 in woody surface litter, C: {} gm-2, N: {} gm-2, P: {} gm-2 in manure surface litter, plant surface litter type: {s}, animal surface litter type: {s}, soil surface layer #: {}, maximum rooting layer #: {}, # of additional soil layer below maximum rooting layer (with data): {}, # of additional soil layer below maximum rooting layer (without data): {}, soil profile type: {s}.\n", .{ soilFileName, nx, ny, blk8a.psifc[nx][ny], blk8a.psiwp[nx][ny], blk8a.albs[nx][ny], blk8a.ph[nx][ny][0], blk8a.rsc[nx][ny][0][1], blk8a.rsn[nx][ny][0][1], blk8a.rsp[nx][ny][0][1], blk8a.rsc[nx][ny][0][0], blk8a.rsn[nx][ny][0][0], blk8a.rsp[nx][ny][0][0], blk8a.rsc[nx][ny][0][2], blk8a.rsn[nx][ny][0][2], blk8a.rsp[nx][ny][0][2], ixtyp1flag[blk8b.ixtyp[nx][ny][0]], ixtyp2flag[blk8b.ixtyp[nx][ny][1]], blk8a.nui[nx][ny], blk8a.nj[nx][ny], nl1, nl2, isoilrflag[blk8a.isoilr[nx][ny]] });
                gridCount += 1;
            }
        }
        allocator.free(line);
        tokens.deinit();
        // Read soil physical properties
        line = try readLine(soilFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                if (tokens.items.len != blk8a.nm[nx][ny]) {
                    const err = error.InvalidInputSoilFileLine2;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#2] grid cell position W-E: {}, N-S: {}, depths to the bottom of", .{ soilFileName, nx, ny });
                // Read the depth (m) to the bottom of each layer
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.cdpth[nx][ny][l + 1] = try parseTokenToFloat(f32, error.InvalidSoilLayerDepth, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} m", .{ l + 1, blk8a.cdpth[nx][ny][l + 1] });
                }
                try logTopo.print(".\n", .{});
            }
        }
        allocator.free(line);
        tokens.deinit();
        line = try readLine(soilFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                if (tokens.items.len != blk8a.nm[nx][ny]) {
                    const err = error.InvalidInputSoilFileLine2;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#3] grid cell position W-E: {}, N-S: {}, initial bulk densities of", .{ soilFileName, nx, ny });
                // Read initial bulk density (Mg m-3) of each layer. Note: bulk density = 0.0 for a water layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.bkdsi[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidSoilLayerDepth, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} Mg m-3", .{ l + 1, blk8a.bkdsi[nx][ny][l] });
                }
                try logTopo.print(".\n", .{});
            }
        }
        allocator.free(line);
        tokens.deinit();
        // Read hydrologic properties
        line = try readLine(soilFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                if (tokens.items.len != blk8a.nm[nx][ny]) {
                    const err = error.InvalidInputSoilFileLine4;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#4] grid cell position W-E: {}, N-S: {}, water potential at initial inflection points of", .{ soilFileName, nx, ny });
                // Read water potential at initial inflection point (MPa) of soil moisture retention curve for each layer. Note: 0.0 = unknown inflection point.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk11a.psisminf[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidInflectionPoint, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} MPa", .{ l + 1, blk11a.psisminf[nx][ny][l] });
                }
                try logTopo.print(".\n", .{});
            }
        }
        allocator.free(line);
        tokens.deinit();
        line = try readLine(soilFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                if (tokens.items.len != blk8a.nm[nx][ny]) {
                    const err = error.InvalidInputSoilFileLine5;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#5] grid cell position W-E: {}, N-S: {}, water contents at field capacity of", .{ soilFileName, nx, ny });
                // Read water content (m3 m-3) at field capacity for each layer. Note: any negative number = unknown water content at field capacity.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.fc[nx][ny][l + 1] = try parseTokenToFloat(f32, error.InvalidFieldCapacity, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} m3 m-3", .{ l + 1, blk8a.fc[nx][ny][l + 1] });
                }
                try logTopo.print(".\n", .{});
            }
        }
        allocator.free(line);
        tokens.deinit();
        line = try readLine(soilFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                if (tokens.items.len != blk8a.nm[nx][ny]) {
                    const err = error.InvalidInputSoilFileLine6;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#6] grid cell position W-E: {}, N-S: {}, water contents at wilting point of", .{ soilFileName, nx, ny });
                // Read water content (m3 m-3) at wilting point for each layer. Note: any negative number = unknown water content at wilting point.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.wp[nx][ny][l + 1] = try parseTokenToFloat(f32, error.InvalidWiltingPoint, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} m3 m-3", .{ l + 1, blk8a.wp[nx][ny][l + 1] });
                }
                try logTopo.print(".\n", .{});
            }
        }
        allocator.free(line);
        tokens.deinit();
    }
    if (gridCount != (nhe - nhw) * (nvs - nvn)) {
        const err = error.InvalidInputForGridCellPositionsInSiteClusterFile;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        return err;
    }
}
