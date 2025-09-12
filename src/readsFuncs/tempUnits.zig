/// This function returns temperature units.
pub fn tempUnits(c: u8) ![]const u8 {
    return switch (c) {
        'f' => "⁰F",
        'k' => "⁰K",
        else => "°C",
    };
}
