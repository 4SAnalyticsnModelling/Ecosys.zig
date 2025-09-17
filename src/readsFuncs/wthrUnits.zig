const radiationUnits = @import("radiationUnits.zig").radiationUnits;
const humidityUnits = @import("humidityUnits.zig").humidityUnits;
const precipitationUnits = @import("precipitationUnits.zig").precipitationUnits;
const windspeedUnits = @import("windspeedUnits.zig").windspeedUnits;
const tempUnits = @import("tempUnits.zig").tempUnits;

/// This function returns weather units based on weather variables.
pub fn wthrUnits(wthrVar: u8, wthrVarUnit: u8, timeStep: u8) ![]const u8 {
    return switch (wthrVar) {
        'r' => try radiationUnits(wthrVarUnit, timeStep),
        'h' => try humidityUnits(wthrVarUnit),
        'p' => try precipitationUnits(wthrVarUnit, timeStep),
        'w' => try windspeedUnits(wthrVarUnit),
        'm', 'n', 't' => try tempUnits(wthrVarUnit),
        else => "n/a",
    };
}
