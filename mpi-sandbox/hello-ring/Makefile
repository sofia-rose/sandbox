TARGET=hello-ring
TARGET2=hello-ring-persistent
NUM_PROCS?=6
MESSAGE_SIZE?=6
NUM_SHIFTS?=3
CC=mpicc
CPPINC=-I.
CPPCODE=-m64 -mavx
COPT=$(CINC) $(CCODE) -O3 -Wall -Wextra

all: run-$(TARGET) run-$(TARGET2)

.PHONY: run-$(TARGET)
run-$(TARGET): $(TARGET)
	mpirun -n $(NUM_PROCS) $(TARGET) $(MESSAGE_SIZE) $(NUM_SHIFTS)

$(TARGET): $(TARGET).o
	$(CC) $(COPT) $^ -o $@

$(TARGET).o: $(TARGET).c
	$(CC) $(COPT) $< -c -o $@

.PHONY: run-$(TARGET2)
run-$(TARGET2): $(TARGET2)
	mpirun -n $(NUM_PROCS) $(TARGET2) $(MESSAGE_SIZE) $(NUM_SHIFTS)

$(TARGET2): $(TARGET2).o
	$(CC) $(COPT) $^ -o $@

$(TARGET2).o: $(TARGET2).c
	$(CC) $(COPT) $< -c -o $@

.PHONY: clean
clean:
	rm -f *.o
	rm -f $(TARGET)
	rm -f $(TARGET2)
