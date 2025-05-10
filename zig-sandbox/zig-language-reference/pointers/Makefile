TEST_SOURCES=$(shell ls *.test.zig)
TEST_PROGRAMS=$(basename $(TEST_SOURCES))

EXE_SOURCES=$(shell ls *.exe.zig)
EXE_PROGRAMS=$(basename $(EXE_SOURCES))

PANIC_SOURCES=$(shell ls *.panic.zig)
PANIC_PROGRAMS=$(basename $(PANIC_SOURCES))

ERROR_SOURCES=$(shell ls *.error.zig)
ERROR_PROGRAMS=$(basename $(ERROR_SOURCES))

all: $(TEST_PROGRAMS) $(EXE_PROGRAMS) $(PANIC_PROGRAMS) $(ERROR_PROGRAMS)

$(TEST_PROGRAMS): %: %.zig
	zig test $<
	touch $@

$(EXE_PROGRAMS): %: %.zig
	zig build-exe $<

$(PANIC_PROGRAMS): %: %.zig
	! zig test $< 
	touch $@

$(ERROR_PROGRAMS): %: %.zig
	! zig build-exe -lc $< 
	touch $@

.PHONY: clean
clean:
	rm -f *.o
	rm -f $(TEST_PROGRAMS)
	rm -f $(EXE_PROGRAMS)
	rm -f $(PANIC_PROGRAMS)
	rm -f $(ERROR_PROGRAMS)
