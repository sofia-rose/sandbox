all: hello hello_again

hello: hello.zig
	zig build-exe hello.zig

hello_again: hello_again.zig
	zig build-exe hello_again.zig
.PHONY: clean
clean:
	rm -f *.o
	rm -f hello
	rm -f hello_again
