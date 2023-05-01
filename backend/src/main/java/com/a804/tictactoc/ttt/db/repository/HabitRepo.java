package com.a804.tictactoc.ttt.db.repository;


import com.a804.tictactoc.ttt.db.entity.Habit;
import com.a804.tictactoc.ttt.response.HabitRes;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface HabitRepo extends JpaRepository<Habit,Long>{
    //List<Habit> findByCategoryId(int categoryId);
    List<HabitRes> findByUserIdAndDeleteYnOrderByCategoryId(long userId, int deleteYn);
}
