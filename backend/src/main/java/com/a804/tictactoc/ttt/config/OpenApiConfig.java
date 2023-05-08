package com.a804.tictactoc.ttt.config;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.servers.Server;
import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.context.SecurityContext;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@Configuration
@OpenAPIDefinition(
        servers = {

                @Server(url = "http://localhost:8428", description = "local"),
                @Server(url = "http://k8a804.p.ssafy.io:8428", description = "staging-server"),
                @Server(url = "http://k8a804.p.ssafy.io:8430", description = "standby-server"),
                @Server(url = "http://k8a804.p.ssafy.io:8432", description = "server")
//                @Server(url = "https://k8a804.p.ssafy.io/api", description = "server"),
//                @Server(url = "https://k8a804.p.ssafy.io/standby-api", description = "server"),
//                @Server(url = "https://k8a804.p.ssafy.io/staging-api", description = "server"),

        }
)
public class OpenApiConfig {
//    @Value("${ttt.backend.server.url}")
//    private String backendUrl;
//    @Value("${ttt.backend.local.url}")
//    private String localUrl;

    @Bean
    public OpenAPI openAPI(@Value("${springdoc.version}") String springdocVersion) {

//        Server serverEc2 = new Server("ectserver", backendUrl, "for server", Collections.emptyList(), Collections.emptyList());
//        Server serverLocal = new Server("local", localUrl, "for local", Collections.emptyList(), Collections.emptyList());


        Info info = new Info()
                .title("티끌태끌토끌! - TTT")
                .version(springdocVersion)
                .description("TTT의 API 입니다.");

        // SecuritySecheme명
        String jwtSchemeName = "jwtAuth";
        // API 요청헤더에 인증정보 포함
        SecurityRequirement securityRequirement = new SecurityRequirement().addList(jwtSchemeName);
        // SecuritySchemes 등록
        Components components = new Components()
                .addSecuritySchemes(jwtSchemeName, new SecurityScheme()
                        .name(jwtSchemeName)
                        .type(SecurityScheme.Type.HTTP) // HTTP 방식
                        .scheme("bearer")
                        .bearerFormat("JWT")); // 토큰 형식을 지정하는 임의의 문자(Optional)

        return new OpenAPI()
                .components(components)
                .addSecurityItem(securityRequirement)
                .info(info);
    }
}
