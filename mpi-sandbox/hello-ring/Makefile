TARGET=hello-ring
NUM_PROCS?=6
MESSAGE_SIZE?=6
NUM_SHIFTS?=3
CC=mpicc
CPPINC=-I.
CPPCODE=-m64 -mavx
COPT=$(CINC) $(CCODE) -O3 -Wall -Wextra

.PHONY: run
run: $(TARGET)
	mpirun -n $(NUM_PROCS) $(TARGET) $(MESSAGE_SIZE) $(NUM_SHIFTS)

$(TARGET): $(TARGET).o
	$(CC) $(COPT) $^ -o $@

$(TARGET).o: $(TARGET).c
	$(CC) $(COPT) $< -c -o $@

.PHONY: clean
clean:
	rm -f *.o
	rm -f $(TARGET)
