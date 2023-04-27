package com.a804.tictactoc.ttt.controller;

import com.a804.tictactoc.ttt.db.entity.Category;
import com.a804.tictactoc.ttt.db.entity.Habit;
import com.a804.tictactoc.ttt.request.HabitReq;
import com.a804.tictactoc.ttt.response.HabitRes;
import com.a804.tictactoc.ttt.service.CategoryService;
import com.a804.tictactoc.ttt.service.HabitService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.Parameters;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.parameters.RequestBody;
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


@Tag(name = "습관", description = "습관 api 입니다.")
@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
@RequestMapping("/habit")
@RequiredArgsConstructor
public class HabitController {
	
	private static final Logger logger = LoggerFactory.getLogger(HabitController.class);

	@Autowired
	HabitService hService;

	private ResponseEntity<String> exceptionHandling(Exception e) {
		e.printStackTrace();

		return new ResponseEntity<String>("Sorry: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@Operation(summary = "습관 전체 읽기", description = "해당 유저의 전체 습관을 다 가져옵니다.",
			responses = {
					@ApiResponse(responseCode = "200", description = "습관 읽기 성공"),
					@ApiResponse(responseCode = "500", description = "서버 오류") })
	@GetMapping(value = "")
	public ResponseEntity<?> readAllHabit() throws Exception{
		long userId = 1;//임시
		List<HabitRes> result = hService.readAll(userId);
		return new ResponseEntity<List<HabitRes>>(result, HttpStatus.OK);
	}

	@Operation(summary = "습관 생성", description = "유저가 습관을 생성합니다.",
			responses = {
					@ApiResponse(responseCode = "200", description = "습관 변경 성공"),
					@ApiResponse(responseCode = "500", description = "서버 오류") })
	@PostMapping(value = "")
	public ResponseEntity<?> createHabit(@ParameterObject HabitReq habitReq) throws Exception{
		long userId = 1;//임시
		HabitRes habitRes = hService.createHabit(habitReq, userId);
		return new ResponseEntity<HabitRes>(habitRes, HttpStatus.OK);
	}

	@Operation(summary = "습관 변경", description = "유저가 습관을 변경합니다.",
			responses = {
					@ApiResponse(responseCode = "200", description = "습관 생성 성공"),
					@ApiResponse(responseCode = "500", description = "서버 오류") })
	@PatchMapping(value = "")
	public ResponseEntity<?> updateHabit(@ParameterObject HabitReq habitReq) throws Exception{
		long userId = 1;//임시
		HabitRes habitRes = hService.updateHabit(habitReq);
		return new ResponseEntity<HabitRes>(habitRes, HttpStatus.OK);
	}

	@Operation(summary = "습관 삭제", description = "유저가 습관을 삭제합니다.",
			responses = {
					@ApiResponse(responseCode = "200", description = "습관 생성 성공"),
					@ApiResponse(responseCode = "500", description = "서버 오류") })
	@PatchMapping(value = "/quit/{habitId}")
	public ResponseEntity<?> deleteHabit(@PathVariable long habitId) throws Exception{
		long userId = 1;//임시
		HabitRes habitRes = hService.deleteHabit(userId, habitId);
		return new ResponseEntity<HabitRes>(habitRes, HttpStatus.OK);
	}

	@ExceptionHandler(SQLException.class)
	@ResponseStatus(value = HttpStatus.BAD_REQUEST, reason = "유효하지 않은 입력 값")
	public void sqlException() {
		System.out.println("SQLException 발생");
		return;
	}

}
