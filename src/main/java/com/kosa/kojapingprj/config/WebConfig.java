package com.kosa.kojapingprj.config;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.boot.autoconfigure.web.servlet.error.ErrorViewResolver;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.Map;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/images/**")
                .addResourceLocations("file:src/main/webapp/WEB-INF/views/images/");
    }

    @Bean
    public ErrorViewResolver customErrorViewResolver() {
        return new ErrorViewResolver() {
            @Override
            public ModelAndView resolveErrorView(HttpServletRequest request, HttpStatus status, Map<String, Object> model) {
                if (status == HttpStatus.NOT_FOUND) {
                    return new ModelAndView("error404");
                } else if (status == HttpStatus.FORBIDDEN) {
                    return new ModelAndView("error403");
                } else if (status == HttpStatus.INTERNAL_SERVER_ERROR) {
                    return new ModelAndView("error500");
                }
                return null;
            }
        };
    }
}
