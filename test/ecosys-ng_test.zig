//Import all modules that include code tests into this root file to be executed during compilation. This file makes sure all tests pass during compilation hence ensuring maximum possible code saftey during runtime
const std = @import("std");
const ecosys_ng = @import("ecosys-ng");
const util = ecosys_ng.util;
const io = ecosys_ng.io;
const utils = util.utils;
const input_parser = util.input_parser;

//Call all modules that have localized test blocks
test "all utils code tests entrypoint" {
    _ = utils;
}

test "all input_parse code tests entrypoint" {
    _ = input_parser;
}
