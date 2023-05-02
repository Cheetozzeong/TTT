package com.a804.tictactoc.ttt.service;

import com.a804.tictactoc.ttt.db.entity.User;
import com.a804.tictactoc.ttt.response.TokenRes;
import com.google.firebase.auth.FirebaseAuthException;
import org.springframework.stereotype.Service;

import java.util.Map;

public interface UserService {

     void login(String tokenId);


     Map<String, String> reissue(TokenRes tokenRes);

     Map<String, String> logout(User user, String accessToken);


}
