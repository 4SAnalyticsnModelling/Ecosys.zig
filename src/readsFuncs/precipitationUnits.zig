/// This function returns precipitation units.
pub fn precipitationUnits(c: u8, timeFlag: u8) ![]const u8 {
    return switch (c) {
        'm' => if (timeFlag == 'd')
            "m d⁻¹"
        else
            "m h⁻¹",
        'c' => if (timeFlag == 'd')
            "cm d⁻¹"
        else
            "cm h⁻¹",
        'i' => if (timeFlag == 'd')
            "inches d⁻¹"
        else
            "inches h⁻¹",
        's' => "m s⁻¹",
        else => "mm h⁻¹",
    };
}
