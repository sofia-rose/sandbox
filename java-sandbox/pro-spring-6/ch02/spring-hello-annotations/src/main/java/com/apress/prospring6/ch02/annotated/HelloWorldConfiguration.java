package com.apress.prospring6.ch02.annotated;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class HelloWorldConfiguration {
  @Bean
  public MessageProvider provider() {
    return new HelloWorldMessageProvider();
  }

  @Bean
  public MessageRenderer renderer() {
    MessageRenderer renderer = new StandardOutMessageRenderer();
    renderer.setMessageProvider(provider());
    return renderer;
  }
}
