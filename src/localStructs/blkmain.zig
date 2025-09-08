const std = @import("std");

pub const Blkmain = struct {
    data: [30][]const u8 = undefined,
    months: [12][]const u8 = .{ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" },
    iflgy: u32 = 0,
    iyrx: u32 = 0,
    iyrd: u32 = 0,
    nscene: usize = 0,
    tlw: u32 = 0,
    tlh: u32 = 0,
    tlo: u32 = 0,
    tlc: u32 = 0,
    tln: u32 = 0,
    tlp: u32 = 0,
    tli: u32 = 0,
    lun: u32 = 0,

    pub fn init() Blkmain {
        return .{};
    }
};
