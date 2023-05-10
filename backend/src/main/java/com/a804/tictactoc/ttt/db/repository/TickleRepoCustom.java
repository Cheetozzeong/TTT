package com.a804.tictactoc.ttt.db.repository;

import com.a804.tictactoc.ttt.response.HabitRes;
import com.a804.tictactoc.ttt.response.TickleCountRes;
import com.a804.tictactoc.ttt.response.TickleRes;

import java.util.List;

public interface TickleRepoCustom {
    List<TickleCountRes> findCount(long userId);
}