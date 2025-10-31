package com.apress.prospring6.ch02.annotated;

public interface MessageRenderer {
  void render();
  void setMessageProvider(MessageProvider provider);
  MessageProvider getMessageProvider();
}
