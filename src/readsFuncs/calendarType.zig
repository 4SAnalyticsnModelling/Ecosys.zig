/// This function returns date format details.
pub fn calendarType(ctype: u8) ![]const u8 {
    return switch (ctype) {
        'J', 'j' => "julian date",
        else => "calendar date",
    };
}
