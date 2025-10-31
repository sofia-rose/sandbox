package com.apress.prospring6.ch02.annotated;

public class HelloWorldMessageProvider implements MessageProvider {
  public HelloWorldMessageProvider() {
    System.out.println(" ---> HelloWorldMessageProvider: constructor called");
  }

  @Override
  public String getMessage() {
    return "Hello World!";
  }
}
