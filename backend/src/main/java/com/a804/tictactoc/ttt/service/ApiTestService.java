package com.a804.tictactoc.ttt.service;

import com.a804.tictactoc.ttt.db.entity.ApiTest;
import com.a804.tictactoc.ttt.db.repository.ApiTestRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ApiTestService {
    private final ApiTestRepository apiTestRepository;

    public List<ApiTest> getApiTests(){

        List<ApiTest> apiTests = apiTestRepository.findAll();
        return apiTests;
    }
}
