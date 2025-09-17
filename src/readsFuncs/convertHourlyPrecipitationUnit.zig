/// This function converts different units of hourly precipitation to model unit (mm h⁻¹).
pub fn convertHourlyPrecipitationUnit(precipIn: f32, precipUnitIn: u8, nSubHour: usize) !f32 {
    return switch (precipUnitIn) {
        'm' => @max(0.0, precipIn / 1e03),
        'c' => @max(0.0, precipIn / 1e02),
        'i' => @max(0.0, precipIn * 0.0254),
        's' => @max(0.0, precipIn * 3.6 / @as(f32, @floatFromInt(nSubHour))),
        else => precipIn,
    };
}
