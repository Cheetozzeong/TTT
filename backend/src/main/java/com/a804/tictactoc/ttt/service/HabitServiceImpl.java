package com.a804.tictactoc.ttt.service;

import com.a804.tictactoc.ttt.db.entity.Habit;
import com.a804.tictactoc.ttt.db.repository.HabitRepo;
import com.a804.tictactoc.ttt.request.HabitReq;
import com.a804.tictactoc.ttt.response.HabitRes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;

@Service
public class HabitServiceImpl implements HabitService{

    @Autowired
    HabitRepo hRepo;

    @Override
    public List<HabitRes> readAll(long userId) throws SQLException {
        return hRepo.findByUserIdAndDeleteYnOrderByCategoryId(userId, 0);
    }

//    @Override
//    public HabitRes readOneHabit(long habitId) throws SQLException {
//       Habit habit = hRepo.findById(habitId).get();
//       return null;
//    }

    @Override
    public Habit createHabit(HabitReq habitReq, long userId) throws SQLException {
        Habit habit = habitReq.toEntity();
        habit.setUserId(userId);
        return hRepo.save(habit);
    }

    @Override
    public Habit updateHabit(HabitReq habitReq) throws SQLException {
        return hRepo.save(habitReq.toEntity());
    }

    @Override
    public Habit deleteHabit(HabitReq habit) throws SQLException {
        return null;
    }
}
