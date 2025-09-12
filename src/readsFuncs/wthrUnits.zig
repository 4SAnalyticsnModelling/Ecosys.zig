const radiationUnits = @import("radiationUnits.zig").radiationUnits;
const humidityUnits = @import("humidityUnits.zig").humidityUnits;
const precipitationUnits = @import("precipitationUnits.zig").precipitationUnits;
const windspeedUnits = @import("windspeedUnits.zig").windspeedUnits;
const tempUnits = @import("tempUnits.zig").tempUnits;

/// This function returns weather units based on weather variables.
pub fn wthrUnits(wthrVar: u8, wthrVarUnit: u8, timeStep: u8) ![]const u8 {
    return switch (wthrVar) {
        'R', 'r' => try radiationUnits(wthrVarUnit, timeStep),
        'H', 'h' => try humidityUnits(wthrVarUnit),
        'P', 'p' => try precipitationUnits(wthrVarUnit, timeStep),
        'W', 'w' => try windspeedUnits(wthrVarUnit),
        'M', 'm', 'N', 'n', 'T', 't' => try tempUnits(wthrVarUnit),
        else => "n/a",
    };
}
