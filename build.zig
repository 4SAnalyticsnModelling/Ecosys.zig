const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.graph.host;
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{ .name = "ecosys-ng", .root_module = b.createModule(.{ .root_source_file = b.path("src/ecosys-ng.zig"), .target = target, .optimize = optimize }) });

    // exe.stack_size = 16 * 1024 * 1024; // increase stack size to 16 MB to accommodate large arrays
    const ecosys_ng = b.addModule("ecosys-ng", .{
        .root_source_file = b.path("src/ecosys-ng.zig"),
    });

    exe.root_module.addImport("ecosys-ng", ecosys_ng);

    //custom binary folder with `zig build -p .` command
    const install_exe = b.addInstallArtifact(
        exe,
        .{
            .dest_dir = .{
                .override = .{ .custom = "ecosys-ng-bin" },
            },
        },
    );

    b.getInstallStep().dependOn(&install_exe.step);

    const run_exe = b.addRunArtifact(exe);

    const test_step = b.step("test", "Run ecosys-ng code test blocks");

    const test_blocks = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("test/ecosys-ng_test.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });

    test_blocks.root_module.addImport("ecosys-ng", ecosys_ng);

    const run_test_blocks = b.addRunArtifact(test_blocks);
    test_step.dependOn(&run_test_blocks.step);
    test_step.dependOn(b.getInstallStep()); //create binary along with testing

    const run_step = b.step("run", "Run ecosys-ng application");
    run_step.dependOn(&run_exe.step);
}
