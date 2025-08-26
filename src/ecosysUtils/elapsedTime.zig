const std = @import("std");

pub fn elapsedTime(
    startTime_us: i64, // us = Micro Second
    endTime_us: i64,
) struct { value: f64, unit: []const u8 } {
    const elapsed_us: i64 = endTime_us - startTime_us;
    const elapsed_us_float: f64 = @floatFromInt(elapsed_us);
    const us_per_ms: i64 = std.time.us_per_ms;
    const us_per_s: i64 = std.time.us_per_s;
    const us_per_min: i64 = std.time.us_per_min;
    const us_per_hour: i64 = std.time.us_per_hour;
    const us_per_day: i64 = std.time.us_per_day;
    const us_per_week: i64 = std.time.us_per_week;

    if (elapsed_us < us_per_ms) {
        return .{ .value = elapsed_us_float, .unit = "μs" };
    } else if (elapsed_us < us_per_s) {
        return .{ .value = elapsed_us_float / us_per_ms, .unit = "ms" };
    } else if (elapsed_us < us_per_min) {
        return .{ .value = elapsed_us_float / us_per_s, .unit = "s" };
    } else if (elapsed_us < us_per_hour) {
        return .{ .value = elapsed_us_float / us_per_min, .unit = "min" };
    } else if (elapsed_us < us_per_day) {
        return .{ .value = elapsed_us_float / us_per_hour, .unit = "hr" };
    } else if (elapsed_us < us_per_week) {
        return .{ .value = elapsed_us_float / us_per_day, .unit = "d" };
    } else {
        return .{ .value = elapsed_us_float / us_per_week, .unit = "wk" };
    }
}
