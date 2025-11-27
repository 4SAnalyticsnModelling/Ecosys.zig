const std = @import("std");
const config = @import("config");
const input_parser = @import("../util/input_parser.zig");
const utils = @import("../util/utils.zig");
const nscenario: usize = config.nscenariox;
const nscene: usize = config.nscenex;
const nwe: usize = config.nwex;
const nns: usize = config.nnsx;
const nplant: usize = config.nplantx;
const max_path_len = config.filepathx;
const RunArg = input_parser.RunArg;
const Tokens = input_parser.Tokens;
const FileReader = utils.FileReader;

///Build custom array type dimensions.
fn arrayType(comptime T: type, comptime dims: []const usize) type {
    if (dims.len == 0) {
        return T;
    } else {
        return [dims[0]]arrayType(T, dims[1..]);
    }
}
///Build custom array length type dimensions.
fn arrayLenType(comptime T: type, comptime dims: []const usize) type {
    if (dims.len < 2) {
        return T;
    } else {
        return [dims[0]]arrayLenType(T, dims[1..]);
    }
}
///Helps set custom array types.
fn fileNameType(comptime T: type, comptime dims: []const usize) type {
    return struct {
        name: arrayType(T, dims) = undefined,
        len: arrayLenType(usize, dims) = undefined,
    };
}
///Grid numbers in different directions.
const GridNum = struct {
    west: usize = 0,
    north: usize = 0,
    east: usize = 0,
    south: usize = 0,
    grid_count: usize = 0,
    tokens: Tokens = Tokens{},

    ///This method gets grid numbers in four directions.
    fn getGridNums(self: *GridNum, reader: *std.Io.Reader, runfile_name: []const u8, err_log: *std.Io.Writer) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        try self.tokens.tokenizeLine(line);
        if (self.tokens.len != 4) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while reading grid numbers in {s}\n", .{ @errorName(err), runfile_name });
            std.debug.print("\x1b[1;31merror: {s} while reading grid numbers in {s}\x1b[0m\n", .{ @errorName(err), runfile_name });
            return err;
        }
        const fields = [_]*usize{ &self.west, &self.north, &self.east, &self.south };
        for (self.tokens.items[0..fields.len], 0..) |tok, i| {
            fields[i].* = std.fmt.parseInt(usize, tok, 10) catch |err| {
                try err_log.print("error: {s} while parsing grid numbers in {s}\n", .{ @errorName(err), runfile_name });
                std.debug.print("\x1b[1;31merror: {s} while parsing grid numbers in {s}\x1b[0m\n", .{ @errorName(err), runfile_name });
                return err;
            };
        }
        if (self.west < 0 or self.west > self.east or self.east > nwe or self.north < 0 or self.north > self.south or self.south > nns) {
            const err = error.GridOutOfBounds;
            try err_log.print("error: {s} while reading grid numbers in {s}\n", .{ @errorName(err), runfile_name });
            std.debug.print("\x1b[1;31merror: {s} while reading grid numbers in {s}\x1b[0m\n", .{ @errorName(err), runfile_name });
            return err;
        }
        for (self.west..self.east) |_| {
            for (self.north..self.south) |_| {
                self.grid_count += 1;
            }
        }
    }
};
///Grid positions in different directions.
const GridPos = struct {
    west: usize = 0,
    north: usize = 0,
    east: usize = 0,
    south: usize = 0,
    plants: usize = 0,
    is_plant: bool = false,
    tokens: Tokens = Tokens{},

    ///This method gets grid positions in four directions.
    fn getGridPos(self: *GridPos, line: []const u8, file_name: []const u8, io_files: *const IOFiles, err_log: *std.Io.Writer) !void {
        try self.tokens.tokenizeLine(line);
        if ((self.is_plant == false and self.tokens.len != 4) or (self.is_plant == true and self.tokens.len != 5)) {
            const err = error.InvalidTokens;
            try self.gridPosError(err, file_name, err_log);
            return err;
        }
        const fields = [_]*usize{ &self.west, &self.north, &self.east, &self.south, &self.plants };
        for (self.tokens.items[0..self.tokens.len], 0..) |tok, i| {
            fields[i].* = std.fmt.parseInt(usize, tok, 10) catch |err| {
                try self.gridPosError(err, file_name, err_log);
                return err;
            };
        }
        if (self.west < io_files.grid_num.west or self.west > self.east or self.east > io_files.grid_num.east or self.north < io_files.grid_num.north or self.north > self.south or self.south > io_files.grid_num.south) {
            const err = error.GridOutOfBounds;
            try self.gridPosError(err, file_name, err_log);
            return err;
        }
        if (self.is_plant == true and self.plants > nplant) {
            const err = error.TooManyPlantSpecies;
            try self.gridPosError(err, file_name, err_log);
            return err;
        }
    }
    fn gridPosError(self: *GridPos, err: anyerror, file_name: []const u8, err_log: *std.Io.Writer) !void {
        if (self.is_plant) {
            try err_log.print("error: {s} while reading grid positions and number of plants in {s}\n", .{ @errorName(err), file_name });
            std.debug.print("\x1b[1;31merror: {s} while reading grid positions and number of plants in {s}\x1b[0m\n", .{ @errorName(err), file_name });
        } else {
            try err_log.print("error: {s} while reading grid positions in {s}\n", .{ @errorName(err), file_name });
            std.debug.print("\x1b[1;31merror: {s} while reading grid positions in {s}\x1b[0m\n", .{ @errorName(err), file_name });
        }
    }
};
///Scenario.
const Scenario = struct {
    num: usize = 0,
    repeat: usize = 0,
    tokens: Tokens = Tokens{},

    ///This method gets number of scenarios/scenes and times to repeat each scenario/scene.
    fn getScenario(self: *Scenario, reader: *std.Io.Reader, runfile_name: []const u8, err_log: *std.Io.Writer) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        try self.tokens.tokenizeLine(line);
        if (self.tokens.len != 2) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while reading number of scenarios and times to repeat each scenario in {s}\n", .{ @errorName(err), runfile_name });
            std.debug.print("\x1b[1;31merror: {s} while number of scenarios and times to repeat each scenario in {s}\x1b[0m\n", .{ @errorName(err), runfile_name });
            return err;
        }
        const fields = [_]*usize{ &self.num, &self.repeat };
        for (self.tokens.items[0..fields.len], 0..) |tok, i| {
            fields[i].* = std.fmt.parseInt(usize, tok, 10) catch |err| {
                try err_log.print("error: {s} while parsing number of scenarios and times to repeat each scenario in {s}\n", .{ @errorName(err), runfile_name });
                std.debug.print("\x1b[1;31merror: {s} while parsing number of scenarios and times to repeat each scenario in {s}\x1b[0m\n", .{ @errorName(err), runfile_name });
                return err;
            };
        }
        if (self.num > nscenario) {
            const err = error.ScenarioOutOfBounds;
            try err_log.print("error: {s} while reading number of scenarios in {s}\n", .{ @errorName(err), runfile_name });
            std.debug.print("\x1b[1;31merror: {s} while reading number of scenarios in {s}\x1b[0m\n", .{ @errorName(err), runfile_name });
            return err;
        }
    }
};
///Scene.
const Scene = struct {
    num: [nscenario]usize = undefined,
    repeat: [nscenario]usize = undefined,
    tokens: Tokens = Tokens{},

    ///This method gets number of scenes/scenes and times to repeat each scene/scene.
    fn getScene(self: *Scene, reader: *std.Io.Reader, runfile_name: []const u8, err_log: *std.Io.Writer, scenario_id: usize) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        try self.tokens.tokenizeLine(line);
        if (self.tokens.len != 2) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while reading number of scenes and times to repeat each scene in {s}\n", .{ @errorName(err), runfile_name });
            std.debug.print("\x1b[1;31merror: {s} while number of scenes and times to repeat each scene in {s}\x1b[0m\n", .{ @errorName(err), runfile_name });
            return err;
        }
        const fields = [_]*[nscenario]usize{ &self.num, &self.repeat };
        for (self.tokens.items[0..fields.len], 0..) |tok, i| {
            fields[i].*[scenario_id] = std.fmt.parseInt(usize, tok, 10) catch |err| {
                try err_log.print("error: {s} while parsing number of scenes and times to repeat each scene in {s}\n", .{ @errorName(err), runfile_name });
                std.debug.print("\x1b[1;31merror: {s} while parsing number of scenes and times to repeat each scene in {s}\x1b[0m\n", .{ @errorName(err), runfile_name });
                return err;
            };
        }
        if (self.num[scenario_id] > nscene) {
            const err = error.SceneOutOfBounds;
            try err_log.print("error: {s} while reading number of scenes in {s}\n", .{ @errorName(err), runfile_name });
            std.debug.print("\x1b[1;31merror: {s} while reading number of scenes in {s}\x1b[0m\n", .{ @errorName(err), runfile_name });
            return err;
        }
    }
};
///Site file names.
const SiteFile = struct {
    land_unit: fileNameType(u8, &.{ nwe, nns, max_path_len }) = .{}, //landscape unit within a site
    soil: fileNameType(u8, &.{ nwe, nns, max_path_len }) = .{}, //soil file for each landscape unit
    site: fileNameType(u8, &.{max_path_len}) = .{},
    grid_pos: GridPos = GridPos{},
    tokens: Tokens = Tokens{},
    file_reader: FileReader = FileReader{},

    ///Get data within the site file.
    fn getSiteFileData(self: *SiteFile, io_files: *const IOFiles, err_log: *std.Io.Writer) !void {
        const site_file_name = io_files.site_file.site.name[0..io_files.site_file.site.len];
        try self.file_reader.open(err_log, site_file_name);
        defer self.file_reader.close();
        self.file_reader.reader();
        var grid_count: usize = 0;
        while (true) {
            var line = self.file_reader.buf_reader.takeDelimiterInclusive('\n') catch |err| switch (err) {
                error.EndOfStream => break,
                else => return err,
            };
            try self.grid_pos.getGridPos(line, site_file_name, io_files, err_log);
            line = try self.file_reader.buf_reader.takeDelimiterInclusive('\n');
            for (self.grid_pos.west..self.grid_pos.east) |grid_pos_we| {
                for (self.grid_pos.north..self.grid_pos.south) |grid_pos_ns| {
                    try self.getSiteFiles(site_file_name, line, err_log, grid_pos_we, grid_pos_ns);
                    grid_count += 1;
                }
            }
            if (grid_count != io_files.grid_num.grid_count) {
                const err = error.InvalidGridPositions;
                try self.grid_pos.gridPosError(err, site_file_name, err_log);
                return err;
            }
        }
    }
    ///This method reads the land unit and soil file names within the site file.
    fn getSiteFiles(self: *SiteFile, site_file_name: []const u8, line: []const u8, err_log: *std.Io.Writer, grid_pos_we: usize, grid_pos_ns: usize) !void {
        try self.tokens.tokenizeLine(line);
        if (self.tokens.len != 2) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while reading land unit and soil file names in {s}\n", .{ @errorName(err), site_file_name });
            std.debug.print("\x1b[1;31merror: {s} while reading land unit and soil file names in {s}\x1b[0m\n", .{ @errorName(err), site_file_name });
            return err;
        }
        const field_names = [_]*[nwe][nns][max_path_len]u8{ &self.land_unit.name, &self.soil.name };
        const field_name_lens = [_]*[nwe][nns]usize{ &self.land_unit.len, &self.soil.len };
        for (self.tokens.items[0..field_names.len], 0..) |tok, i| {
            if (tok.len >= max_path_len) {
                const err = error.FilePathTooLong;
                try err_log.print("error: {s} while reading land unit and soil file names in {s}\n", .{ @errorName(err), site_file_name });
                std.debug.print("\x1b[1;31merror: {s} while reading land unit and soil file names in {s}\x1b[0m\n", .{ @errorName(err), site_file_name });
                return err;
            }
            @memcpy(field_names[i][grid_pos_we][grid_pos_ns][0..tok.len], tok);
            field_name_lens[i][grid_pos_we][grid_pos_ns] = tok.len;
        }
    }
};
///Weather file names.
const WthrFile = struct {
    wthr: fileNameType(u8, &.{ nscenario, nscene, nwe, nns, max_path_len }) = .{}, // weather file within a weather network
    wthr_net: fileNameType(u8, &.{ nscenario, nscene, max_path_len }) = .{}, //network of all weather files.
    grid_pos: GridPos = GridPos{},
    tokens: Tokens = Tokens{},
    file_reader: FileReader = FileReader{},

    ///Get data within the weather network file.
    fn getWthrNetFileData(self: *WthrFile, io_files: *const IOFiles, err_log: *std.Io.Writer, scenario_id: usize, scene_id: usize) !void {
        const wthr_net_file_name = io_files.wthr_file.wthr_net.name[scenario_id][scene_id][0..io_files.wthr_file.wthr_net.len[scenario_id][scene_id]];
        try self.file_reader.open(err_log, wthr_net_file_name);
        defer self.file_reader.close();
        self.file_reader.reader();
        var grid_count: usize = 0;
        while (true) {
            var line = self.file_reader.buf_reader.takeDelimiterInclusive('\n') catch |err| switch (err) {
                error.EndOfStream => break,
                else => return err,
            };
            try self.grid_pos.getGridPos(line, wthr_net_file_name, io_files, err_log);
            line = try self.file_reader.buf_reader.takeDelimiterInclusive('\n');
            for (self.grid_pos.west..self.grid_pos.east) |grid_pos_we| {
                for (self.grid_pos.north..self.grid_pos.south) |grid_pos_ns| {
                    try self.getWthrFiles(wthr_net_file_name, line, err_log, scenario_id, scene_id, grid_pos_we, grid_pos_ns);
                    grid_count += 1;
                }
            }
            if (grid_count != io_files.grid_num.grid_count) {
                const err = error.InvalidGridPositions;
                try self.grid_pos.gridPosError(err, wthr_net_file_name, err_log);
                return err;
            }
        }
    }
    ///This method reads the weather file names within the weather network file.
    fn getWthrFiles(self: *WthrFile, wthr_net_file_name: []const u8, line: []const u8, err_log: *std.Io.Writer, scenario_id: usize, scene_id: usize, grid_pos_we: usize, grid_pos_ns: usize) !void {
        try self.tokens.tokenizeLine(line);
        if (self.tokens.len != 1) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while reading weather file name in {s}\n", .{ @errorName(err), wthr_net_file_name });
            std.debug.print("\x1b[1;31merror: {s} while reading weather file names in {s}\x1b[0m\n", .{ @errorName(err), wthr_net_file_name });
            return err;
        }
        const tok = self.tokens.items[0];
        if (tok.len >= max_path_len) {
            const err = error.FilePathTooLong;
            try err_log.print("error: {s} while reading weather file names in {s}\n", .{ @errorName(err), wthr_net_file_name });
            std.debug.print("\x1b[1;31merror: {s} while reading weather file names in {s}\x1b[0m\n", .{ @errorName(err), wthr_net_file_name });
            return err;
        }
        @memcpy(self.wthr.name[scenario_id][scene_id][grid_pos_we][grid_pos_ns][0..tok.len], tok);
        self.wthr.len[scenario_id][scene_id][grid_pos_we][grid_pos_ns] = tok.len;
    }
};
///Soil management file names.
const SoilMgmtFile = struct {
    till: fileNameType(u8, &.{ nscenario, nscene, nwe, nns, max_path_len }) = .{},
    fert: fileNameType(u8, &.{ nscenario, nscene, nwe, nns, max_path_len }) = .{},
    irrig: fileNameType(u8, &.{ nscenario, nscene, nwe, nns, max_path_len }) = .{},
    soil_mgmt: fileNameType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
    grid_pos: GridPos = GridPos{},
    tokens: Tokens = Tokens{},
    file_reader: FileReader = FileReader{},

    ///Get data within the soil management file.
    fn getSoilMgmtFileData(self: *SoilMgmtFile, io_files: *IOFiles, err_log: *std.Io.Writer, scenario_id: usize, scene_id: usize) !void {
        const soil_mgmt_file_name = io_files.soil_mgmt_file.soil_mgmt.name[scenario_id][scene_id][0..io_files.soil_mgmt_file.soil_mgmt.len[scenario_id][scene_id]];
        if (!std.mem.eql(u8, soil_mgmt_file_name, "no")) {
            try self.file_reader.open(err_log, soil_mgmt_file_name);
            defer self.file_reader.close();
            self.file_reader.reader();
            var grid_count: usize = 0;
            while (true) {
                var line = self.file_reader.buf_reader.takeDelimiterInclusive('\n') catch |err| switch (err) {
                    error.EndOfStream => break,
                    else => return err,
                };
                try self.grid_pos.getGridPos(line, soil_mgmt_file_name, io_files, err_log);
                line = try self.file_reader.buf_reader.takeDelimiterInclusive('\n');
                for (self.grid_pos.west..self.grid_pos.east) |grid_pos_we| {
                    for (self.grid_pos.north..self.grid_pos.south) |grid_pos_ns| {
                        try self.getSoilMgmtFiles(soil_mgmt_file_name, line, err_log, scenario_id, scene_id, grid_pos_we, grid_pos_ns);
                        grid_count += 1;
                    }
                }
                if (grid_count != io_files.grid_num.grid_count) {
                    const err = error.InvalidGridPositions;
                    try self.grid_pos.gridPosError(err, soil_mgmt_file_name, err_log);
                    return err;
                }
            }
        }
    }
    ///This method reads the tillage, fertilizer, and irrigation file names within the soil management file.
    fn getSoilMgmtFiles(self: *SoilMgmtFile, soil_mgmt_file_name: []const u8, line: []const u8, err_log: *std.Io.Writer, scenario_id: usize, scene_id: usize, grid_pos_we: usize, grid_pos_ns: usize) !void {
        try self.tokens.tokenizeLine(line);
        if (self.tokens.len != 3) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while reading tillage, fertilizer, and irrigation file names in {s}\n", .{ @errorName(err), soil_mgmt_file_name });
            std.debug.print("\x1b[1;31merror: {s} while reading tillage, fertilizer, and irrigation file names in {s}\x1b[0m\n", .{ @errorName(err), soil_mgmt_file_name });
            return err;
        }
        const field_names = [_]*[nscenario][nscene][nwe][nns][max_path_len]u8{ &self.till.name, &self.fert.name, &self.irrig.name };
        const field_name_lens = [_]*[nscenario][nscene][nwe][nns]usize{ &self.till.len, &self.fert.len, &self.irrig.len };
        for (self.tokens.items[0..field_names.len], 0..) |tok, i| {
            if (tok.len >= max_path_len) {
                const err = error.FilePathTooLong;
                try err_log.print("error: {s} while reading tillage, fertilizer, and irrigation file names in {s}\n", .{ @errorName(err), soil_mgmt_file_name });
                std.debug.print("\x1b[1;31merror: {s} while reading tillage, fertilizer, and irrigation file names in {s}\x1b[0m\n", .{ @errorName(err), soil_mgmt_file_name });
                return err;
            }
            @memcpy(field_names[i][scenario_id][scene_id][grid_pos_we][grid_pos_ns][0..tok.len], tok);
            field_name_lens[i][scenario_id][scene_id][grid_pos_we][grid_pos_ns] = tok.len;
        }
    }
};
///Plant management file names.
const PlantMgmtFile = struct {
    plant: fileNameType(u8, &.{ nscenario, nscene, nwe, nns, nplant, max_path_len }) = .{},
    operation: fileNameType(u8, &.{ nscenario, nscene, nwe, nns, nplant, max_path_len }) = .{},
    plant_mgmt: fileNameType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
    grid_pos: GridPos = GridPos{ .is_plant = true },
    tokens: Tokens = Tokens{},
    file_reader: FileReader = FileReader{},

    ///Get data within the plant management file.
    fn getPlantMgmtFileData(self: *PlantMgmtFile, io_files: *IOFiles, err_log: *std.Io.Writer, scenario_id: usize, scene_id: usize) !void {
        const plant_mgmt_file_name = io_files.plant_mgmt_file.plant_mgmt.name[scenario_id][scene_id][0..io_files.plant_mgmt_file.plant_mgmt.len[scenario_id][scene_id]];
        if (!std.mem.eql(u8, plant_mgmt_file_name, "no")) {
            try self.file_reader.open(err_log, plant_mgmt_file_name);
            defer self.file_reader.close();
            self.file_reader.reader();
            var grid_count: usize = 0;
            while (true) {
                var line = self.file_reader.buf_reader.takeDelimiterInclusive('\n') catch |err| switch (err) {
                    error.EndOfStream => break,
                    else => return err,
                };
                try self.grid_pos.getGridPos(line, plant_mgmt_file_name, io_files, err_log);
                for (0..self.grid_pos.plants) |plant_id| {
                    line = self.file_reader.buf_reader.takeDelimiterInclusive('\n') catch {
                        const err = error.MissingFiles;
                        try err_log.print("error: {s} while reading plant file names in {s}\n", .{ @errorName(err), plant_mgmt_file_name });
                        std.debug.print("\x1b[1;31merror: {s} while reading plant file names in {s}\x1b[0m\n", .{ @errorName(err), plant_mgmt_file_name });
                        return err;
                    };
                    for (self.grid_pos.west..self.grid_pos.east) |grid_pos_we| {
                        for (self.grid_pos.north..self.grid_pos.south) |grid_pos_ns| {
                            try self.getPlantMgmtFiles(plant_mgmt_file_name, line, err_log, scenario_id, scene_id, grid_pos_we, grid_pos_ns, plant_id);
                            if (plant_id < 1) {
                                grid_count += 1;
                            }
                        }
                    }
                }
                if (grid_count != io_files.grid_num.grid_count) {
                    const err = error.InvalidGridPositions;
                    try self.grid_pos.gridPosError(err, plant_mgmt_file_name, err_log);
                    return err;
                }
            }
        }
    }
    ///This method reads the plant file names within the plant management file.
    fn getPlantMgmtFiles(self: *PlantMgmtFile, plant_mgmt_file_name: []const u8, line: []const u8, err_log: *std.Io.Writer, scenario_id: usize, scene_id: usize, grid_pos_we: usize, grid_pos_ns: usize, plant_id: usize) !void {
        try self.tokens.tokenizeLine(line);
        if (self.tokens.len != 2) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while reading plant file names in {s}\n", .{ @errorName(err), plant_mgmt_file_name });
            std.debug.print("\x1b[1;31merror: {s} while reading plant file names in {s}\x1b[0m\n", .{ @errorName(err), plant_mgmt_file_name });
            return err;
        }
        const field_names = [_]*[nscenario][nscene][nwe][nns][nplant][max_path_len]u8{ &self.plant.name, &self.operation.name };
        const field_name_lens = [_]*[nscenario][nscene][nwe][nns][nplant]usize{ &self.plant.len, &self.operation.len };
        for (self.tokens.items[0..field_names.len], 0..) |tok, i| {
            if (tok.len >= max_path_len) {
                const err = error.FilePathTooLong;
                try err_log.print("error: {s} while reading plant file names in {s}\n", .{ @errorName(err), plant_mgmt_file_name });
                std.debug.print("\x1b[1;31merror: {s} while reading plant file names in {s}\x1b[0m\n", .{ @errorName(err), plant_mgmt_file_name });
                return err;
            }
            @memcpy(field_names[i][scenario_id][scene_id][grid_pos_we][grid_pos_ns][plant_id][0..tok.len], tok);
            field_name_lens[i][scenario_id][scene_id][grid_pos_we][grid_pos_ns][plant_id] = tok.len;
        }
    }
};
///Daily output file names.
const HourlyOutFile = struct {
    carbon: fileNameType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
    water: fileNameType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
    nitrogen: fileNameType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
    phosphorus: fileNameType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
    heat: fileNameType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
};
///Daily output file names.
const DailyOutFile = struct {
    carbon: fileNameType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
    water: fileNameType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
    nitrogen: fileNameType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
    phosphorus: fileNameType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
    heat: fileNameType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
};
///This struct reads the names of the model input files within the runfile.
pub const IOFiles = struct {
    grid_num: GridNum = GridNum{},
    site_file: SiteFile = SiteFile{},
    start_yr: u32 = 0,
    scenario: Scenario = Scenario{},
    scene: Scene = Scene{},
    wthr_file: WthrFile = WthrFile{},
    opt_file: fileNameType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
    plant_mgmt_file: PlantMgmtFile = PlantMgmtFile{},
    soil_mgmt_file: SoilMgmtFile = SoilMgmtFile{},
    daily_out_file: DailyOutFile = DailyOutFile{},
    hourly_out_file: HourlyOutFile = HourlyOutFile{},
    tokens: Tokens = Tokens{},

    ///This method gets all parent I/O file names in the runscript/runfile.
    pub fn getParentIoFiles(self: *IOFiles, reader: *std.Io.Reader, runfile_name: []const u8, err_log: *std.Io.Writer) !void {
        try self.grid_num.getGridNums(reader, runfile_name, err_log);
        try self.getSite(reader, runfile_name, err_log);
        try self.getStartYear(reader, runfile_name, err_log);
        try self.scenario.getScenario(reader, runfile_name, err_log);
        for (0..self.scenario.num) |scenario_id| {
            try self.scene.getScene(reader, runfile_name, err_log, scenario_id);
            for (0..self.scene.num[scenario_id]) |scene_id| {
                try self.getSceneIOFiles(reader, runfile_name, err_log, scenario_id, scene_id);
            }
        }
        try err_log.flush();
    }

    ///This method gets all child I/O file names (e.g. weather, soil, tillage, fertilizer, irrigation, plants etc.) wherever applicable.
    pub fn getChildIoFiles(self: *IOFiles, err_log: *std.Io.Writer) !void {
        try self.site_file.getSiteFileData(self, err_log);
        for (0..self.scenario.num) |scenario_id| {
            for (0..self.scene.num[scenario_id]) |scene_id| {
                try self.wthr_file.getWthrNetFileData(self, err_log, scenario_id, scene_id);
                try self.soil_mgmt_file.getSoilMgmtFileData(self, err_log, scenario_id, scene_id);
                try self.plant_mgmt_file.getPlantMgmtFileData(self, err_log, scenario_id, scene_id);
            }
        }
        try err_log.flush();
    }

    ///This method gets site file name.
    fn getSite(self: *IOFiles, reader: *std.Io.Reader, runfile_name: []const u8, err_log: *std.Io.Writer) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        try self.tokens.tokenizeLine(line);
        if (self.tokens.len != 1) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while reading site file name in {s}\n", .{ @errorName(err), runfile_name });
            std.debug.print("\x1b[1;31merror: {s} while reading site file name in {s}\x1b[0m\n", .{ @errorName(err), runfile_name });
            return err;
        }
        const tok = self.tokens.items[0];
        if (tok.len >= max_path_len) {
            const err = error.FilePathTooLong;
            try err_log.print("error: {s} while reading site file name in {s}\n", .{ @errorName(err), runfile_name });
            std.debug.print("\x1b[1;31merror: {s} while reading site file name in {s}\x1b[0m\n", .{ @errorName(err), runfile_name });
            return err;
        }
        @memcpy(self.site_file.site.name[0..tok.len], tok);
        self.site_file.site.len = tok.len;
    }
    ///This method gets start year.
    fn getStartYear(self: *IOFiles, reader: *std.Io.Reader, runfile_name: []const u8, err_log: *std.Io.Writer) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        try self.tokens.tokenizeLine(line);
        if (self.tokens.len != 1) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while reading start year in {s}\n", .{ @errorName(err), runfile_name });
            std.debug.print("\x1b[1;31merror: {s} while reading start year in {s}\x1b[0m\n", .{ @errorName(err), runfile_name });
            return err;
        }
        const tok = self.tokens.items[0];
        self.start_yr = std.fmt.parseInt(u32, tok, 10) catch |err| {
            try err_log.print("error: {s} while parsing start year in {s}\n", .{ @errorName(err), runfile_name });
            std.debug.print("\x1b[1;31merror: {s} while parsing start year in {s}\x1b[0m\n", .{ @errorName(err), runfile_name });
            return err;
        };
    }
    ///This method gets all I/O file names within a scene.
    fn getSceneIOFiles(self: *IOFiles, reader: *std.Io.Reader, runfile_name: []const u8, err_log: *std.Io.Writer, scenario_id: usize, scene_id: usize) !void {
        const field_names = [_]*[nscenario][nscene][max_path_len]u8{ &self.wthr_file.wthr_net.name, &self.opt_file.name, &self.soil_mgmt_file.soil_mgmt.name, &self.plant_mgmt_file.plant_mgmt.name, &self.hourly_out_file.carbon.name, &self.hourly_out_file.water.name, &self.hourly_out_file.nitrogen.name, &self.hourly_out_file.phosphorus.name, &self.hourly_out_file.heat.name, &self.daily_out_file.carbon.name, &self.daily_out_file.water.name, &self.daily_out_file.nitrogen.name, &self.daily_out_file.phosphorus.name, &self.daily_out_file.heat.name };
        const field_name_lens = [_]*[nscenario][nscene]usize{ &self.wthr_file.wthr_net.len, &self.opt_file.len, &self.soil_mgmt_file.soil_mgmt.len, &self.plant_mgmt_file.plant_mgmt.len, &self.hourly_out_file.carbon.len, &self.hourly_out_file.water.len, &self.hourly_out_file.nitrogen.len, &self.hourly_out_file.phosphorus.len, &self.hourly_out_file.heat.len, &self.daily_out_file.carbon.len, &self.daily_out_file.water.len, &self.daily_out_file.nitrogen.len, &self.daily_out_file.phosphorus.len, &self.daily_out_file.heat.len };

        for (0..field_names.len) |i| {
            const line = try reader.takeDelimiterInclusive('\n');
            try self.tokens.tokenizeLine(line);
            if (self.tokens.len != 1) {
                const err = error.InvalidTokens;
                try err_log.print("error: {s} while reading scene I/O files in {s}\n", .{ @errorName(err), runfile_name });
                std.debug.print("\x1b[1;31merror: {s} while reading scene I/O files in {s}\x1b[0m\n", .{ @errorName(err), runfile_name });
                return err;
            }
            const tok = self.tokens.items[0];
            if (tok.len >= max_path_len) {
                const err = error.FilePathTooLong;
                try err_log.print("error: {s} while reading scene I/O files in {s}\n", .{ @errorName(err), runfile_name });
                std.debug.print("\x1b[1;31merror: {s} while reading scene I/O files in {s}\x1b[0m\n", .{ @errorName(err), runfile_name });
                return err;
            }
            @memcpy(field_names[i][scenario_id][scene_id][0..tok.len], tok);
            field_name_lens[i][scenario_id][scene_id] = tok.len;
        }
    }
};
