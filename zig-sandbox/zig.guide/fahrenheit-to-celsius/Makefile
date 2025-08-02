all: fahrenheit_to_celsius

fahrenheit_to_celsius: fahrenheit_to_celsius.zig
	zig build-exe $<

.PHONY: clean
clean:
	rm -f fahrenheit_to_celsius
