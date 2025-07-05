TARGET=ch02-02
CPPINC=-I.
CPPCODE=-m64 -mavx
CPPOPT=$(CPPINC) $(CPPCODE)  -O3 -std=c++20 -Wall -Wextra -Wa,-aghl=$(basename $<).lst -save-temps=obj -masm=intel -g
ASMOPT=-I. -f elf64 -l $(basename $<).lst -Lm -Ls -g

$(TARGET): $(TARGET).o $(TARGET)-misc.o $(TARGET)-fcpp.o $(TARGET)-fasm.o
	g++ $(CPPCODE) $^ -o $@

$(TARGET)-fasm.o: $(TARGET)-fasm.s mod-x86-asm-3e-nasm.inc
	nasm $(ASMOPT) $< -o $@

$(TARGET)-misc.o: $(TARGET)-misc.cpp $(TARGET).h
	g++ $(CPPOPT) $< -c -o $@

$(TARGET)-fcpp.o: $(TARGET)-fcpp.cpp $(TARGET).h
	g++ $(CPPOPT) $< -c -o $@

$(TARGET).o: $(TARGET).cpp $(TARGET).h
	g++ $(CPPOPT) $< -c -o $@

.PHONY: clean
clean:
	rm -f *.o
	rm -f *.lst
	rm -f *.ii
	rm -f $(TARGET)
	rm -f $(TARGET)-misc.s
	rm -f $(TARGET)-fcpp.s
	rm -f $(TARGET).s
