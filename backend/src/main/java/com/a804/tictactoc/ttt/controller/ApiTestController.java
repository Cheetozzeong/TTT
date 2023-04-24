package com.a804.tictactoc.ttt.controller;

import com.a804.tictactoc.ttt.db.entity.ApiTest;
import com.a804.tictactoc.ttt.service.ApiTestService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Tag(name = "테스트", description = "테스트 api 입니다.")
@RestController
@RequestMapping("/apitest")
@RequiredArgsConstructor
public class ApiTestController {

    private final ApiTestService apiTestService;

    @GetMapping(value = "")
    public ResponseEntity<?> getApiTests(){
        Map resultmap = new HashMap<>();
        HttpStatus status;

        try {
            List<ApiTest> recvList = apiTestService.getApiTests();

            if (recvList.isEmpty()) {
                status = HttpStatus.NO_CONTENT;
            } else {
                resultmap.put("data", recvList);
                status = HttpStatus.OK;
            }

        } catch (Exception e) {
            resultmap.put("message", e.getMessage());
            status = HttpStatus.INTERNAL_SERVER_ERROR;
        }

        return new ResponseEntity<Map>(resultmap, status);
    }
}
