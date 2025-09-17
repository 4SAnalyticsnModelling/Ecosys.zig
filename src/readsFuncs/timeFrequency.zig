/// This function returns time step or frequency details.
pub fn timeFrequency(ttype: u8) anyerror![]const u8 {
    return switch (ttype) {
        's' => "sub-hourly",
        'h' => "hourly",
        'd' => "daily",
        '3' => "3-hourly",
        else => error.InvalidDateFormatInWeatherUnitFileHeader,
    };
}
