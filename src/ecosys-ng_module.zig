const std = @import("std");
//ecosys-ng modules
pub const util = struct {
    pub const utils = @import("../src/util/utils.zig");
    pub const input_parser = @import("../src/util/input_parser.zig");
    pub const err_handler = @import("../src/util/error_check.zig");
};

pub const io = struct {
    pub const geo_attr = @import("../src/io/geo_attributes.zig");
    pub const load_run = @import("../src/io/load_run.zig");
};
