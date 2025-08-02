const std = @import("std");

pub fn main() !void {
  var buf : [256]u8 = undefined;
  var stdout = std.fs.File.stdout().writer(&buf);
  const writer = &stdout.interface;

  const args = try std.process.argsAlloc(std.heap.page_allocator);
  defer std.process.argsFree(std.heap.page_allocator, args);

  if (args.len < 2) return error.ExpectedArgument;

  const f = try std.fmt.parseFloat(f32, args[1]);
  const c = (f - 32) * (5.0 / 9.0);
  try writer.print("{d:.1}c\n", .{c});
  try writer.flush();
}
