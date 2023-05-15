package com.a804.tictactoc.ttt.service;
import com.a804.tictactoc.ttt.db.entity.Tickle;
import com.a804.tictactoc.ttt.request.TickleReq;
import com.a804.tictactoc.ttt.response.TickleCategoryRes;
import com.a804.tictactoc.ttt.response.TickleCountNameRes;
import com.a804.tictactoc.ttt.response.TickleCountRes;
import com.a804.tictactoc.ttt.response.TickleRes;

import java.sql.SQLException;
import java.util.List;
public interface TickleService {
    TickleRes readTickle(long tickleId) throws SQLException;
    TickleRes createTickle(long userId, TickleReq tickleReq) throws SQLException;

    List<TickleCategoryRes> todayTickle(long userId, String day) throws SQLException;
    List<TickleCountRes> countTickle(long userId) throws SQLException;

    void deleteTickle(long userId, TickleReq tickleReq) throws SQLException;
}
