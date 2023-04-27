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
    public HabitRes createHabit(HabitReq habitReq, long userId) throws SQLException {
        Habit habit = habitReq.toEntity();
        habit.setUserId(userId);
        habit = hRepo.save(habit);
        return HabitRes.builder().habit(habit).build();
    }

    @Override
    public HabitRes updateHabit(HabitReq habitReq) throws SQLException {
        Habit habit = hRepo.save(habitReq.toEntity());
        return HabitRes.builder().habit(habit).build();
    }

    @Override
    public HabitRes deleteHabit(long userId, long habitId) throws SQLException {
        Habit habit = hRepo.findById(habitId).get();
        habit.setDeleteYn(1);
        habit = hRepo.save(habit);
        return HabitRes.builder().habit(habit).build();
    }
}
