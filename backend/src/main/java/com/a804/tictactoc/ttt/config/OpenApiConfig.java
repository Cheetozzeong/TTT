package com.a804.tictactoc.ttt.config;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {

    @Bean
    public OpenAPI openAPI(@Value("${springdoc.version}") String springdocVersion) {
        Info info = new Info()
                .title("티끌태끌토끌! - TTT")
                .version(springdocVersion)
                .description("TTT의 API 입니다.");

        return new OpenAPI()
                .components(new Components())
                .info(info);
    }
}
