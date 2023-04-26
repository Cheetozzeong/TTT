package com.a804.tictactoc.ttt.service;
import com.a804.tictactoc.ttt.db.entity.Habit;
import com.a804.tictactoc.ttt.request.HabitReq;
import com.a804.tictactoc.ttt.response.HabitRes;

import java.sql.SQLException;
import java.util.List;
public interface HabitService {
    List<HabitRes> readAll(long userId) throws SQLException;
    //HabitRes readOneHabit(long habitId) throws SQLException;

    Habit createHabit(HabitReq habit, long userId) throws SQLException;
    Habit updateHabit(HabitReq habit) throws  SQLException;
    Habit deleteHabit(HabitReq habit) throws SQLException;
}
