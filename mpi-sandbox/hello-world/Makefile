TARGET=hello-world
CC=mpicc
CPPINC=-I.
CPPCODE=-m64 -mavx
COPT=$(CINC) $(CCODE) -O3 -Wall -Wextra

run: $(TARGET)
	mpirun $(TARGET)

$(TARGET): $(TARGET).o
	$(CC) $(COPT) $^ -o $@

$(TARGET).o: $(TARGET).c
	$(CC) $(COPT) $< -c -o $@

.PHONY: clean
clean:
	rm -f *.o
	rm -f $(TARGET)
