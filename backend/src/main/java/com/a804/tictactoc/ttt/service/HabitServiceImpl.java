package com.a804.tictactoc.ttt.service;

import com.a804.tictactoc.ttt.db.entity.Habit;
import com.a804.tictactoc.ttt.db.repository.HabitRepo;
import com.a804.tictactoc.ttt.request.HabitReq;
import com.a804.tictactoc.ttt.response.HabitRes;
import org.springframework.beans.factory.annotation.Autowired;

import java.sql.SQLException;
import java.util.List;

public class HabitServiceImpl implements HabitService{

    @Autowired
    HabitRepo hRepo;

    @Override
    public List<HabitRes> readAll() throws SQLException {
        return hRepo.findAllByDeleteYnOrderByCategoryId(0);
    }

    @Override
    public HabitRes readOneHabit(long habitId) throws SQLException {
       Habit habit = hRepo.findById(habitId).get();
       return HabitRes.builder()
               .id(habit.getId())
               .build();
    }

    @Override
    public HabitRes createHabit(HabitReq habit) throws SQLException {
        //return hRepo.save(habit);
        return null;
    }

    @Override
    public HabitRes fixHabit(HabitReq habit) throws SQLException {

        return null;
    }

    @Override
    public HabitRes deleteHabit(HabitReq habit) throws SQLException {
        return null;
    }
}
