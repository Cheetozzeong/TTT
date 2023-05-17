package com.a804.tictactoc.ttt.service;

import com.a804.tictactoc.ttt.db.entity.User;
import com.a804.tictactoc.ttt.request.UserSleepReq;
import com.a804.tictactoc.ttt.response.UserSleepRes;

import java.sql.SQLException;
import java.util.Map;

public interface UserService {

     void login(String tokenId);

     Map<String, String> reissue(String refreshToken);

     Map<String, String> logout(User user, String accessToken);

     void sleepTime(long userId, UserSleepReq userSleepReq) throws SQLException;

     UserSleepRes getSleepTime(long userId) throws SQLException;

     void quit(long userId) throws SQLException;
}
