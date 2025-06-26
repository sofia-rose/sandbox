SOURCES=$(shell ls *.s)
PROGRAMS=$(basename $(SOURCES))

all: $(PROGRAMS)

%.o: %.s
	nasm -f elf64 -o $@ $<

$(PROGRAMS): %: %.o
	ld -o $@ $<

.PHONY: clean
clean:
	rm -f *.o
	rm -f $(PROGRAMS)
