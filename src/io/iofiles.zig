const std = @import("std");
const config = @import("config");
const nscenario: usize = config.nscenariox;
const nscene: usize = config.nscenex;
const nwe: usize = config.nwex;
const nns: usize = config.nnsx;
const nplant: usize = config.nplantx;
const Tokens = @import("../util/buffers.zig").Tokens;
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
///This struct reads the names of the model input files within the runfile.
pub const IOFiles = struct {
    agr_silv_past_op: [nscenario][nscene][nwe][nns][nplant][]const u8 = undefined, // files containing inputs on agriculture, silviculture, pasture operations (e.g. planting, harvesting, thinning, grazing etc.).
    plant_spp: [nscenario][nscene][nwe][nns][nplant][]const u8 = undefined,
    wthr: [nscenario][nscene][nwe][nns][]const u8 = undefined,
    till: [nscenario][nscene][nwe][nns][]const u8 = undefined,
    fert: [nscenario][nscene][nwe][nns][]const u8 = undefined,
    irrig: [nscenario][nscene][nwe][nns][]const u8 = undefined,
    soil_mgmt: [nscenario][nscene][]const u8 = undefined,
    plant_mgmt: [nscenario][nscene][]const u8 = undefined,
    opts: [nscenario][nscene][]const u8 = undefined,
    wthr_net: [nscenario][nscene][]const u8 = undefined,
    daily_c_out: [nscenario][nscene][]const u8 = undefined,
    daily_wtr_out: [nscenario][nscene][]const u8 = undefined,
    daily_n_out: [nscenario][nscene][]const u8 = undefined,
    daily_p_out: [nscenario][nscene][]const u8 = undefined,
    daily_heat_out: [nscenario][nscene][]const u8 = undefined,
    hrly_c_out: [nscenario][nscene][]const u8 = undefined,
    hrly_wtr_out: [nscenario][nscene][]const u8 = undefined,
    hrly_n_out: [nscenario][nscene][]const u8 = undefined,
    hrly_p_out: [nscenario][nscene][]const u8 = undefined,
    hrly_heat_out: [nscenario][nscene][]const u8 = undefined,
    land_unit: [nwe][nns][]const u8 = undefined,
    soil: [nwe][nns][]const u8 = undefined,
    site: []const u8 = undefined,
    start_yr: u32 = 0,
    grid_num: GridNum = GridNum{},
    grid_pos: GridPos = GridPos{},
    tokens: Tokens = Tokens{},
    scenario: Scenario = Scenario{},
    scene: Scene = Scene{},

    pub fn getAllIOFiles(self: *IOFiles, reader: *std.Io.Reader, err_log: *std.Io.Writer) !void {
        try self.getGridNums(reader, err_log);
        try self.getSite(reader, err_log);
        try self.getStartYear(reader, err_log);
        try self.getScenario(reader, err_log);
        for (0..self.scenario.num) |scenario_id| {
            try self.getScene(reader, err_log);
            for (0..self.scene.num) |scene_id| {
                try getSceneIOFiles(self, reader, err_log, scenario_id, scene_id);
            }
        }
    }

    fn getGridNums(self: *IOFiles, reader: *std.Io.Reader, err_log: *std.Io.Writer) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        try self.tokens.tokenizeLine(line);
        const fields: [4]*usize = .{ &self.grid_num.west, &self.grid_num.north, &self.grid_num.east, &self.grid_num.south };
        for (self.tokens.items[0..fields.len], 0..) |tok, i| {
            fields[i].* = std.fmt.parseInt(usize, tok, 10) catch |err| {
                try err_log.print("error: {s} while parsing grid numbers in runfile\n", .{@errorName(err)});
                try err_log.flush();
                std.debug.print("\x1b[1;31merror: {s} while parsing grid numbers in runfile\x1b[0m\n", .{@errorName(err)});
                return err;
            };
        }
        if (self.grid_num.west < 0 or self.grid_num.west > self.grid_num.east or self.grid_num.east > nwe or self.grid_num.north < 0 or self.grid_num.north > self.grid_num.south or self.grid_num.south > nns) {
            const err = error.GridOutOfBounds;
            try err_log.print("error: {s} while reading grid numbers in runfile\n", .{@errorName(err)});
            try err_log.flush();
            std.debug.print("\x1b[1;31merror: {s} while reading grid numbers in runfile\x1b[0m\n", .{@errorName(err)});
            return err;
        }
    }

    fn getSite(self: *IOFiles, reader: *std.Io.Reader, err_log: *std.Io.Writer) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        try self.tokens.tokenizeLine(line);
        if (self.tokens.len != 1) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while reading site file name in runfile\n", .{@errorName(err)});
            try err_log.flush();
            std.debug.print("\x1b[1;31merror: {s} while reading site file name in runfile\x1b[0m\n", .{@errorName(err)});
            return err;
        }
        self.site = self.tokens.items[0];
    }

    fn getStartYear(self: *IOFiles, reader: *std.Io.Reader, err_log: *std.Io.Writer) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        try self.tokens.tokenizeLine(line);
        if (self.tokens.len != 1) {
            const err = error.InvalidTokens;
            try err_log.print("error: {s} while reading start year in runfile\n", .{@errorName(err)});
            try err_log.flush();
            std.debug.print("\x1b[1;31merror: {s} while reading start year in runfile\x1b[0m\n", .{@errorName(err)});
            return err;
        }
        self.start_yr = std.fmt.parseInt(u32, self.tokens.items[0], 10) catch |err| {
            try err_log.print("error: {s} while parsing start year in runfile\n", .{@errorName(err)});
            try err_log.flush();
            std.debug.print("\x1b[1;31merror: {s} while parsing start year in runfile\x1b[0m\n", .{@errorName(err)});
            return err;
        };
    }

    fn getScenario(self: *IOFiles, reader: *std.Io.Reader, err_log: *std.Io.Writer) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        try self.tokens.tokenizeLine(line);
        const fields: [2]*usize = .{ &self.scenario.num, &self.scenario.repeat };
        for (self.tokens.items[0..fields.len], 0..) |tok, i| {
            fields[i].* = std.fmt.parseInt(usize, tok, 10) catch |err| {
                try err_log.print("error: {s} while parsing number of scenarios and times to repeat each scenarios in runfile\n", .{@errorName(err)});
                try err_log.flush();
                std.debug.print("\x1b[1;31merror: {s} while parsing number of scenarios and times to repeat each scenarios in runfile\x1b[0m\n", .{@errorName(err)});
                return err;
            };
        }
    }

    fn getScene(self: *IOFiles, reader: *std.Io.Reader, err_log: *std.Io.Writer) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        try self.tokens.tokenizeLine(line);
        const fields: [2]*usize = .{ &self.scene.num, &self.scene.repeat };
        for (self.tokens.items[0..fields.len], 0..) |tok, i| {
            fields[i].* = std.fmt.parseInt(usize, tok, 10) catch |err| {
                try err_log.print("error: {s} while parsing number of scenes and times to repeat each scene in runfile\n", .{@errorName(err)});
                try err_log.flush();
                std.debug.print("\x1b[1;31merror: {s} while parsing number of scenes and times to repeat each scene in runfile\x1b[0m\n", .{@errorName(err)});
                return err;
            };
        }
    }

    fn getSceneIOFiles(self: *IOFiles, reader: *std.Io.Reader, err_log: *std.Io.Writer, scenario_id: usize, scene_id: usize) !void {
        const fields: [14]*[nscenario][nscene][]const u8 = .{ &self.wthr_net, &self.opts, &self.soil_mgmt, &self.plant_mgmt, &self.hrly_c_out, &self.hrly_wtr_out, &self.hrly_n_out, &self.hrly_p_out, &self.hrly_heat_out, &self.daily_c_out, &self.daily_wtr_out, &self.daily_n_out, &self.daily_p_out, &self.daily_heat_out };
        for (fields) |item| {
            const line = try reader.takeDelimiterInclusive('\n');
            try self.tokens.tokenizeLine(line);
            if (self.tokens.len != 1) {
                const err = error.InvalidTokens;
                try err_log.print("error: {s} while reading scene io files in runfile\n", .{@errorName(err)});
                try err_log.flush();
                std.debug.print("\x1b[1;31merror: {s} while reading scene io files in runfile\x1b[0m\n", .{@errorName(err)});
                return err;
            }
            item[scenario_id][scene_id] = self.tokens.items[0];
        }
    }

    fn getGridPos(self: *IOFiles, reader: *std.Io.Reader, err_log: *std.Io.Writer, file: []const u8) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        try self.tokens.tokenizeLine(line);
        const fields: [4]*usize = .{ &self.grid_pos.west, &self.grid_pos.north, &self.grid_pos.east, &self.grid_pos.south };
        for (self.tokens.items[0..fields.len], 0..) |tok, i| {
            fields[i].* = std.fmt.parseInt(usize, tok, 10) catch |err| {
                try err_log.print("error: {s} while parsing grid positions in {s}\n", .{ @errorName(err), file });
                try err_log.flush();
                std.debug.print("\x1b[1;31merror: {s} while parsing grid positions in {s}\x1b[0m\n", .{ @errorName(err), file });
                return err;
            };
        }
    }

    fn getGridPlants(self: *IOFiles, reader: *std.Io.Reader, err_log: *std.Io.Writer, file: []const u8) !void {
        const line = try reader.takeDelimiterInclusive('\n');
        try self.tokens.tokenizeLine(line);
        const fields: [5]*usize = .{ &self.grid_pos.west, &self.grid_pos.north, &self.grid_pos.east, &self.grid_pos.south, &self.grid_pos.plants };
        for (self.tokens.items[0..fields.len], 0..) |tok, i| {
            fields[i].* = std.fmt.parseInt(usize, tok, 10) catch |err| {
                try err_log.print("error: {s} while parsing grid positions and plant ids in {s}\n", .{ @errorName(err), file });
                try err_log.flush();
                std.debug.print("\x1b[1;31merror: {s} while parsing grid positions and plant ids in {s}\x1b[0m\n", .{ @errorName(err), file });
                return err;
            };
        }
    }
};
