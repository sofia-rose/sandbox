const std = @import("std");

pub fn main() !void {
  var buf : [256]u8 = undefined;
  var stdout = std.fs.File.stdout().writer(&buf);
  const writer = &stdout.interface;

  var count : u8 = 1;
  while (count <= 100) : (count += 1) {
    if (count % 3 == 0 and count % 5 == 0) {
      try writer.writeAll("Fizz Buzz\n");
    } else if (count % 5 == 0) {
      try writer.writeAll("Buzz\n");
    } else if (count % 3 == 0) {
      try writer.writeAll("Fizz\n");
    } else {
      try writer.print("{}\n", .{count});
    }
    try writer.flush();
  }
}
