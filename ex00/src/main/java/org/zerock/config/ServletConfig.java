package org.zerock.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.core.io.FileSystemResource;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import java.io.IOException;

@EnableWebMvc
@ComponentScan(basePackages = {"org.zerock.controller", "org.zerock.exception"})
public class ServletConfig implements WebMvcConfigurer {

    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        InternalResourceViewResolver bean = new InternalResourceViewResolver();
        bean.setViewClass(JstlView.class);
        bean.setPrefix("/WEB-INF/views/");
        bean.setSuffix(".jsp");
        registry.viewResolver(bean);
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
    }

    @Bean(name = "multipartResolver")
    public CommonsMultipartResolver getResolver() throws IOException {
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();

        // 10MB
        resolver.setMaxUploadSize(1024 * 1024 * 10); // 한 번의 Request로 전달될 수 있는 최대의 크기
        // 2MB
        resolver.setMaxUploadSizePerFile(1024 * 1024 * 2); // 하나의 파일 최대 크기
        // 1MB
        resolver.setMaxInMemorySize(1024 * 1024); // 메모리상에서 유지하는 최대의 크기
        // temp upload
        resolver.setUploadTempDir(new FileSystemResource("E:\\5.study\\upload\\tmp")); // 메모리상 크기 이상일 때 임시 파일의 형태로 보관됨
        resolver.setDefaultEncoding("UTF-8"); // 업로드하는 파일의 이름이 한글일 경우 꺠지는 문제 처리

        return resolver;
    }
}
