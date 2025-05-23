const std = @import("std");

// This is also available as `std.c.printf`
pub extern "c" fn printf(format: [*:0]const u8, ...) c_int;

pub fn main() anyerror!void {
  _ = printf("Hello, world!\n"); // Ok

  const msg = "hello, world!\n";
  const non_null_terminated_msg: [msg.len]u8 = msg.*;
  _ = printf(&non_null_terminated_msg);
}
