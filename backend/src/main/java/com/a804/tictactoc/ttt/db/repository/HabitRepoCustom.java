package com.a804.tictactoc.ttt.db.repository;

import com.a804.tictactoc.ttt.db.entity.Habit;
import com.a804.tictactoc.ttt.response.HabitRes;

import java.util.List;

public interface HabitRepoCustom {
    List<HabitRes> findByUserId(long userId);
}