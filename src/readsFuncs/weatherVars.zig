/// This function returns full names of the weather variables from character symbols.
pub fn weatherVars(c: u8) ![]const u8 {
    return switch (c) {
        'm' => "max. daily temperature",
        'n' => "min. daily temperature",
        't' => "hourly temperature",
        'w' => "wind speed",
        'h' => "humidity",
        'r' => "shortwave radiation",
        'p' => "precipitation",
        'l' => "longwave radiation",
        else => "n/a",
    };
}
