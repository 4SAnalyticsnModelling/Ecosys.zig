/// This function returns precipitation units.
pub fn precipitationUnits(c: u8, timeFlag: u8) ![]const u8 {
    return switch (c) {
        'M', 'm' => if (timeFlag == 'd')
            "m d⁻¹"
        else
            "m h⁻¹",
        'C', 'c' => if (timeFlag == 'd')
            "cm d⁻¹"
        else
            "cm h⁻¹",
        'I', 'i' => if (timeFlag == 'd')
            "inches d⁻¹"
        else
            "inches h⁻¹",
        'S', 's' => "mm min⁻¹",
        else => "mm h⁻¹",
    };
}
