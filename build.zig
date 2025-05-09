const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{ .name = "ecosys", .root_source_file = b.path("src/main.zig"), .target = b.graph.host, .optimize = b.standardOptimizeOption(.{}) });

    const ewgridsmax = b.option(usize, "ewgridsmax", "Maximum number of E-W grid cells") orelse 10;
    const nsgridsmax = b.option(usize, "nsgridsmax", "Maximum number of N-S grid cells") orelse 10;
    const soillayersmax = b.option(usize, "soillayersmax", "Maximum number of vertical soil layers") orelse 20;
    const snowlayersmax = b.option(usize, "snowlayersmax", "Maximum number of layers in the snowpack") orelse 5;
    const pftmax = b.option(usize, "pftmax", "Maximum number of plant functional types") orelse 5;
    const canopymax = b.option(usize, "canopymax", "Maximum number of canopy layers") orelse 10;
    const subhrwtrcymax = b.option(usize, "subhrwtrcymax", "Maximum number of sub-hourly water cycle") orelse 60;

    const options = b.addOptions();

    options.addOption(usize, "ewgridsmax", ewgridsmax);
    options.addOption(usize, "nsgridsmax", nsgridsmax);
    options.addOption(usize, "soillayersmax", soillayersmax);
    options.addOption(usize, "snowlayersmax", snowlayersmax);
    options.addOption(usize, "pftmax", pftmax);
    options.addOption(usize, "canopymax", canopymax);
    options.addOption(usize, "subhrwtrcymax", subhrwtrcymax);

    exe.root_module.addOptions("config", options);

    exe.stack_size = 16 * 1024 * 1024; // increase stack size to 16 MB to accommodate large arrays

    b.installArtifact(exe);

    const run_exe = b.addRunArtifact(exe);

    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_exe.step);
}
