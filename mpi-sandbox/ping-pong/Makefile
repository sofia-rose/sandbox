TARGET=ping-pong
CC=mpicc
CPPINC=-I.
CPPCODE=-m64 -mavx
COPT=$(CINC) $(CCODE) -O3 -Wall -Wextra

.PHONY: run
run: $(TARGET)
	mpirun -n 2 $(TARGET)

$(TARGET): $(TARGET).o
	$(CC) $(COPT) $^ -o $@

$(TARGET).o: $(TARGET).c
	$(CC) $(COPT) $< -c -o $@

.PHONY: clean
clean:
	rm -f *.o
	rm -f $(TARGET)
