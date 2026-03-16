sample.gb: main.o sample.o
	rgblink --dmg --tiny --map $(basename $@).map --sym $(basename $@).sym -o $@ $^
	rgbfix --title game --pad-value 0 --validate $@

main.o: main.s hardware.inc
	rgbasm -Werror -Weverything -o $@ $<

sample.o: sample.s utils.inc hardware.inc
	rgbasm -Werror -Weverything -o $@ $<

.PHONY: clean
clean:
	rm -f *.o
	rm -f sample.gb
