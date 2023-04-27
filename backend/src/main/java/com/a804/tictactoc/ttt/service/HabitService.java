package com.a804.tictactoc.ttt.service;
import com.a804.tictactoc.ttt.db.entity.Habit;
import com.a804.tictactoc.ttt.request.HabitReq;
import com.a804.tictactoc.ttt.response.HabitRes;

import java.sql.SQLException;
import java.util.List;
public interface HabitService {
    List<HabitRes> readAll(long userId) throws SQLException;
    //HabitRes readOneHabit(long habitId) throws SQLException;

    HabitRes createHabit(HabitReq habit, long userId) throws SQLException;
    HabitRes updateHabit(HabitReq habit) throws  SQLException;
    HabitRes deleteHabit(long userId, long habitId) throws SQLException;
}
