package org.zerock.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;


@Configuration
@ComponentScan(basePackages = {"org.zerock.service", "org.zerock.aop"})
@EnableAspectJAutoProxy
public class RootConfig {

}
