TARGET=ch05-04
CPPINC=-I.
CPPCODE=-m64 -mavx -static
CPPOPT=$(CPPINC) $(CPPCODE)  -O3 -std=c++20 -Wall -Wextra -Wa,-aghl=$(basename $<).lst -save-temps=obj -masm=intel -g
ASMOPT=-I. -f elf64 -l $(basename $<).lst -Lm -Ls -g

$(TARGET): $(TARGET).o $(TARGET)-fasm.o $(TARGET)-misc.o
	g++ $(CPPCODE) $^ -o $@

$(TARGET)-fasm.o: $(TARGET)-fasm.s
	nasm $(ASMOPT) $< -o $@

$(TARGET)-misc.o: $(TARGET)-misc.cpp $(TARGET).h
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
	rm -f $(TARGET).s
