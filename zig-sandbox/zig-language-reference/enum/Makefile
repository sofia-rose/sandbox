TEST_SOURCES=$(shell ls *.test.zig)
TEST_PROGRAMS=$(basename $(TEST_SOURCES))

TEST_ERROR_SOURCES=$(shell ls *.test.error.zig)
TEST_ERROR_PROGRAMS=$(basename $(TEST_ERROR_SOURCES))

EXE_SOURCES=$(shell ls *.exe.zig)
EXE_PROGRAMS=$(basename $(EXE_SOURCES))

EXE_ERROR_SOURCES=$(shell ls *.exe.error.zig)
EXE_ERROR_PROGRAMS=$(basename $(EXE_ERROR_SOURCES))

OBJ_SOURCES=$(shell ls *.obj.zig)
OBJ_PROGRAMS=$(basename $(OBJ_SOURCES))

OBJ_ERROR_SOURCES=$(shell ls *.obj.error.zig)
OBJ_ERROR_PROGRAMS=$(basename $(OBJ_ERROR_SOURCES))

all: $(TEST_PROGRAMS) $(TEST_ERROR_PROGRAMS) $(EXE_PROGRAMS) $(EXE_ERROR_PROGRAMS) $(OBJ_PROGRAMS) $(OBJ_ERROR_PROGRAMS)

$(TEST_PROGRAMS): %: %.zig
	zig test $<
	touch $@

$(TEST_ERROR_PROGRAMS): %: %.zig
	! zig test $<
	touch $@

$(EXE_PROGRAMS): %: %.zig
	zig build-exe $<

$(EXE_ERROR_PROGRAMS): %: %.zig
	! zig build-exe $<
	touch $@

$(OBJ_PROGRAMS): %: %.zig
	zig build-obj $< -target x86_64-linux
	touch $@

$(OBJ_ERROR_PROGRAMS): %: %.zig
	! zig build-obj $< -target x86_64-linux
	touch $@

.PHONY: clean
clean:
	rm -f *.o
	rm -f $(TEST_PROGRAMS)
	rm -f $(TEST_ERROR_PROGRAMS)
	rm -f $(EXE_PROGRAMS)
	rm -f $(EXE_ERROR_PROGRAMS)
	rm -f $(OBJ_PROGRAMS)
	rm -f $(OBJ_ERROR_PROGRAMS)
