TEST_SOURCES=$(shell ls *.test.zig)
TEST_PROGRAMS=$(basename $(TEST_SOURCES))

EXE_SOURCES=$(shell ls *.exe.zig)
EXE_PROGRAMS=$(basename $(EXE_SOURCES))

all: $(TEST_PROGRAMS) $(EXE_PROGRAMS)

$(TEST_PROGRAMS): %: %.zig
	zig test $<
	touch $@

$(EXE_PROGRAMS): %: %.zig
	zig build-exe $<

.PHONY: clean
clean:
	rm -f *.o
	rm -f $(TEST_PROGRAMS)
	rm -f $(EXE_PROGRAMS)
