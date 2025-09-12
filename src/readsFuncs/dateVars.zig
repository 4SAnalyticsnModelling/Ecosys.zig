/// This function returns date variables.
pub fn dateVars(ttype: u8) anyerror![]const u8 {
    return switch (ttype) {
        'H', 'h' => "hour",
        'D', 'd' => "day",
        'M', 'm' => "month",
        'Y', 'y' => "year",
        else => "n/a",
    };
}
