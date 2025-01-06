const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "ecosys",
        .root_source_file = b.path("src/main.zig"),
        .target = b.host
    });

    const ewgridsmax = b.option(u8, "ewgridsmax", "Maximum number of E-W grid cells") orelse 10;
    const nsgridsmax = b.option(u8, "nsgridsmax", "Maximum number of N-S grid cells") orelse 10;
    const soillayersmax = b.option(u8, "soillayersmax", "Maximum number of vertical soil layers") orelse 20;
    const pftmax = b.option(u8, "pftmax", "Maximum number of plant functional types") orelse 5;
    const canopymax = b.option(u8, "canopymax", "Maximum number of canopy layers") orelse 10;
    const subhrwtrcymax = b.option(u8, "subhrwtrcymax", "Maximum number of sub-hourly water cycle") orelse 60;

    const options = b.addOptions();

    options.addOption(u8, "ewgridsmax", ewgridsmax);
    options.addOption(u8, "nsgridsmax", nsgridsmax);
    options.addOption(u8, "soillayersmax", soillayersmax);
    options.addOption(u8, "pftmax", pftmax);
    options.addOption(u8, "canopymax", canopymax);
    options.addOption(u8, "subhrwtrcymax", subhrwtrcymax);

    exe.root_module.addOptions("config", options);

    b.installArtifact(exe);

    const run_exe = b.addRunArtifact(exe);

    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_exe.step);
}
