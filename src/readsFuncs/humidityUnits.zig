/// This function returns humidity units.
pub fn humidityUnits(c: u8) ![]const u8 {
    return switch (c) {
        'd' => "dew point (°C)",
        'f' => "dew point (⁰F)",
        'h' => "relative humidity (fraction 0–1)",
        'r' => "relative humidity (%)",
        's' => "specific humidity (kg kg⁻¹)",
        'g' => "mixing ratio (g kg⁻¹)",
        'm' => "vapor pressure (hpa or mb)",
        else => "vapor pressure (kpa)",
    };
}
