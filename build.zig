const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{ .name = "ecosys", .root_source_file = b.path("src/main.zig"), .target = b.graph.host, .optimize = b.standardOptimizeOption(.{}) });

    const ewgridsmax = b.option(u32, "ewgridsmax", "Maximum number of E-W grid cells") orelse 10;
    const nsgridsmax = b.option(u32, "nsgridsmax", "Maximum number of N-S grid cells") orelse 10;
    const soillayersmax = b.option(u32, "soillayersmax", "Maximum number of vertical soil layers") orelse 20;
    const snowlayersmax = b.option(u32, "snowlayersmax", "Maximum number of layers in the snowpack") orelse 5;
    const pftmax = b.option(u32, "pftmax", "Maximum number of plant functional types") orelse 5;
    const canopymax = b.option(u32, "canopymax", "Maximum number of canopy layers") orelse 10;
    const subhrwtrcymax = b.option(u32, "subhrwtrcymax", "Maximum number of sub-hourly water cycle") orelse 60;

    const options = b.addOptions();

    options.addOption(u32, "ewgridsmax", ewgridsmax);
    options.addOption(u32, "nsgridsmax", nsgridsmax);
    options.addOption(u32, "soillayersmax", soillayersmax);
    options.addOption(u32, "snowlayersmax", snowlayersmax);
    options.addOption(u32, "pftmax", pftmax);
    options.addOption(u32, "canopymax", canopymax);
    options.addOption(u32, "subhrwtrcymax", subhrwtrcymax);

    exe.root_module.addOptions("config", options);

    exe.stack_size = 16 * 1024 * 1024; // increase stack size to 16 MB to accommodate large arrays

    b.installArtifact(exe);

    const run_exe = b.addRunArtifact(exe);

    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_exe.step);
}
