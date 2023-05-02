package com.a804.tictactoc.ttt.controller;

import java.io.File;
import java.sql.SQLException;
import java.util.List;
import java.util.UUID;

import com.a804.tictactoc.ttt.db.entity.Category;
import com.a804.tictactoc.ttt.response.CategoryRes;
import com.a804.tictactoc.ttt.service.CategoryService;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import io.swagger.v3.oas.annotations.parameters.RequestBody;


@Tag(name = "카테고리", description = "카테고리 api 입니다.")
@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
@RequestMapping("/category")
@RequiredArgsConstructor
public class CategoryController {
	
	private static final Logger logger = LoggerFactory.getLogger(CategoryController.class);

	@Autowired
	CategoryService cService;

	private ResponseEntity<String> exceptionHandling(Exception e) {
		e.printStackTrace();
		return new ResponseEntity<String>("Sorry: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@GetMapping(value = "")
	public ResponseEntity<?> getAllCategories(){
		try {
			return new ResponseEntity<List<CategoryRes>>(cService.findAllCategory(), HttpStatus.OK);
		} catch (SQLException e) {
			return exceptionHandling(e);
		}
	}

}
