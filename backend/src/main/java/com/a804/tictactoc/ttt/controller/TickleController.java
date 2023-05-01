package com.a804.tictactoc.ttt.controller;

import com.a804.tictactoc.ttt.request.HabitReq;
import com.a804.tictactoc.ttt.request.TickleReq;
import com.a804.tictactoc.ttt.response.HabitRes;
import com.a804.tictactoc.ttt.response.TickleCategoryRes;
import com.a804.tictactoc.ttt.response.TickleCountRes;
import com.a804.tictactoc.ttt.response.TickleRes;
import com.a804.tictactoc.ttt.service.HabitService;
import com.a804.tictactoc.ttt.service.TickleService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springdoc.api.annotations.ParameterObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.List;


@Tag(name = "티끌", description = "티끌 api 입니다.")
@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
@RequestMapping("/tickle")
@RequiredArgsConstructor
public class TickleController {
	
	private static final Logger logger = LoggerFactory.getLogger(TickleController.class);

	@Autowired
	TickleService tService;

	private ResponseEntity<String> exceptionHandling(Exception e) {
		e.printStackTrace();
		return new ResponseEntity<String>("Sorry: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@Operation(summary = "티끌 읽기", description = "해당 티끌의 정보를 가져옵니다.",
			responses = {
					@ApiResponse(responseCode = "200", description = "습관 읽기 성공"),
					@ApiResponse(responseCode = "500", description = "서버 오류") })
	@GetMapping(value = "/{tickleId}")
	public ResponseEntity<?> readTickle(@PathVariable long tickleId) throws Exception{
		long userId = 1;//임시
		TickleRes result = tService.readTickle(tickleId);
		return new ResponseEntity<TickleRes>(result, HttpStatus.OK);
	}

	@Operation(summary = "티끌 생성", description = "유저가 티끌을 생성합니다.",
			responses = {
					@ApiResponse(responseCode = "200", description = "습관 변경 성공"),
					@ApiResponse(responseCode = "500", description = "서버 오류") })
	@PostMapping(value = "")
	public ResponseEntity<?> createTickle(@ParameterObject TickleReq tickleReq) throws Exception{
		long userId = 1;//임시
		TickleRes tickleRes = tService.createTickle(tickleReq);
		return new ResponseEntity<TickleRes>(tickleRes, HttpStatus.OK);
	}

	@Operation(summary = "오늘의 티끌 가져오기", description = "오늘 수행해야 할 티끌들의 정보를 가져옵니다",
			responses = {
					@ApiResponse(responseCode = "200", description = "습관 읽기 성공"),
					@ApiResponse(responseCode = "500", description = "서버 오류") })
	@GetMapping(value = "")
	public ResponseEntity<?> readTodayTickle(String targetDate) throws Exception{
		long userId = 1;//임시
		List<TickleCategoryRes> result = tService.todayTickle(userId, targetDate);
		return new ResponseEntity<List<TickleCategoryRes>>(result, HttpStatus.OK);
	}

	@Operation(summary = "카테고리별 티끌 개수", description = "각 카테고리별 티끌의 개수를 가져온다",
			responses = {
					@ApiResponse(responseCode = "200", description = "습관 읽기 성공"),
					@ApiResponse(responseCode = "500", description = "서버 오류") })
	@GetMapping(value = "/count")
	public ResponseEntity<?> countTickleByCategory() throws Exception{
		long userId = 1;//임시
		List<TickleCountRes> result = tService.countTickle();
		return new ResponseEntity<List<TickleCountRes>>(result, HttpStatus.OK);
	}



	@ExceptionHandler(SQLException.class)
	@ResponseStatus(value = HttpStatus.BAD_REQUEST, reason = "유효하지 않은 입력 값")
	public void sqlException() {
		System.out.println("SQLException 발생");
		return;
	}

}
