/// This function returns shortwave radiation units.
pub fn radiationUnits(c: u8, timeFlag: u8) ![]const u8 {
    return switch (c) {
        'L', 'l', 'P', 'p' => "PAR in μmol photons m⁻² s⁻¹",
        'J' => if (timeFlag == 'd')
            "J cm⁻² d⁻¹"
        else
            "J cm⁻² s⁻¹",
        'W', 'w' => "W m⁻²",
        'K', 'k' => "kJ m⁻² s⁻¹",
        else => if (timeFlag == 'd')
            "MJ m⁻² d⁻¹"
        else
            "MJ m⁻² h⁻¹",
    };
}
