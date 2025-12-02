//Import all modules that include code tests into this root file to be executed during compilation. This file makes sure all tests pass during compilation hence ensuring maximum possible code saftey during runtime
const std = @import("std");
const utils = @import("util/utils.zig");
const iofiles = @import("io/iofiles.zig");

//Call all modules that have localized test blocks
test "all ecosys code tests entrypoint" {
    _ = utils;
    _ = iofiles;
}
