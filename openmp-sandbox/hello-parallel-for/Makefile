TARGET=hello-parallel-for
CC=gcc
CPPINC=-I.
CPPCODE=-m64 -mavx
COMP=-fopenmp
COPT=$(CINC) $(CCODE) $(COMP) -O3 -Wall -Wextra

$(TARGET): $(TARGET).o
	$(CC) $(COPT) $^ -o $@

$(TARGET).o: $(TARGET).c
	$(CC) $(COPT) $< -c -o $@

.PHONY: clean
clean:
	rm -f *.o
	rm -f $(TARGET)
