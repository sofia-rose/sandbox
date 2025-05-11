BASE_NAME=example

ROM_NAME=$(BASE_NAME).nes
SOURCE_FILES=$(BASE_NAME).s
LD_CONFIG_FILE=$(BASE_NAME).cfg
MAP_FILE=$(BASE_NAME).map.txt

INCLUDE_PATH=./include
BIN_INCLUDE_PATH=./bin-include

AS=ca65
AS_FLAGS=--include-dir $(INCLUDE_PATH) --bin-include-dir $(BIN_INCLUDE_PATH) --warnings-as-errors

LD=ld65
LD_FLAGS=--config $(LD_CONFIG_FILE) --mapfile $(MAP_FILE) --warnings-as-errors

RM=rm -f


$(ROM_NAME): $(SOURCE_FILES:.s=.o)
	$(LD) $< $(LD_FLAGS) -o $(ROM_NAME)

%.o: %.s
	$(AS) $< $(AS_FLAGS) -o $@

.PHONY: clean
clean:
	$(RM) $(SOURCE_FILES:.s=.o) $(ROM_NAME) $(MAP_FILE)
