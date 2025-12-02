const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.graph.host;
    const optimize = b.standardOptimizeOption(.{});
    const exe = b.addExecutable(.{ .name = "ecosys", .root_module = b.createModule(.{ .root_source_file = b.path("src/ecosys.zig"), .target = target, .optimize = optimize }) });

    const nwex = b.option(usize, "nwex", "Maximum number of W-E grid cells") orelse 10;
    const nnsx = b.option(usize, "nnsx", "Maximum number of N-S grid cells") orelse 10;
    const nsoilx = b.option(usize, "nsoilx", "Maximum number of vertical soil layers") orelse 20;
    const nresx = b.option(usize, "nresx", "Maximum number of surface residue layers") orelse 1;
    const nsnowx = b.option(usize, "nsnowx", "Maximum number of layers in the snowpack") orelse 5;
    const nplantx = b.option(usize, "nplantx", "Maximum number of plant functional types") orelse 5;
    const ncanopyx = b.option(usize, "ncanopyx", "Maximum number of canopy layers") orelse 10;
    const nscenariox = b.option(usize, "nscenariox", "Maximum number of scenarios") orelse 10;
    const nscenex = b.option(usize, "nscenex", "Maximum number of scenes in each scenario") orelse 20;
    const filepathx = b.option(usize, "filepathx", "Maximum length of file paths in bytes") orelse 256;

    const options = b.addOptions();

    options.addOption(usize, "nwex", nwex);
    options.addOption(usize, "nnsx", nnsx);
    options.addOption(usize, "nsoilx", nsoilx);
    options.addOption(usize, "nresx", nresx);
    options.addOption(usize, "nsnowx", nsnowx);
    options.addOption(usize, "nplantx", nplantx);
    options.addOption(usize, "ncanopyx", ncanopyx);
    options.addOption(usize, "nscenariox", nscenariox);
    options.addOption(usize, "nscenex", nscenex);
    options.addOption(usize, "filepathx", filepathx);

    exe.root_module.addOptions("config", options);

    exe.stack_size = 16 * 1024 * 1024; // increase stack size to 16 MB to accommodate large arrays

    b.installArtifact(exe);

    const run_exe = b.addRunArtifact(exe);

    const test_step = b.step("test", "Run unit tests");

    const unit_test = b.addTest(.{
        .name = "ecosys_code_test",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/ecosys.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    const run_unit_test = b.addRunArtifact(unit_test);
    test_step.dependOn(&run_unit_test.step);

    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_exe.step);
}
