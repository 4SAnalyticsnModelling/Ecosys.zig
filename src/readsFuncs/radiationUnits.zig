/// This function returns shortwave radiation units.
pub fn radiationUnits(c: u8, timeFlag: u8) ![]const u8 {
    return switch (c) {
        'l', 'p' => "PAR in μmol photons m⁻² s⁻¹",
        'j' => if (timeFlag == 'd')
            "J cm⁻² d⁻¹"
        else
            "J cm⁻² s⁻¹",
        'w' => "W m⁻²",
        'k' => "kJ m⁻² s⁻¹",
        else => if (timeFlag == 'd')
            "MJ m⁻² d⁻¹"
        else
            "MJ m⁻² h⁻¹",
    };
}
