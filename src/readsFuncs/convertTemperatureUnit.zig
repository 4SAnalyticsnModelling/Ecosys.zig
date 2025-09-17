/// This function converts different temperature units to model unit (⁰C).
pub fn convertTemperatureUnit(tempIn: f32, tempUnitIn: u8) !f32 {
    return switch (tempUnitIn) {
        'f' => (tempIn - 32.0) * 0.556,
        'k' => tempIn - 273.16,
        else => tempIn,
    };
}
