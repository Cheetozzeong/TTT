package com.a804.tictactoc.ttt.service;

import com.a804.tictactoc.ttt.db.entity.User;

import java.util.Map;

public interface UserService {

     void login(String tokenId);

     Map<String, String> reissue(String refreshToken);

     Map<String, String> logout(User user, String accessToken);


}
