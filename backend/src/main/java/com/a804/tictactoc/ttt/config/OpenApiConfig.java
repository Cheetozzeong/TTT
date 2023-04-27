package com.a804.tictactoc.ttt.config;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.servers.Server;
import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Collections;

@Configuration
@OpenAPIDefinition(
        servers = {
                @Server(url = "https://k8a804.p.ssafy.io/api", description = "server"),
                @Server(url = "http://localhost:8428", description = "local")
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

        return new OpenAPI()
                .components(new Components())
                .info(info);
    }
}
