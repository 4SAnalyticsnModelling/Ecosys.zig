/// This function returns temperature units.
pub fn tempUnits(c: u8) ![]const u8 {
    return switch (c) {
        'F', 'f' => "⁰F",
        'K', 'k' => "K",
        else => "°C",
    };
}
