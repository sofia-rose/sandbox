.PHONY: clean pass fail

all: pass fail

pass: test_pass.zig
	zig test test_pass.zig

fail: test_fail.zig
	! zig test test_fail.zig

.PHONY: clean
clean:
