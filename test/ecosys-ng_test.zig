//Import all modules that include code tests into this root file to be executed during compilation. This file makes sure all tests pass during compilation hence ensuring maximum possible code saftey during runtime
const std = @import("std");
const ecosys_ng = @import("ecosys-ng");
const util = ecosys_ng.util;
const io = ecosys_ng.io;
const utils = util.utils;
const input_parser = util.input_parser;
const iofiles = io.iofiles;
const iochecks = io.iochecks;

//Call all modules that have localized test blocks
test "all uitls code tests entrypoint" {
    _ = utils;
}

test "all input_parse code tests entrypoint" {
    _ = input_parser;
}

test "all iofiles code tests entrypoint" {
    _ = iofiles;
}

test "all iochecks code tests entrypoint" {
    _ = iochecks;
}
