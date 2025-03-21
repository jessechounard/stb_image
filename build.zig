const std = @import("std");

pub fn build(b: *std.Build) void {
    const upstream = b.dependency("stb_image", .{});
    const lib = b.addStaticLibrary(.{
        .name = "stb_image",
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    });
    lib.linkLibC();
    lib.addIncludePath(upstream.path(""));
    lib.addCSourceFiles(.{
        .files = &.{
            "stb_image.c",
        },
    });
    lib.installHeadersDirectory(upstream.path("."), "", .{ .include_extensions = &.{
        "stb_image.h",
    } });
    b.installArtifact(lib);
}
