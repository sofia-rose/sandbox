.PHONY: clean format

static-x11-hello: main.c format
	gcc -Wall -Wmissing-prototypes -Wstrict-prototypes -Werror -pedantic -ansi -std=c99 \
  -static \
  -O3 \
  $< \
  -o $@ \
  -lX11 \
  -lxcb \
  -lXau \
  -lXdmcp

format: main.c
	clang-format -i main.c

clean:
	rm -f static-x11-hello
