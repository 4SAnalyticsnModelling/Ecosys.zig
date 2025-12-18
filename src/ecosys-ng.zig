const std = @import("std");

//ecosys-ng modules
pub const util = struct {
    pub const utils = @import("util/utils.zig");
    pub const input_parser = @import("util/input_parser.zig");
};

pub const io = struct {
    pub const iofiles = @import("io/iofiles.zig");
    pub const iochecks = @import("io/iochecks.zig");
};

///ecosys-ng main function
pub fn main() void {}
