const std = @import("std");

pub fn build(b: *std.Build) void {
  const target = b.standardTargetOptions(.{});
  const optimize = b.standardOptimizeOption(.{});

  const glew = b.addStaticLibrary(.{
    .name = "glew",
    .target = target,
    .optimize = optimize
  });
  // Link C standard library
  glew.linkLibC();

  glew.addIncludePath(b.path("include"));

  const glew_sources = [_][]const u8 {
    "src/glew.c",
    "src/glewinfo.c",
    "src/visualinfo.c"
  };

  const glew_compiler_flags = [_][]const u8 {
    "-std=c11"
  };

  glew.addCSourceFiles(.{
    .files = &glew_sources,
    .flags = &glew_compiler_flags
  });

  glew.installHeadersDirectory(b.path("include/GL"), "GL", .{});
  b.installArtifact(glew);
}