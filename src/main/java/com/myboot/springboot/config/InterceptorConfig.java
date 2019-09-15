package com.myboot.springboot.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.myboot.springboot.common.Interceptor.LoggerInterceptor;

@Configuration
public class InterceptorConfig implements WebMvcConfigurer {
	
	@Bean
    public LoggerInterceptor loggerInterceptor() {
        return new LoggerInterceptor();
    }
	
	@Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(loggerInterceptor())
                .addPathPatterns("/board/**")
		        .addPathPatterns("/chat/**")
		        .addPathPatterns("/comment/**");
    }

}
