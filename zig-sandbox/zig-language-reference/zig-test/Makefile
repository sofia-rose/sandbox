SOURCES=$(shell ls *.zig)
PROGRAMS=$(basename $(SOURCES))

.PHONY: all
all: $(PROGRAMS)

$(PROGRAMS): %: %.zig
	zig test $< || true
	touch $@

.PHONY: clean
clean:
	rm -f *.o
	rm -f $(PROGRAMS)
