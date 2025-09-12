/// This function returns wind speed units.
pub fn windspeedUnits(c: u8) ![]const u8 {
    return switch (c) {
        'S' => "m s⁻¹",
        'H' => "km h⁻¹",
        'D' => "km d⁻¹",
        'M' => "mile h⁻¹",
        else => "m h⁻¹",
    };
}
