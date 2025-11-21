const std = @import("std");
const config = @import("config");
const nscenario: usize = config.nscenariox;
const nscene: usize = config.nscenex;
const nwe: usize = config.nwex;
const nns: usize = config.nnsx;
const nplant: usize = config.nplantx;
const RunArg = @import("../util/input_parser.zig").RunArg;
const Tokens = @import("../util/input_parser.zig").Tokens;
///Grid numbers in different directions.
const GridNum = struct {
    west: usize = 0,
    north: usize = 0,
    east: usize = 0,
    south: usize = 0,
};
///Grid positions in different directions.
const GridPos = struct {
    west: usize = 0,
    north: usize = 0,
    east: usize = 0,
    south: usize = 0,
    plants: usize = 0,
};
///Scenarios.
const Scenario = struct {
    num: usize = 0,
    repeat: usize = 0,
};
///Scenes.
const Scene = struct {
    num: usize = 0,
    repeat: usize = 0,
};
///Site file names.
const SiteFile = struct {
    land_unit: [nwe][nns][]const u8 = undefined, //landscape unit within a site
    soil: [nwe][nns][]const u8 = undefined, //soil file for each landscape unit
    site: []const u8 = undefined,
};
///Weather file names.
const WthrFile = struct {
    wthr: [nscenario][nscene][nwe][nns][]const u8 = undefined, // weather file within a weather network
    wthr_net: [nscenario][nscene][]const u8 = undefined, //network of all weather files.
};
///Soil management file names.
const SoilMgmtFile = struct {
    till: [nscenario][nscene][nwe][nns][]const u8 = undefined,
    fert: [nscenario][nscene][nwe][nns][]const u8 = undefined,
    irrig: [nscenario][nscene][nwe][nns][]const u8 = undefined,
    mgmt: [nscenario][nscene][]const u8 = undefined,
};
///Plant management file names.
const PlantMgmtFile = struct {
    plant: [nscenario][nscene][nwe][nns][nplant][]const u8 = undefined,
    operation: [nscenario][nscene][nwe][nns][nplant][]const u8 = undefined,
    mgmt: [nscenario][nscene][]const u8 = undefined,
};
///Daily output file names.
const HourlyOutFile = struct {
    carbon: [nscenario][nscene][]const u8 = undefined,
    water: [nscenario][nscene][]const u8 = undefined,
    nitrogen: [nscenario][nscene][]const u8 = undefined,
    phosphorus: [nscenario][nscene][]const u8 = undefined,
    heat: [nscenario][nscene][]const u8 = undefined,
};
///Daily output file names.
const DailyOutFile = struct {
    carbon: [nscenario][nscene][]const u8 = undefined,
    water: [nscenario][nscene][]const u8 = undefined,
    nitrogen: [nscenario][nscene][]const u8 = undefined,
    phosphorus: [nscenario][nscene][]const u8 = undefined,
    heat: [nscenario][nscene][]const u8 = undefined,
};
///This struct reads the names of the model input files within the runfile.
pub const IOFiles = struct {
    grid_num: GridNum = GridNum{},
    site_file: SiteFile = SiteFile{},
    start_yr: u32 = 0,
    scenario: Scenario = Scenario{},
    scene: Scene = Scene{},
    wthr_file: WthrFile = WthrFile{},
    opt_file: [nscenario][nscene][]const u8 = undefined,
    plant_mgmt_file: PlantMgmtFile = PlantMgmtFile{},
    soil_mgmt_file: SoilMgmtFile = SoilMgmtFile{},
    daily_out_file: DailyOutFile = DailyOutFile{},
    hourly_out_file: HourlyOutFile = HourlyOutFile{},
    tokens: Tokens = Tokens{},

    ///This method gets all I/O files.
    pub fn getAllIOFiles(self: *IOFiles, reader: *std.Io.Reader, run: *const RunArg, err_log: *std.Io.Writer) !void {
        try self.getGridNums(reader, run, err_log);
        try self.getSite(reader, run, err_log);
        try self.getStartYear(reader, run, err_log);
        try self.getScenario(reader, run, err_log);
        for (0..self.scenario.num) |scenario_id| {
            try self.getScene(reader, run, err_log);
            for (0..self.scene.num) |scene_id| {
                try getSceneIOFiles(self, reader, run, err_log, scenario_id, scene_id);
            }
        }
        try err_log.flush();
    }
    ///This method gets grid numbers in four directions.
    fn getGridNums(self: *IOFiles, reader: *std.Io.Reader, run: *const RunArg, err_log: *std.Io.Writer) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        try self.tokens.tokenizeLine(line);
        const fields: [4]*usize = .{ &self.grid_num.west, &self.grid_num.north, &self.grid_num.east, &self.grid_num.south };
        for (self.tokens.items[0..fields.len], 0..) |tok, i| {
            fields[i].* = std.fmt.parseInt(usize, tok, 10) catch |err| {
                try err_log.print("error: {s} while parsing grid numbers in {s}\n", .{ @errorName(err), run.run });
                std.debug.print("\x1b[1;31merror: {s} while parsing grid numbers in {s}\x1b[0m\n", .{ @errorName(err), run.run });
                return err;
            };
        }
        if (self.grid_num.west < 0 or self.grid_num.west > self.grid_num.east or self.grid_num.east > nwe or self.grid_num.north < 0 or self.grid_num.north > self.grid_num.south or self.grid_num.south > nns) {
            const err = error.GridOutOfBounds;
            try err_log.print("error: {s} while reading grid numbers in {s}\n", .{ @errorName(err), run.run });
            std.debug.print("\x1b[1;31merror: {s} while reading grid numbers in {s}\x1b[0m\n", .{ @errorName(err), run.run });
            return err;
        }
    }
    ///This method gets site file name.
    fn getSite(self: *IOFiles, reader: *std.Io.Reader, run: *const RunArg, err_log: *std.Io.Writer) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        try self.tokens.tokenizeLine(line);
        if (self.tokens.len != 1) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while reading site file name in {s}\n", .{ @errorName(err), run.run });
            std.debug.print("\x1b[1;31merror: {s} while reading site file name in {s}\x1b[0m\n", .{ @errorName(err), run.run });
            return err;
        }
        self.site_file.site = self.tokens.items[0];
    }
    ///This method gets start year.
    fn getStartYear(self: *IOFiles, reader: *std.Io.Reader, run: *const RunArg, err_log: *std.Io.Writer) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        try self.tokens.tokenizeLine(line);
        if (self.tokens.len != 1) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while reading start year in {s}\n", .{ @errorName(err), run.run });
            std.debug.print("\x1b[1;31merror: {s} while reading start year in {s}\x1b[0m\n", .{ @errorName(err), run.run });
            return err;
        }
        self.start_yr = std.fmt.parseInt(u32, self.tokens.items[0], 10) catch |err| {
            try err_log.print("error: {s} while parsing start year in {s}\n", .{ @errorName(err), run.run });
            std.debug.print("\x1b[1;31merror: {s} while parsing start year in {s}\x1b[0m\n", .{ @errorName(err), run.run });
            return err;
        };
    }
    ///This method gets number of scenarios and times to repeat each scenario.
    fn getScenario(self: *IOFiles, reader: *std.Io.Reader, run: *const RunArg, err_log: *std.Io.Writer) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        try self.tokens.tokenizeLine(line);
        if (self.tokens.len != 2) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while reading number of scenarios and times to repeat each scenario in {s}\n", .{ @errorName(err), run.run });
            std.debug.print("\x1b[1;31merror: {s} while number of scenarios and times to repeat each scenario in {s}\x1b[0m\n", .{ @errorName(err), run.run });
            return err;
        }
        const fields: [2]*usize = .{ &self.scenario.num, &self.scenario.repeat };
        for (self.tokens.items[0..fields.len], 0..) |tok, i| {
            fields[i].* = std.fmt.parseInt(usize, tok, 10) catch |err| {
                try err_log.print("error: {s} while parsing number of scenarios and times to repeat each scenario in {s}\n", .{ @errorName(err), run.run });
                std.debug.print("\x1b[1;31merror: {s} while parsing number of scenarios and times to repeat each scenario in {s}\x1b[0m\n", .{ @errorName(err), run.run });
                return err;
            };
        }
        if (self.scenario.num > nscenario) {
            const err = error.ScenarioOutOfBounds;
            try err_log.print("error: {s} while reading number of scenarios in {s}\n", .{ @errorName(err), run.run });
            std.debug.print("\x1b[1;31merror: {s} while reading number of scenarios in {s}\x1b[0m\n", .{ @errorName(err), run.run });
            return err;
        }
    }
    ///This method gets number of scenes and times to repeat each scene.
    fn getScene(self: *IOFiles, reader: *std.Io.Reader, run: *const RunArg, err_log: *std.Io.Writer) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        try self.tokens.tokenizeLine(line);
        if (self.tokens.len != 2) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while reading number of scenes and times to repeat each scene in {s}\n", .{ @errorName(err), run.run });
            std.debug.print("\x1b[1;31merror: {s} while number of scenes and times to repeat each scene in {s}\x1b[0m\n", .{ @errorName(err), run.run });
            return err;
        }
        const fields: [2]*usize = .{ &self.scene.num, &self.scene.repeat };
        for (self.tokens.items[0..fields.len], 0..) |tok, i| {
            fields[i].* = std.fmt.parseInt(usize, tok, 10) catch |err| {
                try err_log.print("error: {s} while parsing number of scenes and times to repeat each scene in {s}\n", .{ @errorName(err), run.run });
                std.debug.print("\x1b[1;31merror: {s} while parsing number of scenes and times to repeat each scene in {s}\x1b[0m\n", .{ @errorName(err), run.run });
                return err;
            };
        }
        if (self.scene.num > nscene) {
            const err = error.SceneOutOfBounds;
            try err_log.print("error: {s} while reading number of scenes in {s}\n", .{ @errorName(err), run.run });
            std.debug.print("\x1b[1;31merror: {s} while reading number of scenes in {s}\x1b[0m\n", .{ @errorName(err), run.run });
            return err;
        }
    }
    ///This method gets all I/O file names within a scene.
    fn getSceneIOFiles(self: *IOFiles, reader: *std.Io.Reader, run: *const RunArg, err_log: *std.Io.Writer, scenario_id: usize, scene_id: usize) !void {
        const fields: [14]*[nscenario][nscene][]const u8 = .{ &self.wthr_file.wthr_net, &self.opt_file, &self.soil_mgmt_file.mgmt, &self.plant_mgmt_file.mgmt, &self.hourly_out_file.carbon, &self.hourly_out_file.water, &self.hourly_out_file.nitrogen, &self.hourly_out_file.phosphorus, &self.hourly_out_file.heat, &self.daily_out_file.carbon, &self.daily_out_file.water, &self.daily_out_file.nitrogen, &self.daily_out_file.phosphorus, &self.daily_out_file.heat };
        for (fields) |item| {
            const line = try reader.takeDelimiterInclusive('\n');
            try self.tokens.tokenizeLine(line);
            if (self.tokens.len != 1) {
                const err = error.InvalidTokens;
                try err_log.print("error: {s} while reading scene io files in {s}\n", .{ @errorName(err), run.run });
                std.debug.print("\x1b[1;31merror: {s} while reading scene io files in {s}\x1b[0m\n", .{ @errorName(err), run.run });
                return err;
            }
            item[scenario_id][scene_id] = self.tokens.items[0];
        }
    }
};
