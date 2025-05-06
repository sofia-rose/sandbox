SOURCES=$(shell ls *.zig)
PROGRAMS=$(basename $(SOURCES))

all: $(PROGRAMS) 

$(PROGRAMS): %: %.zig
	zig test $<
	touch $@

float_mode_exe: float_mode_exe.zig float_mode_obj.o
	zig build-exe $^ -O ReleaseFast

float_mode_obj.o: float_mode_obj.zig
	zig build-obj $< -O ReleaseFast

.PHONY: clean
clean:
	rm -f *.o
	rm -f $(PROGRAMS)
