static-x11-hello: main.c
	gcc -Wall -Wmissing-prototypes -Wstrict-prototypes -Werror -pedantic -ansi -std=c99 \
  -static \
  -O3 \
  $< \
  -o $@ \
  -lX11 \
  -lxcb \
  -lXau \
  -lXdmcp

.PHONY: clean
clean:
	rm -f static-x11-hello
