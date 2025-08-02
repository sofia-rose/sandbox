const std = @import("std");

pub fn main() !void {
  var buf : [256]u8 = undefined;
  var stdout = std.fs.File.stdout().writer(&buf);
  const writer = &stdout.interface;
  var count : u8 = 1;

  while (count <= 100) : (count += 1) {
    const div_3 : u2 = @intFromBool(count % 3 == 0);
    const div_5 : u2 = @intFromBool(count % 5 == 0);

    switch (div_5 << 1 | div_3) {
      0b00 => try writer.print("{}\n", .{count}),
      0b01 => try writer.writeAll("Fizz\n"),
      0b10 => try writer.writeAll("Buzz\n"),
      0b11 => try writer.writeAll("Fizz Buzz\n"),
    }
    try writer.flush();
  }
}
