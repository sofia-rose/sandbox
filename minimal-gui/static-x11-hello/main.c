#include <X11/XKBlib.h>
#include <X11/Xlib.h>
#include <X11/keysym.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
  Display *display;

  display = XOpenDisplay(NULL);
  if (display == NULL) {
    fprintf(stderr, "Could not open display!\n");
    exit(1);
  }

  int screen = XDefaultScreen(display);

  Window window = XCreateSimpleWindow(
      display, RootWindow(display, screen), 0, 0, 320, 240, 0,
      BlackPixel(display, screen), BlackPixel(display, screen));

  XStoreName(display, window, "Hello, X11");

  XSelectInput(display, window, ExposureMask | KeyPressMask);

  XMapWindow(display, window);

  Atom WM_DELETE_WINDOW = XInternAtom(display, "WM_DELETE_WINDOW", False);
  if (!XSetWMProtocols(display, window, &WM_DELETE_WINDOW, 1)) {
    fprintf(stderr, "Couldn't register WM_DELETE_WINDOW property \n");
  }

  XFlush(display);

  int escapeKey = XKeysymToKeycode(display, XK_Escape);

  for (;;) {
    while (XPending(display)) {
      XEvent e;
      XNextEvent(display, &e);
      printf("Event type: %d\n", e.type);

      switch (e.type) {
      case KeyPress: {
        if (escapeKey == e.xkey.keycode) {
          goto end;
        }
      } break;
      case ClientMessage: {
        if (e.xclient.format == 32) {
          if ((Atom)e.xclient.data.l[0] == WM_DELETE_WINDOW) {
            goto end;
          }
        }
      } break;
      }
    }
  }
end:

  return XCloseDisplay(display);
}
