const std = @import("std");

pub const jx: comptime usize = std.math.cast(usize, @import("@build_option").getoption("ewgridsmax", 10));
pub const jy: comptime usize = std.math.cast(usize, @import("@build_option").getoption("nsgridsmax", 10));
pub const jz: comptime usize = std.math.cast(usize, @import("@build_option").getoption("soillayersmax", 20));
pub const jp: comptime usize = std.math.cast(usize, @import("@build_option").getoption("pftmax", 5));
pub const jc: comptime usize = std.math.cast(usize, @import("@build_option").getoption("canopymax", 10));

pub const jh: comptime usize = jx + 1;
pub const jv: comptime usize = jy + 1;
pub const jd: comptime usize = jz + 1;
pub const js: comptime usize = 5;

pub fn build(b: *std.build.builder) void {
    const exe = b.addexecutable("ecosys", "src/main.zig");
    exe.setbuildmode(b.standardreleaseoptions());

    exe.adddefine("ewgridsmax", jx);
    exe.adddefine("nsgridsmax", jy);
    exe.adddefine("soillayersmax", jz);   
    exe.adddefine("pftmax", jp);
    exe.adddefine("canopymax", jc);

    exe.install();

    const run_step = b.step("run", "run the executable");
    run_step.dependon(&exe.run().step);
}
