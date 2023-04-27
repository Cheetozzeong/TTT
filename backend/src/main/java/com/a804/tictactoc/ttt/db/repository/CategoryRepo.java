package com.a804.tictactoc.ttt.db.repository;


import java.util.List;

import com.a804.tictactoc.ttt.db.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface CategoryRepo extends JpaRepository<Category,Integer>{
    List<Category> findByDeleteYn(int deleteYn);
}
