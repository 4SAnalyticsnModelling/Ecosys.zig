/// This function returns full names of the weather variables from character symbols.
pub fn weatherVars(c: u8) ![]const u8 {
    return switch (c) {
        'M', 'm' => "max. daily temperature",
        'N', 'n' => "min. daily temperature",
        'T', 't' => "hourly temperature",
        'W', 'w' => "wind speed",
        'H', 'h' => "humidity",
        'R', 'r' => "shortwave radiation",
        'P', 'p' => "precipitation",
        'L', 'l' => "longwave radiation",
        else => "n/a",
    };
}
