DIRS=$(wildcard */.)

.PHONY: clean $(DIRS)

clean: $(DIRS)

$(DIRS):
	$(MAKE) -C $@ clean
