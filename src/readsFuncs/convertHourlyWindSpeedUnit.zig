/// This function converts different units of hourly wind speed to model unit (m h⁻¹).
pub fn convertHourlyWindSpeedUnit(windIn: f32, windUnitIn: u8) !f32 {
    return switch (windUnitIn) {
        's' => windIn * 3600.0,
        'h' => windIn * 1000.0,
        'm' => windIn * 1600.0,
        else => windIn,
    };
}
