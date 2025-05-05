SOURCES=$(shell ls *.zig)
PROGRAMS=$(basename $(SOURCES))

all: $(PROGRAMS)

$(PROGRAMS): %: %.zig
	zig build-exe $<

.PHONY: clean
clean:
	rm -f *.o
	rm -f $(PROGRAMS)
