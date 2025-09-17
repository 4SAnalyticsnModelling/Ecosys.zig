/// This function returns date variables.
pub fn dateVars(ttype: u8) anyerror![]const u8 {
    return switch (ttype) {
        'h' => "hour",
        'd' => "day",
        'm' => "month",
        'y' => "year",
        else => "n/a",
    };
}
