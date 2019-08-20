package com.myboot.springboot.common;

import java.util.List;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.myboot.springboot.common.CustomMapArgumentResolver;

@Configuration
public class WebConfig implements WebMvcConfigurer{

    @Bean
    public CustomMapArgumentResolver customMapArgumentResolver() {
        return new CustomMapArgumentResolver();
    }
    
    @Override
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> resolvers) {
        resolvers.add(customMapArgumentResolver());
        WebMvcConfigurer.super.addArgumentResolvers(resolvers);
    }
    
    @Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("forward:/index.jsp");
	}
}