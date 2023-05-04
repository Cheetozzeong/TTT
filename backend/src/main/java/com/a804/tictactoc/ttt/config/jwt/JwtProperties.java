package com.a804.tictactoc.ttt.config.jwt;

public interface JwtProperties {

    String SECRET = "TTT";  //서버만 알고 있는 개인키
    long ACCESS_EXPIRATION_TIME = 1000 * 60 * 60 * 24;  //대충 24시간

    long REFRESH_EXPIRATION_TIME = 1000 * 60 * 60 * 24 * 24; // 대충 24일

    String TOKEN_PREFIX = "Bearer ";
    String HEADER_STRING = "Authorization";
    String ACCESS_HEADER = "accessToken";
    String REFRESH_HEADER = "refreshToken";

}
