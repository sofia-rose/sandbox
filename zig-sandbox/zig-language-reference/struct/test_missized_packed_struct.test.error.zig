test "missized packed struct" {
  const S = packed struct(u32) { a: u16, b: u8 };
  _ = S{ .a = 4, .b = 2};
}
