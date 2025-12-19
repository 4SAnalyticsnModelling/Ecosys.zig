const std = @import("std");
const ecosys_ng = @import("ecosys-ng");
const util = ecosys_ng.util;
const utils = util.utils;
const parser = util.input_parser;

pub const LatLonRangeAndTileSpecs = packed struct {
    lat_min_ud: i32 = undefined, //minimum latitude of the domain rounded to the nearest micro degree
    lat_max_ud: i32 = undefined, //maximum latitude of the domain rounded to the nearest micro degree
    lon_min_ud: i32 = undefined, //minimum longitude of the domain rounded to the nearest micro degree
    lon_max_ud: i32 = undefined, //maximum longitude of the domain rounded to the nearest micro degree
    dlat_ud: i32 = undefined, //latitude spacing to be simulated rounded to the nearest micro degree
    dlon_ud: i32 = undefined, //longitude spacing to be simulated rounded to the nearest micro degree
    ntx: usize = undefined, //number of west-east grids in a tile
    nty: usize = undefined, //number of north-south grids in a tile

    pub fn read(self: *LatLonRangeAndTileSpecs, file_name: []const u8, reader: *std.Io.Reader, err_log: *std.Io.Writer) !void {
        var line = try parser.readNextDataLine(reader);
        var tokens = parser.Tokens{};
        try tokens.tokenizeLine(line, 6, "domain lat-lon range, and lat-lon spacing", file_name, err_log);
        const fields = [_]*i32{ &self.lat_min_ud, &self.lat_max_ud, &self.lon_min_ud, &self.lon_max_ud, &self.dlat_ud, &self.dlon_ud };
        for (tokens.items[0..fields.len], 0..) |tok, i| {
            const geo_loc_d = try parser.parseTokToFloat(f32, tok, "domain lat-lon range", file_name, err_log);
            const geo_loc_ud: i32 = @intFromFloat(@round(geo_loc_d * 1e6));
            fields[i].* = geo_loc_ud;
        }
        line = try parser.readNextDataLine(reader);
        try tokens.tokenizeLine(line, 2, "tile specifications", file_name, err_log);
        const fields_tile = [_]*usize{ &self.ntx, &self.nty };
        for (tokens.items[0..fields_tile.len], 0..) |tok, i| {
            fields_tile[i].* = try parser.parseTokToInt(usize, tok, "tile specifications", file_name, err_log);
        }
    }
};

pub const GeoAttr = packed struct {
    file_path: []const u8 = undefined, //geospatial attributes file path
    lat_ud: u32 = undefined, //latitude rounded to the nearest microdegree
    lon_ud: u32 = undefined, //longitude rounded to the nearest microdegree
    elevation: f32 = undefined, //elevation/altitude (m)
    matc: f32 = undefined, //mean annual temperature (⁰C)
};
