package com.a804.tictactoc.ttt.service;

import com.a804.tictactoc.ttt.db.entity.Category;
import com.a804.tictactoc.ttt.db.repository.CategoryRepo;
import com.a804.tictactoc.ttt.response.CategoryRes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService{
    @Autowired
    CategoryRepo cRepo;

    @Override
    public List<CategoryRes> findAllCategory() throws SQLException {
        List<Category> list = cRepo.findAll();

        List<CategoryRes> result = new ArrayList<>();
        for(Category c : list)
            result.add(CategoryRes.builder().id(c.getId()).name(c.getName()).build());

        return result;
    }
}
