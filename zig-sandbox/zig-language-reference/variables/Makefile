SOURCES=$(shell ls *.zig)
PROGRAMS=$(basename $(SOURCES))

all: $(PROGRAMS)

$(PROGRAMS): %: %.zig
	zig test $<
	touch $@

.PHONY: clean
clean:
	rm -f *.o
	rm -f $(PROGRAMS)
