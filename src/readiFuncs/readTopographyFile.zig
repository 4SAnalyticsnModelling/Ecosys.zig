const std = @import("std");
const config = @import("config");
const jz = config.soillayersmax;
const offset: u32 = 1;
const Blk11a = @import("../globalStructs/blk11a.zig").Blk11a;
const Blk2a = @import("../globalStructs/blk2a.zig").Blk2a;
const Blk8a = @import("../globalStructs/blk8a.zig").Blk8a;
const Blk8b = @import("../globalStructs/blk8b.zig").Blk8b;
const Blkc = @import("../globalStructs/blkc.zig").Blkc;
const readLine = @import("../ecosysUtils/readLine.zig").readLine;
const tokenizeLine = @import("../ecosysUtils/tokenizeLine.zig").tokenizeLine;
const parseTokenToInt = @import("../ecosysUtils/parseTokenToInt.zig").parseTokenToInt;
const parseTokenToFloat = @import("../ecosysUtils/parseTokenToFloat.zig").parseTokenToFloat;
const setFlagForUnknownHydrologicProperties = @import("setFlagForUnknownHydrologicProperties.zig").setFlagForUnknownHydrologicProperties;
const calcDerivedSoilPropertiesFromInput = @import("calcDerivedSoilPropertiesFromInput.zig").calcDerivedSoilPropertiesFromInput;
const addSoilBoundaryLayers = @import("addSoilBoundaryLayers.zig").addSoilBoundaryLayers;
/// This function reads topography data
pub fn readTopographyFile(allocator: std.mem.Allocator, logFileWriter: std.fs.File.Writer, topographyName: []const u8, blk11a: *Blk11a, blk2a: *Blk2a, blk8a: *Blk8a, blk8b: *Blk8b, blkc: *Blkc, nhw: u32, nvn: u32, nhe: u32, nvs: u32) anyerror!void {
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
    @setEvalBranchQuota(2000);
    while (true) {
        var line = readLine(topographyFile, allocator) catch break; // break out of the loop at the EOF.
        var tokens = try tokenizeLine(line, allocator);
        if (tokens.items.len != 7) {
            const err = error.InvalidInputInTopographyFileLine1;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
        }
        // Read grid cell positions in W, N, E, and S direction
        const nh1 = try parseTokenToInt(u32, error.InvalidGridCellPositionInTopographyFile_W, tokens.items[0], logFileWriter) - offset;
        const nv1 = try parseTokenToInt(u32, error.InvalidGridCellPositionInTopographyFile_N, tokens.items[1], logFileWriter) - offset;
        const nh2 = try parseTokenToInt(u32, error.InvalidGridCellPositionInTopographyFile_E, tokens.items[2], logFileWriter);
        const nv2 = try parseTokenToInt(u32, error.InvalidGridCellPositionInTopographyFile_S, tokens.items[3], logFileWriter);
        try logTopo.print("=> Grid cell positions: W: {}, N: {}, E: {}, S: {}.\n", .{ nh1 + offset, nv1 + offset, nh2 + offset, nv2 + offset });
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
                try logTopo.print("=> Grid cell position W-E: {}, N-S: {}, aspect: {d} degree, slope: {d} degree, initial snowpack depth: {d} cm.\n", .{ nx + offset, ny + offset, blk2a.asp[nx][ny], blk2a.sl[nx][ny], blk11a.dpths[nx][ny] });
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
        const soilFile = fs.openFile(soilFileName, .{}) catch {
            const err = error.SoilFileNotFoundOrFailedToOpenSoilFile;
            try logFileWriter.print("error: {s}\n", .{@errorName(err)});
            return err;
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
                try logTopo.print("=> [Start of {s} file] grid cell position W-E: {}, N-S: {}, water potential at field capacity: {d} MPa, water potential at wilting point: {d} MPa, wet soil albedo: {d}, litter pH: {d}, C: {} gm-2, N :{} gm-2, P: {} gm-2 in fine surface litter, C: {} gm-2, N: {} gm-2, P: {} gm-2 in woody surface litter, C: {} gm-2, N: {} gm-2, P: {} gm-2 in manure surface litter, plant surface litter type: {s}, animal surface litter type: {s}, soil surface layer #: {}, maximum rooting layer #: {}, # of additional soil layer below maximum rooting layer (with data): {}, # of additional soil layer below maximum rooting layer (without data): {}, soil profile type: {s}.\n", .{ soilFileName, nx + offset, ny + offset, blk8a.psifc[nx][ny], blk8a.psiwp[nx][ny], blk8a.albs[nx][ny], blk8a.ph[nx][ny][0], blk8a.rsc[nx][ny][0][1], blk8a.rsn[nx][ny][0][1], blk8a.rsp[nx][ny][0][1], blk8a.rsc[nx][ny][0][0], blk8a.rsn[nx][ny][0][0], blk8a.rsp[nx][ny][0][0], blk8a.rsc[nx][ny][0][2], blk8a.rsn[nx][ny][0][2], blk8a.rsp[nx][ny][0][2], ixtyp1flag[blk8b.ixtyp[nx][ny][0]], ixtyp2flag[blk8b.ixtyp[nx][ny][1]], blk8a.nui[nx][ny], blk8a.nj[nx][ny], nl1, nl2, isoilrflag[blk8a.isoilr[nx][ny]] });
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
                try logTopo.print("=> [{s} file line#2] grid cell position W-E: {}, N-S: {}, depths to the bottom of", .{ soilFileName, nx + offset, ny + offset });
                // Read the depth (m) to the bottom of each layer
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.cdpth[nx][ny][l + offset] = try parseTokenToFloat(f32, error.InvalidSoilLayerDepth, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} m", .{ l + offset, blk8a.cdpth[nx][ny][l + offset] });
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
                    const err = error.InvalidInputSoilFileLine3;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#3] grid cell position W-E: {}, N-S: {}, initial bulk densities of", .{ soilFileName, nx + offset, ny + offset });
                // Read initial bulk density (Mg m-3) of each layer. Note: bulk density = 0.0 for a water layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.bkdsi[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidBulkDensity, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} Mg m-3", .{ l + offset, blk8a.bkdsi[nx][ny][l] });
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
                try logTopo.print("=> [{s} file line#4] grid cell position W-E: {}, N-S: {}, water potential at initial inflection points of", .{ soilFileName, nx + offset, ny + offset });
                // Read water potential at initial inflection point (MPa) of soil moisture retention curve for each layer. Note: 0.0 = unknown water potential at initial inflection point.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.psisminf[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidInflectionPoint, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} MPa", .{ l + offset, blk8a.psisminf[nx][ny][l] });
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
                try logTopo.print("=> [{s} file line#5] grid cell position W-E: {}, N-S: {}, water contents at field capacity of", .{ soilFileName, nx + offset, ny + offset });
                // Read water content (m3 m-3) at field capacity for each layer. Note: any negative number = unknown water content at field capacity.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.fc[nx][ny][l + offset] = try parseTokenToFloat(f32, error.InvalidFieldCapacity, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} m3 m-3", .{ l + offset, blk8a.fc[nx][ny][l + offset] });
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
                try logTopo.print("=> [{s} file line#6] grid cell position W-E: {}, N-S: {}, water contents at wilting point of", .{ soilFileName, nx + offset, ny + offset });
                // Read water content (m3 m-3) at wilting point for each layer. Note: any negative number = unknown water content at wilting point.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.wp[nx][ny][l + offset] = try parseTokenToFloat(f32, error.InvalidWiltingPoint, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} m3 m-3", .{ l + offset, blk8a.wp[nx][ny][l + offset] });
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
                    const err = error.InvalidInputSoilFileLine7;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#7] grid cell position W-E: {}, N-S: {}, saturated hydraulic conductivities (vertical) of", .{ soilFileName, nx + offset, ny + offset });
                // Read saturated hydraulic conductivity (vertical) (mm h-1) for each layer. Note: any negative number = unknown saturated hydraulic conductivity (vertical).
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.scnv[nx][ny][l + offset] = try parseTokenToFloat(f32, error.InvalidVerticalHydraulicConductivity, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} mm h-1", .{ l + offset, blk8a.scnv[nx][ny][l + offset] });
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
                    const err = error.InvalidInputSoilFileLine8;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#8] grid cell position W-E: {}, N-S: {}, saturated hydraulic conductivities (lateral) of", .{ soilFileName, nx + offset, ny + offset });
                // Read saturated hydraulic conductivity (lateral) (mm h-1) for each layer. Note: any negative number = unknown saturated hydraulic conductivity (lateral).
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.scnh[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidLateralHydraulicConductivity, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} mm h-1", .{ l + offset, blk8a.scnh[nx][ny][l] });
                }
                try logTopo.print(".\n", .{});
            }
        }
        allocator.free(line);
        tokens.deinit();
        // Read physical properties
        line = try readLine(soilFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                if (tokens.items.len != blk8a.nm[nx][ny]) {
                    const err = error.InvalidInputSoilFileLine9;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#9] grid cell position W-E: {}, N-S: {}, sand contents of", .{ soilFileName, nx + offset, ny + offset });
                // Read sand contents (kg Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.csand[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidSandContent, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} kg Mg-1", .{ l + offset, blk8a.csand[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine10;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#10] grid cell position W-E: {}, N-S: {}, silt contents of", .{ soilFileName, nx + offset, ny + offset });
                // Read silt contents (kg Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.csilt[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidSiltContent, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} kg Mg-1", .{ l + offset, blk8a.csilt[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine11;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#11] grid cell position W-E: {}, N-S: {}, macropore fractions of", .{ soilFileName, nx + offset, ny + offset });
                // Read macropore fraction for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.fhol[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidMacroporeFraction, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d}", .{ l + offset, blk8a.fhol[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine12;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#12] grid cell position W-E: {}, N-S: {}, rock fractions of", .{ soilFileName, nx + offset, ny + offset });
                // Read rock fraction for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.rock[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidRockFraction, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d}", .{ l + offset, blk8a.rock[nx][ny][l] });
                }
                try logTopo.print(".\n", .{});
            }
        }
        allocator.free(line);
        tokens.deinit();
        // Read chemical properties
        line = try readLine(soilFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                if (tokens.items.len != blk8a.nm[nx][ny]) {
                    const err = error.InvalidInputSoilFileLine13;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#13] grid cell position W-E: {}, N-S: {}, pH of", .{ soilFileName, nx + offset, ny + offset });
                // Read pH for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.ph[nx][ny][l + offset] = try parseTokenToFloat(f32, error.InvalidpH, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d}", .{ l + offset, blk8a.ph[nx][ny][l + offset] });
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
                    const err = error.InvalidInputSoilFileLine14;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#14] grid cell position W-E: {}, N-S: {}, cation exchange capacity (CEC) of", .{ soilFileName, nx + offset, ny + offset });
                // Read CEC (cmol kg-1) for each layer. Note: any negative number = unknown CEC.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.cec[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidCEC, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} cmol kg-1", .{ l + offset, blk8a.cec[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine15;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#15] grid cell position W-E: {}, N-S: {}, anion exchange capacity (AEC) of", .{ soilFileName, nx + offset, ny + offset });
                // Read AEC (cmol kg-1) for each layer. Note: any negative number = unknown AEC.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.aec[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidAEC, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} cmol kg-1", .{ l + offset, blk8a.aec[nx][ny][l] });
                }
                try logTopo.print(".\n", .{});
            }
        }
        allocator.free(line);
        tokens.deinit();
        // Read organic C, N, and P concentrations
        line = try readLine(soilFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                if (tokens.items.len != blk8a.nm[nx][ny]) {
                    const err = error.InvalidInputSoilFileLine16;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#16] grid cell position W-E: {}, N-S: {}, SOC concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read SOC concentration (kg Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.corgc[nx][ny][l + offset] = try parseTokenToFloat(f32, error.InvalidSOCConcentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} kg Mg-1", .{ l + offset, blk8a.corgc[nx][ny][l + offset] });
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
                    const err = error.InvalidInputSoilFileLine17;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#17] grid cell position W-E: {}, N-S: {}, POC concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read POC (Particulate Organic Carbon; part of SOC) concentration (kg Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.corgr[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidPOCConcentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} kg Mg-1", .{ l + offset, blk8a.corgr[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine18;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#18] grid cell position W-E: {}, N-S: {}, SON concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read SON (Soil Organic Nitrogen) concentration (g Mg-1) for each layer. Note: any negative number = unknown SON.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.corgn[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidSONConcentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.corgn[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine19;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#19] grid cell position W-E: {}, N-S: {}, SOP concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read SOP (Soil Organic Phosphorous) concentration (g Mg-1) for each layer. Note: any negative number = unknown SOP.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.corgp[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidSOPConcentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.corgp[nx][ny][l] });
                }
                try logTopo.print(".\n", .{});
            }
        }
        allocator.free(line);
        tokens.deinit();
        // Read inorganic N and P concentrations
        line = try readLine(soilFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                if (tokens.items.len != blk8a.nm[nx][ny]) {
                    const err = error.InvalidInputSoilFileLine20;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#20] grid cell position W-E: {}, N-S: {}, NH4 (soluble + exchangeable) concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read NH4 (soluble + exchangeable) concentration (g Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.cnh4[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidNH4Concentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.cnh4[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine21;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#21] grid cell position W-E: {}, N-S: {}, NO3 (soluble + exchangeable) concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read NO3 (soluble + exchangeable) concentration (g Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.cno3[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidNO3Concentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.cno3[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine22;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#22] grid cell position W-E: {}, N-S: {}, H2PO4 (soluble + exchangeable) concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read H2PO4 (soluble + exchangeable) concentration (g Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.cpo4[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidH2PO4Concentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.cpo4[nx][ny][l] });
                }
                try logTopo.print(".\n", .{});
            }
        }
        allocator.free(line);
        tokens.deinit();
        // Read cation and anion concentrations - soluble concentrations from saturated paste extract.
        line = try readLine(soilFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                if (tokens.items.len != blk8a.nm[nx][ny]) {
                    const err = error.InvalidInputSoilFileLine23;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#23] grid cell position W-E: {}, N-S: {}, soluble Al concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read soluble Al concentration (g Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.cal[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidSolubleAlConcentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.cal[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine24;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#24] grid cell position W-E: {}, N-S: {}, soluble Fe concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read soluble Fe concentration (g Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.cfe[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidSolubleFeConcentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.cfe[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine25;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#25] grid cell position W-E: {}, N-S: {}, soluble Ca concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read soluble Ca concentration (g Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.cca[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidSolubleCaConcentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.cca[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine26;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#26] grid cell position W-E: {}, N-S: {}, soluble Mg concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read soluble Mg concentration (g Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.cmg[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidSolubleMgConcentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.cmg[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine27;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#27] grid cell position W-E: {}, N-S: {}, soluble Na concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read soluble Na concentration (g Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.cna[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidSolubleNaConcentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.cna[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine28;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#28] grid cell position W-E: {}, N-S: {}, soluble K concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read soluble K concentration (g Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.cka[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidSolubleKConcentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.cka[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine29;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#29] grid cell position W-E: {}, N-S: {}, soluble SO4 concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read soluble SO4 concentration (g Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.cso4[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidSolubleSO4Concentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.cso4[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine30;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#30] grid cell position W-E: {}, N-S: {}, soluble Cl concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read soluble Cl concentration (g Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.ccl[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidSolubleClConcentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.ccl[nx][ny][l] });
                }
                try logTopo.print(".\n", .{});
            }
        }
        allocator.free(line);
        tokens.deinit();
        // Read precipitated mineral concentrations
        line = try readLine(soilFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                if (tokens.items.len != blk8a.nm[nx][ny]) {
                    const err = error.InvalidInputSoilFileLine31;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#31] grid cell position W-E: {}, N-S: {}, AlPO4 concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read AlPO4 concentration (g Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.calpo[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidAlPO4Concentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.calpo[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine32;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#32] grid cell position W-E: {}, N-S: {}, FePO4 concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read FePO4 concentration (g Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.cfepo[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidFePO4Concentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.cfepo[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine33;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#33] grid cell position W-E: {}, N-S: {},  CaHPO4 concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read CaHPO4 concentration (g Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.ccapd[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidCaHPO4Concentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.ccapd[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine34;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#34] grid cell position W-E: {}, N-S: {},  apatite concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read apatite concentration (g Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.ccaph[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidApatiteConcentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.ccaph[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine35;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#35] grid cell position W-E: {}, N-S: {},  AlOH3 concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read AlOH3 concentration (g Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.caloh[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidAlOH3Concentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.caloh[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine36;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#36] grid cell position W-E: {}, N-S: {},  FeOH3 concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read FeOH3 concentration (g Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.cfeoh[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidFeOH3Concentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.cfeoh[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine37;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#37] grid cell position W-E: {}, N-S: {},  CaCO3 concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read CaCO3 concentration (g Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.ccaco[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidCaCO3Concentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.ccaco[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine38;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#38] grid cell position W-E: {}, N-S: {},  CaSO4 concentrations of", .{ soilFileName, nx + offset, ny + offset });
                // Read CaSO4 concentration (g Mg-1) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.ccaso[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidCaSO4Concentration, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d} g Mg-1", .{ l + offset, blk8a.ccaso[nx][ny][l] });
                }
                try logTopo.print(".\n", .{});
            }
        }
        allocator.free(line);
        tokens.deinit();
        // Read gapon selectivity coefficients
        line = try readLine(soilFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                if (tokens.items.len != blk8a.nm[nx][ny]) {
                    const err = error.InvalidInputSoilFileLine39;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#39] grid cell position W-E: {}, N-S: {},  gapon selectivity coefficients for Ca-NH4 of", .{ soilFileName, nx + offset, ny + offset });
                // Read gapon selectivity coefficients for Ca-NH4 for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.gkc4[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidGapOnSelCoeffCaNH4, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d}", .{ l + offset, blk8a.gkc4[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine40;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#40] grid cell position W-E: {}, N-S: {},  gapon selectivity coefficients for Ca-H of", .{ soilFileName, nx + offset, ny + offset });
                // Read gapon selectivity coefficients for Ca-H for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.gkch[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidGapOnSelCoeffCaH, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d}", .{ l + offset, blk8a.gkch[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine41;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#41] grid cell position W-E: {}, N-S: {},  gapon selectivity coefficients for Ca-Al of", .{ soilFileName, nx + offset, ny + offset });
                // Read gapon selectivity coefficients for Ca-Al for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.gkca[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidGapOnSelCoeffCaAl, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d}", .{ l + offset, blk8a.gkca[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine42;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#42] grid cell position W-E: {}, N-S: {},  gapon selectivity coefficients for Ca-Mg of", .{ soilFileName, nx + offset, ny + offset });
                // Read gapon selectivity coefficients for Ca-Mg for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.gkcm[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidGapOnSelCoeffCaMg, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d}", .{ l + offset, blk8a.gkcm[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine43;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#43] grid cell position W-E: {}, N-S: {},  gapon selectivity coefficients for Ca-Na of", .{ soilFileName, nx + offset, ny + offset });
                // Read gapon selectivity coefficients for Ca-Na for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.gkcn[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidGapOnSelCoeffCaNa, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d}", .{ l + offset, blk8a.gkcn[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine44;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#44] grid cell position W-E: {}, N-S: {},  gapon selectivity coefficients for Ca-K of", .{ soilFileName, nx + offset, ny + offset });
                // Read gapon selectivity coefficients for Ca-K for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.gkck[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidGapOnSelCoeffCaK, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d}", .{ l + offset, blk8a.gkck[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine45;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#45] grid cell position W-E: {}, N-S: {},  initial water contents (m3 m-3) of", .{ soilFileName, nx + offset, ny + offset });
                // Read initial water contents (m3 m-3) for each layer. Any number greater than 1 = saturated, 1 = at field capacity, less than or equal to zero = at wilting point, anything between 0 and 1, as is.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.thw[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidInitialWaterContent, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d}", .{ l + offset, blk8a.thw[nx][ny][l] });
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
                    const err = error.InvalidInputSoilFileLine46;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#46] grid cell position W-E: {}, N-S: {},  initial ice contents (m3 m-3) of", .{ soilFileName, nx + offset, ny + offset });
                // Read initial ice contents (m3 m-3) for each layer. Any number greater than 1 = saturated, 1 = at field capacity, less than or equal to zero = at wilting point, anything between 0 and 1, as is.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.thi[nx][ny][l] = try parseTokenToFloat(f32, error.InvalidInitialIceContent, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d}", .{ l + offset, blk8a.thi[nx][ny][l] });
                }
                try logTopo.print(".\n", .{});
            }
        }
        allocator.free(line);
        tokens.deinit();
        // Read initial plant and animal residue C, N and P
        line = try readLine(soilFile, allocator);
        tokens = try tokenizeLine(line, allocator);
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                if (tokens.items.len != blk8a.nm[nx][ny]) {
                    const err = error.InvalidInputSoilFileLine47;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#47] grid cell position W-E: {}, N-S: {},  initial fine residue carbon contents (g m-2) of", .{ soilFileName, nx + offset, ny + offset });
                // Read initial fine residue carbon content (g m-2) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.rsc[nx][ny][l + offset][1] = try parseTokenToFloat(f32, error.InvalidInitialFineResidueCarbonContent, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d}", .{ l + offset, blk8a.rsc[nx][ny][l + offset][1] });
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
                    const err = error.InvalidInputSoilFileLine48;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#48] grid cell position W-E: {}, N-S: {},  initial fine residue nitrogen contents (g m-2) of", .{ soilFileName, nx + offset, ny + offset });
                // Read initial fine residue nitrogen content (g m-2) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.rsn[nx][ny][l + offset][1] = try parseTokenToFloat(f32, error.InvalidInitialFineResidueNitrogenContent, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d}", .{ l + offset, blk8a.rsn[nx][ny][l + offset][1] });
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
                    const err = error.InvalidInputSoilFileLine49;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#49] grid cell position W-E: {}, N-S: {},  initial fine residue phosphorous contents (g m-2) of", .{ soilFileName, nx + offset, ny + offset });
                // Read initial fine residue phosphorous content (g m-2) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.rsp[nx][ny][l + offset][1] = try parseTokenToFloat(f32, error.InvalidInitialFineResiduePhosphorousContent, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d}", .{ l + offset, blk8a.rsp[nx][ny][l + offset][1] });
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
                    const err = error.InvalidInputSoilFileLine50;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#50] grid cell position W-E: {}, N-S: {},  initial woody residue carbon contents (g m-2) of", .{ soilFileName, nx + offset, ny + offset });
                // Read initial woody residue carbon content (g m-2) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.rsc[nx][ny][l + offset][0] = try parseTokenToFloat(f32, error.InvalidInitialWoodyResidueCarbonContent, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d}", .{ l + offset, blk8a.rsc[nx][ny][l + offset][0] });
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
                    const err = error.InvalidInputSoilFileLine51;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#51] grid cell position W-E: {}, N-S: {},  initial woody residue nitrogen contents (g m-2) of", .{ soilFileName, nx + offset, ny + offset });
                // Read initial woody residue nitrogen content (g m-2) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.rsn[nx][ny][l + offset][0] = try parseTokenToFloat(f32, error.InvalidInitialWoodyResidueNitrogenContent, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d}", .{ l + offset, blk8a.rsn[nx][ny][l + offset][0] });
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
                    const err = error.InvalidInputSoilFileLine52;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#52] grid cell position W-E: {}, N-S: {},  initial woody residue phosphorous contents (g m-2) of", .{ soilFileName, nx + offset, ny + offset });
                // Read initial woody residue phosphorous content (g m-2) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.rsp[nx][ny][l + offset][0] = try parseTokenToFloat(f32, error.InvalidInitialWoodyResiduePhosphorousContent, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d}", .{ l + offset, blk8a.rsp[nx][ny][l + offset][0] });
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
                    const err = error.InvalidInputSoilFileLine53;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#53] grid cell position W-E: {}, N-S: {},  initial manure residue carbon contents (g m-2) of", .{ soilFileName, nx + offset, ny + offset });
                // Read initial manure residue carbon content (g m-2) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.rsc[nx][ny][l + offset][2] = try parseTokenToFloat(f32, error.InvalidInitialManureResidueCarbonContent, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d}", .{ l + offset, blk8a.rsc[nx][ny][l + offset][2] });
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
                    const err = error.InvalidInputSoilFileLine54;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#54] grid cell position W-E: {}, N-S: {},  initial manure residue nitrogen contents (g m-2) of", .{ soilFileName, nx + offset, ny + offset });
                // Read initial manure residue nitrogen content (g m-2) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.rsn[nx][ny][l + offset][1] = try parseTokenToFloat(f32, error.InvalidInitialWoodyResidueNitrogenContent, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d}", .{ l + offset, blk8a.rsn[nx][ny][l + offset][1] });
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
                    const err = error.InvalidInputSoilFileLine55;
                    try logFileWriter.print("error: {s}\n", .{@errorName(err)});
                    return err;
                }
                try logTopo.print("=> [{s} file line#55] grid cell position W-E: {}, N-S: {},  initial manure residue phosphorous contents (g m-2) of", .{ soilFileName, nx + offset, ny + offset });
                // Read initial manure residue phosphorous content (g m-2) for each layer.
                for (0..blk8a.nm[nx][ny]) |l| {
                    blk8a.rsp[nx][ny][l + offset][0] = try parseTokenToFloat(f32, error.InvalidInitialManureResiduePhosphorousContent, tokens.items[l], logFileWriter);
                    try logTopo.print(" -> layer #{}: {d}", .{ l + offset, blk8a.rsp[nx][ny][l + offset][0] });
                }
                try logTopo.print(". [End of {s} file].\n", .{soilFileName});
            }
        }
        allocator.free(line);
        tokens.deinit();
        for (nh1..nh2) |nx| {
            for (nv1..nv2) |ny| {
                // Surface litter layer properties
                blk8a.rsc[nx][ny][0][1] = @max(1e-6, blk8a.rsc[nx][ny][0][1]);
                blk8a.rsn[nx][ny][0][1] = @max(0.04e-6, blk8a.rsn[nx][ny][0][1]);
                blk8a.rsp[nx][ny][0][1] = @max(0.004e-6, blk8a.rsp[nx][ny][0][1]);
                blk8a.scnv[nx][ny][0] = 10.0 * 0.098;
                // Set flags for unknown hydrologic properties
                try setFlagForUnknownHydrologicProperties(logFileWriter, blk8a, blkc, nx, ny);
                // Add soil boundary layers below soil zone
                try addSoilBoundaryLayers(logFileWriter, blk8a, blkc, nx, ny);
                // Calculate derived soil properties from input properties
                try calcDerivedSoilPropertiesFromInput(logFileWriter, blk8a, nx, ny);
            }
        }
        for (nhw..nhe) |nx| {
            blk8a.nl[nx][nvs + 1] = blk8a.nl[nx][nvs];
        }
        for (nvn..nvs) |ny| {
            blk8a.nl[nhe + 1][ny] = blk8a.nl[nhe][ny];
        }
    }
    blk8a.nl[nvs + 1][nhe + 1] = blk8a.nl[nvs][nhe];
    if (gridCount != (nhe - nhw) * (nvs - nvn)) {
        const err = error.InvalidInputForGridCellPositionsInTopographyFile;
        try logFileWriter.print("error: {s}\n", .{@errorName(err)});
        return err;
    }
}
