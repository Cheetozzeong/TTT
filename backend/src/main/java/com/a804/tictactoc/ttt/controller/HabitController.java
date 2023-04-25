package com.a804.tictactoc.ttt.controller;

import com.a804.tictactoc.ttt.db.entity.Category;
import com.a804.tictactoc.ttt.service.CategoryService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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
	CategoryService cService;

	private ResponseEntity<String> exceptionHandling(Exception e) {
		e.printStackTrace();
		return new ResponseEntity<String>("Sorry: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
	}

//	@GetMapping(value = "")
//	public ResponseEntity<?> getAllCategories(){
//
//	}

}
