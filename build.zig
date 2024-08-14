const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const translate_c = b.addTranslateC(.{
        .root_source_file = b.path("src/meshoptimizer.h"),
        .target = target,
        .optimize = optimize,
    });

    const meshoptimizer = translate_c.addModule("meshoptimizer");
    meshoptimizer.link_libc = true;
    meshoptimizer.link_libcpp = true;
    meshoptimizer.addCSourceFiles(.{ .files = &.{
        "src/clusterizer.cpp",
        "src/indexgenerator.cpp",
        "src/vcacheoptimizer.cpp",
        "src/vcacheanalyzer.cpp",
        "src/vfetchoptimizer.cpp",
        "src/vfetchanalyzer.cpp",
        "src/overdrawoptimizer.cpp",
        "src/overdrawanalyzer.cpp",
        "src/simplifier.cpp",
        "src/allocator.cpp",
    }, .flags = &.{} });
}
