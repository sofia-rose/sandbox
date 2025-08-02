all: fizz_buzz_if_else fizz_buzz_switch

fizz_buzz_if_else: fizz_buzz_if_else.zig
	zig build-exe $<

fizz_buzz_switch: fizz_buzz_switch.zig
	zig build-exe $<

.PHONY: clean
clean:
	rm -f fizz_buzz_switch
	rm -f fizz_buzz_if_else
