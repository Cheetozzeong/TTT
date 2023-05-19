package com.a804.tictactoc.ttt.service;
import com.a804.tictactoc.ttt.request.TickleReq;
import com.a804.tictactoc.ttt.response.*;

import java.sql.SQLException;
import java.util.List;
public interface TickleService {
    TickleRes readTickle(long tickleId) throws SQLException;
    TickleRes createTickle(long userId, TickleReq tickleReq) throws SQLException;

    List<TickleCategoryRes> todaySchedule(long userId, String day) throws SQLException;
    List<TickleCountRes> countTickle(long userId) throws SQLException;

    List<TickleCategoryPastRes> pastTickles(long userId, String day) throws SQLException;
    List<String> monthTickleAchieve(long userId, String month) throws SQLException;

    void deleteTickle(long userId, TickleReq tickleReq) throws SQLException;
}
