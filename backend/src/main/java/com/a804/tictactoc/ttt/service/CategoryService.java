package com.a804.tictactoc.ttt.service;

import com.a804.tictactoc.ttt.db.entity.Category;
import com.a804.tictactoc.ttt.response.CategoryRes;

import java.sql.SQLException;
import java.util.List;

public interface CategoryService {
    List<CategoryRes> findAllCategory() throws SQLException;
}
