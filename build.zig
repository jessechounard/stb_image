const std = @import("std");

pub fn build(b: *std.Build) void {
    const upstream = b.dependency("stb_image", .{});
    const lib = b.addLibrary(.{
        .name = "stb_image",
        .linkage = .static,
        .root_module = b.createModule(.{
            .target = b.standardTargetOptions(.{}),
            .optimize = b.standardOptimizeOption(.{}),
            .link_libc = true,
        }),
    });
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
