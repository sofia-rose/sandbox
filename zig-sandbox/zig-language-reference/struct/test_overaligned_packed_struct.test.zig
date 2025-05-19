const std = @import("std");
const expect = std.testing.expect;

const S = packed struct {
  a: u32,
  b: u32,
};

test "overaligned pointer to packed struct" {
  var foo: S align(4) = .{ .a = 1, .b = 2 };
  var ptr: *align(4) S = &foo;
  const ptr_to_be: *u32 = &ptr.b;
  try expect(ptr_to_be.* == 2);
}
