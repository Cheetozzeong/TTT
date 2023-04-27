package com.a804.tictactoc.ttt.config.jwt;

public interface JwtProperties {

    String SECRET = "TTT";  //서버만 알고 있는 개인키
    int ACCESS_EXPIRATION_TIME = 1000 * 60 * 60 * 24 ;  //대충 24시간
    int REFRESH_EXPIRATION_TIME = 1000 * 60 * 60 * 24 * 30; // 대충 30일
    String TOKEN_PREFIX = "Bearer ";
    String HEADER_STRING = "Authorization";
}
