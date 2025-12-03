///This module contains struct and methods that help loading all the file names in the runfile/runscript (i.e., parent files) and within the parent files (i.e., child files)
const std = @import("std");
const config = @import("config");
const input_parser = @import("../util/input_parser.zig");
const utils = @import("../util/utils.zig");
const print = std.debug.print;
const nscenario: usize = config.nscenariox;
const nscene: usize = config.nscenex;
const nwe: usize = config.nwex;
const nns: usize = config.nnsx;
const nplant: usize = config.nplantx;
const max_path_len = config.filepathx;
const RunArg = input_parser.RunArg;
const Tokens = input_parser.Tokens;
const FileReader = utils.FileReader;
const parseTokToInt = Tokens.parseTokToInt;
const boundsCheck = Tokens.boundsCheck;

///Build custom array dimensions
fn arrayDimsType(comptime T: type, comptime dims: []const usize, comptime is_length: bool) type {
    if ((is_length == false and dims.len < 1) or (is_length == true and dims.len < 2)) {
        return T;
    } else {
        return [dims[0]]arrayDimsType(T, dims[1..], is_length);
    }
}
test "test arrayDimsType function" {
    // this is a comptime test since the function works at compile time
    comptime {
        const type_a = arrayDimsType(f32, &.{ 2, 3, 4 }, false);
        if (type_a != [2][3][4]f32) {
            @compileError("arrayDimsType(f32, &.{2, 3, 4}, false) must be equal to [2][3][4]f32");
        }
        const type_b = arrayDimsType(u8, &.{256}, false);
        if (type_b != [256]u8) {
            @compileError("arrayDimsType(u8, &.{ 256 }, false) must be equal to [ 256 ]u8");
        }
        const type_c = arrayDimsType(usize, &.{256}, true);
        if (type_c != usize) {
            @compileError("arrayDimsType(usize, &.{ 256 }, true) must be equal to usize");
        }
    }
}
///Helps set custom array types
fn arrayType(comptime T: type, comptime dims: []const usize) type {
    return struct {
        name: arrayDimsType(T, dims, false) = undefined,
        len: arrayDimsType(usize, dims, true) = std.mem.zeroes(arrayDimsType(usize, dims, true)),
    };
}
///Grid numbers in different directions
const GridNums = struct {
    west: usize = 0,
    north: usize = 0,
    east: usize = 0,
    south: usize = 0,
    grid_count: usize = 0,

    ///This method gets grid numbers in four directions
    fn getGridNums(self: *GridNums, reader: *std.Io.Reader, runfile_name: []const u8, err_log: *std.Io.Writer) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        var tokens = Tokens{};
        try tokens.tokenizeLine(line, 4, "grid numbers", runfile_name, err_log);
        const fields = [_]*usize{ &self.west, &self.north, &self.east, &self.south };
        for (tokens.items[0..fields.len], 0..) |tok, i| {
            fields[i].* = try parseTokToInt(usize, tok, "grid numbers", runfile_name, err_log);
        }
        try boundsCheck(error.OutOfBounds, .{ self.west < 0, self.west > self.east, self.east > nwe, self.north < 0, self.north > self.south, self.south > nns }, "grid numbers", runfile_name, err_log);
        for (self.west..self.east) |_| {
            for (self.north..self.south) |_| {
                self.grid_count += 1;
            }
        }
    }
};
///Grid positions in different directions
const GridPos = struct {
    west: usize = 0,
    north: usize = 0,
    east: usize = 0,
    south: usize = 0,
    plants: usize = 0,
    is_plant: bool = false, //used to read plant files within the plant mgmt file

    ///This method gets grid positions in four directions
    fn getGridPos(self: *GridPos, line: []const u8, file_name: []const u8, io_files: *const IoFiles, err_log: *std.Io.Writer) !void {
        var tokens = Tokens{};
        if (self.is_plant) {
            try tokens.tokenizeLine(line, 5, "grid positions & number of plants", file_name, err_log);
        } else {
            try tokens.tokenizeLine(line, 4, "grid positions", file_name, err_log);
        }
        const fields = [_]*usize{ &self.west, &self.north, &self.east, &self.south, &self.plants };
        if (self.is_plant) {
            for (tokens.items[0..tokens.len], 0..) |tok, i| {
                fields[i].* = try parseTokToInt(usize, tok, "grid positions & number of plants", file_name, err_log);
            }
        } else {
            for (tokens.items[0..tokens.len], 0..) |tok, i| {
                fields[i].* = try parseTokToInt(usize, tok, "grid positions", file_name, err_log);
            }
        }
        try boundsCheck(error.OutOfBounds, .{ self.west < io_files.grid_num.west, self.west > self.east, self.east > io_files.grid_num.east, self.north < io_files.grid_num.north, self.north > self.south, self.south > io_files.grid_num.south }, "grid positions (hint: grid numbers out of bounds)", file_name, err_log);
        if (self.is_plant == true) {
            try boundsCheck(error.OutOfBounds, .{self.plants > nplant}, "number of plant species (hint: too many plant species)", file_name, err_log);
        }
    }
};
///Scenario
const Scenario = struct {
    num: usize = 0,
    repeat: usize = 0,

    ///This method gets number of scenarios/scenes and times to repeat each scenario/scene.
    fn getScenario(self: *Scenario, reader: *std.Io.Reader, runfile_name: []const u8, err_log: *std.Io.Writer) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        var tokens = Tokens{};
        try tokens.tokenizeLine(line, 2, "number of scenarios and times to repeat each scenario", runfile_name, err_log);
        const fields = [_]*usize{ &self.num, &self.repeat };
        for (tokens.items[0..fields.len], 0..) |tok, i| {
            fields[i].* = try parseTokToInt(usize, tok, "number of scenarios and times to repeat each scenario", runfile_name, err_log);
        }
        try boundsCheck(error.OutOfBounds, .{self.num > nscenario}, "number of scenarios", runfile_name, err_log);
    }
};
///Scene
const Scene = struct {
    num: [nscenario]usize = undefined,
    repeat: [nscenario]usize = undefined,

    ///This method gets number of scenes/scenes and times to repeat each scene/scene
    fn getScene(self: *Scene, reader: *std.Io.Reader, runfile_name: []const u8, err_log: *std.Io.Writer, scenario: usize) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        var tokens = Tokens{};
        try tokens.tokenizeLine(line, 2, "number of scenes and times to repeat each scene", runfile_name, err_log);
        const fields = [_]*[nscenario]usize{ &self.num, &self.repeat };
        for (tokens.items[0..fields.len], 0..) |tok, i| {
            fields[i].*[scenario] = try parseTokToInt(usize, tok, "number of scenes and times to repeat each scene", runfile_name, err_log);
        }
        try boundsCheck(error.OutOfBounds, .{self.num[scenario] > nscene}, "number of scenes", runfile_name, err_log);
    }
};
///Site file names
const SiteFile = struct {
    land_unit: arrayType(u8, &.{ nwe, nns, max_path_len }) = .{}, //names of landscape unit files within a site (child file)
    soil: arrayType(u8, &.{ nwe, nns, max_path_len }) = .{}, //names of soil files for each landscape unit (child file)
    site: arrayType(u8, &.{max_path_len}) = .{}, //site file name (parent file)
    grid_pos: GridPos = GridPos{},
    file_reader: FileReader = FileReader{},

    ///Get data within the site file
    fn getSiteFileData(self: *SiteFile, io_files: *const IoFiles, err_log: *std.Io.Writer) !void {
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
            for (self.grid_pos.west..self.grid_pos.east) |we| {
                for (self.grid_pos.north..self.grid_pos.south) |ns| {
                    try self.getSiteFiles(site_file_name, line, err_log, we, ns);
                    grid_count += 1;
                }
            }
            try boundsCheck(error.OutOfBounds, .{grid_count != io_files.grid_num.grid_count}, "grid positions (hint: too few or too many grids)", site_file_name, err_log);
        }
    }
    ///This method reads the land unit and soil file names within the site file
    fn getSiteFiles(self: *SiteFile, site_file_name: []const u8, line: []const u8, err_log: *std.Io.Writer, we: usize, ns: usize) !void {
        var tokens = Tokens{};
        try tokens.tokenizeLine(line, 2, "land unit and soil file names", site_file_name, err_log);
        const field_names = [_]*[nwe][nns][max_path_len]u8{ &self.land_unit.name, &self.soil.name };
        const field_name_lens = [_]*[nwe][nns]usize{ &self.land_unit.len, &self.soil.len };
        for (tokens.items[0..field_names.len], 0..) |tok, i| {
            try boundsCheck(error.FilePathTooLong, .{tok.len >= max_path_len}, "land unit and soil file names", site_file_name, err_log);
            @memcpy(field_names[i][we][ns][0..tok.len], tok);
            field_name_lens[i][we][ns] = tok.len;
        }
    }
};
///Weather file names
const WthrFile = struct {
    wthr: arrayType(u8, &.{ nscenario, nscene, nwe, nns, max_path_len }) = .{}, //names of weather files within a weather network file (child file)
    wthr_net: arrayType(u8, &.{ nscenario, nscene, max_path_len }) = .{}, //names of networks of all weather files (parent file)
    grid_pos: GridPos = GridPos{},
    file_reader: FileReader = FileReader{},

    ///Get data within the weather network file
    fn getWthrNetFileData(self: *WthrFile, io_files: *const IoFiles, err_log: *std.Io.Writer, scenario: usize, scene: usize) !void {
        const wthr_net_file_name = io_files.wthr_file.wthr_net.name[scenario][scene][0..io_files.wthr_file.wthr_net.len[scenario][scene]];
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
            for (self.grid_pos.west..self.grid_pos.east) |we| {
                for (self.grid_pos.north..self.grid_pos.south) |ns| {
                    try self.getWthrFiles(wthr_net_file_name, line, err_log, scenario, scene, we, ns);
                    grid_count += 1;
                }
            }
            try boundsCheck(error.OutOfBounds, .{grid_count != io_files.grid_num.grid_count}, "grid positions (hint: too few or too many grids)", wthr_net_file_name, err_log);
        }
    }
    ///This method reads the weather file names within the weather network file
    fn getWthrFiles(self: *WthrFile, wthr_net_file_name: []const u8, line: []const u8, err_log: *std.Io.Writer, scenario: usize, scene: usize, we: usize, ns: usize) !void {
        var tokens = Tokens{};
        try tokens.tokenizeLine(line, 1, "weather file name", wthr_net_file_name, err_log);
        const tok = tokens.items[0];
        try boundsCheck(error.FilePathTooLong, .{tok.len >= max_path_len}, "weather file names", wthr_net_file_name, err_log);
        @memcpy(self.wthr.name[scenario][scene][we][ns][0..tok.len], tok);
        self.wthr.len[scenario][scene][we][ns] = tok.len;
    }
};
///Soil management file names
const SoilMgmtFile = struct {
    till: arrayType(u8, &.{ nscenario, nscene, nwe, nns, max_path_len }) = .{}, //tillage mgmt file names (child file)
    fert: arrayType(u8, &.{ nscenario, nscene, nwe, nns, max_path_len }) = .{}, //fertilizer mgmt file names (child file)
    irrig: arrayType(u8, &.{ nscenario, nscene, nwe, nns, max_path_len }) = .{}, //irrigation mgmt file names (child file)
    soil_mgmt: arrayType(u8, &.{ nscenario, nscene, max_path_len }) = .{}, //soil mgmt file names (parent file)
    grid_pos: GridPos = GridPos{},
    file_reader: FileReader = FileReader{},

    ///Get data within the soil management file
    fn getSoilMgmtFileData(self: *SoilMgmtFile, io_files: *IoFiles, err_log: *std.Io.Writer, scenario: usize, scene: usize) !void {
        const soil_mgmt_file_name = io_files.soil_mgmt_file.soil_mgmt.name[scenario][scene][0..io_files.soil_mgmt_file.soil_mgmt.len[scenario][scene]];
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
                for (self.grid_pos.west..self.grid_pos.east) |we| {
                    for (self.grid_pos.north..self.grid_pos.south) |ns| {
                        try self.getSoilMgmtFiles(soil_mgmt_file_name, line, err_log, scenario, scene, we, ns);
                        grid_count += 1;
                    }
                }
                try boundsCheck(error.OutOfBounds, .{grid_count != io_files.grid_num.grid_count}, "grid positions (hint: too few or too many grids)", soil_mgmt_file_name, err_log);
            }
        }
    }
    ///This method reads the tillage, fertilizer, and irrigation file names within the soil management file
    fn getSoilMgmtFiles(self: *SoilMgmtFile, soil_mgmt_file_name: []const u8, line: []const u8, err_log: *std.Io.Writer, scenario: usize, scene: usize, we: usize, ns: usize) !void {
        var tokens = Tokens{};
        try tokens.tokenizeLine(line, 3, "tillage, fertilizer and irrigation file names", soil_mgmt_file_name, err_log);
        const field_names = [_]*[nscenario][nscene][nwe][nns][max_path_len]u8{ &self.till.name, &self.fert.name, &self.irrig.name };
        const field_name_lens = [_]*[nscenario][nscene][nwe][nns]usize{ &self.till.len, &self.fert.len, &self.irrig.len };
        for (tokens.items[0..field_names.len], 0..) |tok, i| {
            try boundsCheck(error.FilePathTooLong, .{tok.len >= max_path_len}, "tillage, fertilizer, and irrigation file names", soil_mgmt_file_name, err_log);
            @memcpy(field_names[i][scenario][scene][we][ns][0..tok.len], tok);
            field_name_lens[i][scenario][scene][we][ns] = tok.len;
        }
    }
};
///Plant management file names
const PlantMgmtFile = struct {
    plant: arrayType(u8, &.{ nscenario, nscene, nwe, nns, nplant, max_path_len }) = .{}, //plant species file names (child file)
    operation: arrayType(u8, &.{ nscenario, nscene, nwe, nns, nplant, max_path_len }) = .{}, //agriculture, horticulture, silviculture operations (e.g., planting, harvesting etc.) file names (child file)
    plant_mgmt: arrayType(u8, &.{ nscenario, nscene, max_path_len }) = .{}, //plant mgmt file names (parent file)
    grid_pos: GridPos = GridPos{ .is_plant = true },
    file_reader: FileReader = FileReader{},

    ///Get data within the plant management file
    fn getPlantMgmtFileData(self: *PlantMgmtFile, io_files: *IoFiles, err_log: *std.Io.Writer, scenario: usize, scene: usize) !void {
        const plant_mgmt_file_name = io_files.plant_mgmt_file.plant_mgmt.name[scenario][scene][0..io_files.plant_mgmt_file.plant_mgmt.len[scenario][scene]];
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
                for (0..self.grid_pos.plants) |plnt| {
                    line = self.file_reader.buf_reader.takeDelimiterInclusive('\n') catch {
                        const err = error.MissingFiles;
                        try err_log.print("error: {s} while reading plant file names in {s}\n", .{ @errorName(err), plant_mgmt_file_name });
                        defer err_log.flush() catch {};
                        print("\x1b[1;31merror:\x1b[0m {s} while reading plant file names in {s}\n", .{ @errorName(err), plant_mgmt_file_name });
                        return err;
                    };
                    for (self.grid_pos.west..self.grid_pos.east) |we| {
                        for (self.grid_pos.north..self.grid_pos.south) |ns| {
                            try self.getPlantMgmtFiles(plant_mgmt_file_name, line, err_log, scenario, scene, we, ns, plnt);
                            if (plnt < 1) {
                                grid_count += 1;
                            }
                        }
                    }
                }
                try boundsCheck(error.OutOfBounds, .{grid_count != io_files.grid_num.grid_count}, "grid positions and number of plant species (hint: too few or too many grids)", plant_mgmt_file_name, err_log);
            }
        }
    }
    ///This method reads the plant file names within the plant management file
    fn getPlantMgmtFiles(self: *PlantMgmtFile, plant_mgmt_file_name: []const u8, line: []const u8, err_log: *std.Io.Writer, scenario: usize, scene: usize, we: usize, ns: usize, plnt: usize) !void {
        var tokens = Tokens{};
        try tokens.tokenizeLine(line, 2, "plant file names", plant_mgmt_file_name, err_log);
        const field_names = [_]*[nscenario][nscene][nwe][nns][nplant][max_path_len]u8{ &self.plant.name, &self.operation.name };
        const field_name_lens = [_]*[nscenario][nscene][nwe][nns][nplant]usize{ &self.plant.len, &self.operation.len };
        for (tokens.items[0..field_names.len], 0..) |tok, i| {
            try boundsCheck(error.FilePathTooLong, .{tok.len >= max_path_len}, "plant file names", plant_mgmt_file_name, err_log);
            @memcpy(field_names[i][scenario][scene][we][ns][plnt][0..tok.len], tok);
            field_name_lens[i][scenario][scene][we][ns][plnt] = tok.len;
        }
    }
};
///Daily output file names
const HourlyOutFile = struct {
    carbon: arrayType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
    water: arrayType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
    nitrogen: arrayType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
    phosphorus: arrayType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
    heat: arrayType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
};
///Daily output file names
const DailyOutFile = struct {
    carbon: arrayType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
    water: arrayType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
    nitrogen: arrayType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
    phosphorus: arrayType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
    heat: arrayType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
};
///This struct reads the names of the model input files within the runfile
pub const IoFiles = struct {
    grid_num: GridNums = GridNums{},
    site_file: SiteFile = SiteFile{},
    start_yr: usize = 0,
    scenario: Scenario = Scenario{},
    scene: Scene = Scene{},
    wthr_file: WthrFile = WthrFile{},
    opt_file: arrayType(u8, &.{ nscenario, nscene, max_path_len }) = .{},
    plant_mgmt_file: PlantMgmtFile = PlantMgmtFile{},
    soil_mgmt_file: SoilMgmtFile = SoilMgmtFile{},
    daily_out_file: DailyOutFile = DailyOutFile{},
    hourly_out_file: HourlyOutFile = HourlyOutFile{},

    ///This method gets all parent I/O file names in the runscript/runfile
    pub fn getParentIoFiles(self: *IoFiles, reader: *std.Io.Reader, runfile_name: []const u8, err_log: *std.Io.Writer) !void {
        try self.grid_num.getGridNums(reader, runfile_name, err_log);
        try self.getSite(reader, runfile_name, err_log);
        try self.getStartYear(reader, runfile_name, err_log);
        try self.scenario.getScenario(reader, runfile_name, err_log);
        for (0..self.scenario.num) |scenario| {
            try self.scene.getScene(reader, runfile_name, err_log, scenario);
            for (0..self.scene.num[scenario]) |scene| {
                try self.getSceneIoFiles(reader, runfile_name, err_log, scenario, scene);
            }
        }
        try err_log.flush();
    }

    ///This method gets all child I/O file names (e.g. weather, soil, tillage, fertilizer, irrigation, plants etc.) wherever applicable
    pub fn getChildIoFiles(self: *IoFiles, err_log: *std.Io.Writer) !void {
        try self.site_file.getSiteFileData(self, err_log);
        for (0..self.scenario.num) |scenario| {
            for (0..self.scene.num[scenario]) |scene| {
                try self.wthr_file.getWthrNetFileData(self, err_log, scenario, scene);
                try self.soil_mgmt_file.getSoilMgmtFileData(self, err_log, scenario, scene);
                try self.plant_mgmt_file.getPlantMgmtFileData(self, err_log, scenario, scene);
            }
        }
        try err_log.flush();
    }

    ///This method gets site file name
    fn getSite(self: *IoFiles, reader: *std.Io.Reader, runfile_name: []const u8, err_log: *std.Io.Writer) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        var tokens = Tokens{};
        try tokens.tokenizeLine(line, 1, "site file name", runfile_name, err_log);
        const tok = tokens.items[0];
        try boundsCheck(error.FilePathTooLong, .{tok.len >= max_path_len}, "site file name", runfile_name, err_log);
        @memcpy(self.site_file.site.name[0..tok.len], tok);
        self.site_file.site.len = tok.len;
    }
    ///This method gets start year
    fn getStartYear(self: *IoFiles, reader: *std.Io.Reader, runfile_name: []const u8, err_log: *std.Io.Writer) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        var tokens = Tokens{};
        try tokens.tokenizeLine(line, 1, "start year", runfile_name, err_log);
        const tok = tokens.items[0];
        self.start_yr = try parseTokToInt(usize, tok, "start year", runfile_name, err_log);
    }
    ///This method gets all I/O file names within a scene
    fn getSceneIoFiles(self: *IoFiles, reader: *std.Io.Reader, runfile_name: []const u8, err_log: *std.Io.Writer, scenario: usize, scene: usize) !void {
        const field_names = [_]*[nscenario][nscene][max_path_len]u8{ &self.wthr_file.wthr_net.name, &self.opt_file.name, &self.soil_mgmt_file.soil_mgmt.name, &self.plant_mgmt_file.plant_mgmt.name, &self.hourly_out_file.carbon.name, &self.hourly_out_file.water.name, &self.hourly_out_file.nitrogen.name, &self.hourly_out_file.phosphorus.name, &self.hourly_out_file.heat.name, &self.daily_out_file.carbon.name, &self.daily_out_file.water.name, &self.daily_out_file.nitrogen.name, &self.daily_out_file.phosphorus.name, &self.daily_out_file.heat.name };
        const field_name_lens = [_]*[nscenario][nscene]usize{ &self.wthr_file.wthr_net.len, &self.opt_file.len, &self.soil_mgmt_file.soil_mgmt.len, &self.plant_mgmt_file.plant_mgmt.len, &self.hourly_out_file.carbon.len, &self.hourly_out_file.water.len, &self.hourly_out_file.nitrogen.len, &self.hourly_out_file.phosphorus.len, &self.hourly_out_file.heat.len, &self.daily_out_file.carbon.len, &self.daily_out_file.water.len, &self.daily_out_file.nitrogen.len, &self.daily_out_file.phosphorus.len, &self.daily_out_file.heat.len };

        for (0..field_names.len) |i| {
            const line = try reader.takeDelimiterInclusive('\n');
            var tokens = Tokens{};
            try tokens.tokenizeLine(line, 1, "scene I/O files", runfile_name, err_log);
            const tok = tokens.items[0];
            try boundsCheck(error.FilePathTooLong, .{tok.len >= max_path_len}, "scene I/O file names", runfile_name, err_log);
            @memcpy(field_names[i][scenario][scene][0..tok.len], tok);
            field_name_lens[i][scenario][scene] = tok.len;
        }
    }
};
