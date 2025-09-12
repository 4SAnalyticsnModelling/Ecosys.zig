/// This function returns wind speed units.
pub fn windspeedUnits(c: u8) ![]const u8 {
    return switch (c) {
        's' => "m s⁻¹",
        'h' => "km h⁻¹",
        'd' => "km d⁻¹",
        'm' => "mile h⁻¹",
        else => "m h⁻¹",
    };
}
