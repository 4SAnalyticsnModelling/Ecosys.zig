/// This function returns humidity units.
pub fn humidityUnits(c: u8) ![]const u8 {
    return switch (c) {
        'D', 'd' => "dew point (°C)",
        'F', 'f' => "dew point (⁰F)",
        'H', 'h' => "relative humidity (fraction 0–1)",
        'R', 'r' => "relative humidity (%)",
        'S', 's' => "specific humidity (kg kg⁻¹)",
        'G', 'g' => "mixing ratio (g kg⁻¹)",
        'M', 'm' => "vapor pressure (hpa or mb)",
        else => "vapor pressure (kpa)",
    };
}
