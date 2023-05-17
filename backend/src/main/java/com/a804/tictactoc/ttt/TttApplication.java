package com.a804.tictactoc.ttt;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableScheduling
@SpringBootApplication
public class TttApplication {

    public static void main(String[] args) {
        SpringApplication.run(TttApplication.class, args);
    }

}
