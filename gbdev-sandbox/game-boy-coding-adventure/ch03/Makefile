sample.gb: main.o
	rgblink --dmg --tiny -o sample.gb main.o
	rgbfix --title game --pad-value 0 --validate sample.gb

main.o: main.s
	rgbasm -Werror -Weverything -o $@ $<

.PHONY: clean
clean:
	rm -f *.o
	rm -f sample.gb
