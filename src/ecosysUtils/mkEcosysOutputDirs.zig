const std = @import("std");
const mkDir = @import("mkDir.zig").mkDir;

/// This function creates ecosys output directory tree.
pub fn mkEcosysOutputDirs() !void {
    // Create or overwrite the parent directory for all outputs
    try mkDir("outputs");
    // Create or overwrite the directory to save all error log files
    try mkDir("outputs/errorLogs");
    // Create or overwrite the directory to save all run progress tracker files
    try mkDir("outputs/runStatusLogs");
    // Create or overwrite the directory to save all model inputs and other check files
    try mkDir("outputs/checkPointLogs");
    // Create or overwrite the directory to save all modelled outputs for hourly and daily plant, soil, and ecosystem carbon, water, heat, nitrogen and phosphorus cycles
    try mkDir("outputs/modelledOutputs");
}
