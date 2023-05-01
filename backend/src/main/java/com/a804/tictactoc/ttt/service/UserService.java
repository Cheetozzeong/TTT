package com.a804.tictactoc.ttt.service;

import com.a804.tictactoc.ttt.config.jwt.JwtProperties;
import com.a804.tictactoc.ttt.db.entity.User;
import com.a804.tictactoc.ttt.db.repository.UserRepository;
import com.a804.tictactoc.ttt.response.TokenRes;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.firebase.auth.FirebaseToken;
import com.google.firebase.auth.UserRecord;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import com.google.firebase.auth.FirebaseAuth;
import javax.transaction.Transactional;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Service
public class UserService {


    private final UserRepository userRepository;
    private final FirebaseAuth firebaseAuth;
    private final RedisTemplate redisTemplate;

    @Autowired
    public UserService(UserRepository userRepository, FirebaseAuth firebaseAuth, RedisTemplate redisTemplate) {
        this.userRepository = userRepository;
        this.firebaseAuth = firebaseAuth;
        this.redisTemplate = redisTemplate;
    }


    @Transactional
    public void login(String tokenId) throws Exception{


        FirebaseToken decodedToken = firebaseAuth.getInstance().verifyIdToken(tokenId);
        String uid = decodedToken.getUid();

        UserRecord userRecord = firebaseAuth.getUser(uid);
        String email = userRecord.getEmail();

        User user = userRepository.findByUserEmail(email);
        if(user==null){
            user.setUserEmail(email);
            user.setUserNickname("손정훈");
            userRepository.save(user);
        }
    }

    @Transactional
    public Map<String, String> reissue(TokenRes tokenRes) {
        Map<String, String> response = new HashMap<>();
        DecodedJWT refreshJwt = JWT.require(Algorithm.HMAC512(JwtProperties.SECRET)).build().verify(tokenRes.getRefreshToken());
        Date expiration = refreshJwt.getExpiresAt();
        long now = new Date().getTime();
        if(expiration.getTime() - now < 0) { // 만료되었으면
            response.put("message", "리프레시 토큰 만료");
        }
        // 레디스에서 리프레시 토큰 찾기
        User user = userRepository.findByUserEmail(tokenRes.getUserEmail());
        String refreshToken = "";
        try {
            refreshToken = (String)redisTemplate.opsForValue().get("RT:" + tokenRes.getUserEmail());
        } catch (NullPointerException n) { // 로그아웃해서 레디스에 리프레시 토큰이 없으면
            response.put("message", "Refresh Token이 유효하지 않습니다.");
            return response;
        }
        // 레디스에 저장된 리프레시 토큰과 일치하지 않으면
        if(!refreshToken.equals(tokenRes.getRefreshToken())) {
            response.put("message", "Refresh Token 정보가 일치하지 않습니다.");
            return response;
        }
        // access token 재발급
        String accessToken = JWT.create()
                .withSubject(user.getUserEmail())
                .withExpiresAt(new Date(System.currentTimeMillis()+JwtProperties.ACCESS_EXPIRATION_TIME))
                .withClaim("id", user.getUserSeq())
                .withClaim("username", user.getUserEmail())
                .sign(Algorithm.HMAC512(JwtProperties.SECRET));
        response.put("message", "success");
        response.put("accessToken", JwtProperties.TOKEN_PREFIX+accessToken);
        return response;
    }
    @Transactional
    public Map<String, String> logout(User user, String accessToken) {
        Map<String, String> response = new HashMap<>();
        String userEmail = user.getUserEmail();
        accessToken = accessToken.replace(JwtProperties.TOKEN_PREFIX, "");
        try {
            // Redis에서 User email로 저장된 Refresh Token이 있는지 확인 후 있을면 삭제한다.
            if (null != redisTemplate.opsForValue().get("RT:"+userEmail)){
                // Refresh Token을 삭제
                redisTemplate.delete("RT:"+userEmail);
            }

            // 해당 Access Token 유효시간을 가지고 와서 BlackList에 저장하기
            DecodedJWT accessJwt = JWT.require(Algorithm.HMAC512(JwtProperties.SECRET)).build().verify(accessToken);
            long expirationAt = accessJwt.getExpiresAt().getTime();
            long now = new Date().getTime();

            long expiration = expirationAt - now;
            redisTemplate.opsForValue().set(accessToken,"logout", expiration, TimeUnit.MILLISECONDS);
            response.put("message", "success");
            return response;
        } catch (Exception e) {
            response.put("message", "fail");
            return response;
        }
    }

}
