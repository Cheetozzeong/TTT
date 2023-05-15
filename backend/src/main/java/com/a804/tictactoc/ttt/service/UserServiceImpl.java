package com.a804.tictactoc.ttt.service;

import com.a804.tictactoc.ttt.common.CommonEnum;
import com.a804.tictactoc.ttt.common.CommonResult;
import com.a804.tictactoc.ttt.config.jwt.JwtProperties;
import com.a804.tictactoc.ttt.db.entity.Habit;
import com.a804.tictactoc.ttt.db.entity.User;
import com.a804.tictactoc.ttt.db.repository.UserRepository;
import com.a804.tictactoc.ttt.request.FcmReq;
import com.a804.tictactoc.ttt.request.WatchFcmReq;
import com.a804.tictactoc.ttt.response.HabitRes;
import com.a804.tictactoc.ttt.request.UserSleepReq;
import com.a804.tictactoc.ttt.response.UserSleepRes;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.auth0.jwt.interfaces.DecodedJWT;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import com.google.firebase.auth.FirebaseAuth;
import javax.transaction.Transactional;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Service
public class UserServiceImpl implements UserService {


    private final UserRepository userRepository;
    private final FirebaseAuth firebaseAuth;
    private final RedisTemplate redisTemplate;


    @Autowired
    public UserServiceImpl(UserRepository userRepository, FirebaseAuth firebaseAuth, RedisTemplate redisTemplate) {
        this.userRepository = userRepository;
        this.firebaseAuth = firebaseAuth;
        this.redisTemplate = redisTemplate;
    }

    @Transactional
    public void login(String uid) {
        User user = userRepository.findByUid(uid);
        if(user==null){
            user = new User();
            user.setUid(uid);
            userRepository.save(user);
        }
    }

    @Transactional
    public void quit(long userId) throws SQLException {
        User user = userRepository.findById(userId).get();
        user.setDeleteYn(1);
        userRepository.save(user);
    }

    @Transactional
    public void sleepTime(long userId, UserSleepReq userSleepReq) throws SQLException{
        User user = userRepository.findById(userId).get();
        user.setSleepStartTime(userSleepReq.getSleepStartTime());
        user.setSleepEndTime(userSleepReq.getSleepEndTime());
        userRepository.save(user);
    }

    @Transactional
    public UserSleepRes getSleepTime(long userId) throws SQLException{
        User user = userRepository.findById(userId).get();
        return UserSleepRes.builder()
                .sleepStartTime(user.getSleepStartTime())
                .sleepEndTime(user.getSleepEndTime())
                .build();
    }

    @Transactional
    public Map<String, String> reissue(String refreshToken) {

        System.out.println("선수 입장");
        Map<String, String> response = new HashMap<>();
        //유저 정보를 찾기 위한 복호화(accessToken과 방식은 같다)
        DecodedJWT refreshJwt = JWT.require(Algorithm.HMAC512(JwtProperties.SECRET)).build().verify(refreshToken);
        Date expiration = refreshJwt.getExpiresAt();
        long now = new Date().getTime();
        if(expiration.getTime() - now < 0) { // 만료되었으면
            response.put("message", "리프레시 토큰 만료");
        }
        System.out.println("왜 안되는 거지? ;;; 리프레쉬 토큰");
        String uid = null;
        try {
            uid = refreshJwt.getClaim("uid").asString();
        } catch (TokenExpiredException expiredException) {
            response.put("message", "Refresh Token에 맞는 회원이 없습니다.");
            return response;
        }
        // 레디스에서 리프레시 토큰 찾기
        User user = userRepository.findByUid(uid);
        String checkToken = "";
        try {
            checkToken = (String)redisTemplate.opsForValue().get("RT:" + uid);
        } catch (NullPointerException n) { // 로그아웃해서 레디스에 리프레시 토큰이 없으면
            response.put("message", "Refresh Token이 유효하지 않습니다.");
            return response;
        }
        // 레디스에 저장된 리프레시 토큰과 일치하지 않으면
        if(!checkToken.equals(refreshToken)){
            response.put("message", "Refresh Token 정보가 일치하지 않습니다.");
            return response;
        }
        // access token 재발급
        String accessToken = JWT.create()
                .withSubject(user.getUid())
                .withExpiresAt(new Date(System.currentTimeMillis()+JwtProperties.ACCESS_EXPIRATION_TIME))
                .withClaim("uid", uid)
                .sign(Algorithm.HMAC512(JwtProperties.SECRET));
        response.put("message", "success");
        response.put("accessToken", JwtProperties.TOKEN_PREFIX+accessToken);
        return response;

    }

    @Transactional
    public Map<String, String> logout(User user, String accessToken) {

        Map<String, String> response = new HashMap<>();
        String uid = user.getUid();
        accessToken = accessToken.replace(JwtProperties.TOKEN_PREFIX, "");
        try {
            // Redis에서 User email로 저장된 Refresh Token이 있는지 확인 후 있을면 삭제한다.
            if (null != redisTemplate.opsForValue().get("RT:" + uid)) {
                // Refresh Token을 삭제
                redisTemplate.delete("RT:" + uid);
            }

            // 해당 Access Token 유효시간을 가지고 와서 BlackList에 저장하기
            DecodedJWT accessJwt = JWT.require(Algorithm.HMAC512(JwtProperties.SECRET)).build().verify(accessToken);
            long expirationAt = accessJwt.getExpiresAt().getTime();
            long now = new Date().getTime();

            long expiration = expirationAt - now;
            redisTemplate.opsForValue().set(accessToken, "logout", expiration, TimeUnit.MILLISECONDS);
            response.put("message", "success");
            return response;
        } catch (Exception e) {
            response.put("message", "fail");
            return response;
        }
    }

    public CommonResult saveFcmToken(FcmReq fcm, User user){
        CommonResult result = new CommonResult(CommonEnum.Result.SUCCESS,"FCM 토큰 저장에 성공했습니다." ); //userRepository.get

        try{
            user.setPhoneDeviceToken(fcm.getFcmToken());
            User selectedUser = userRepository.save(user);
        }
        catch (Exception ex){
            result = new CommonResult(CommonEnum.Result.FAIL,"FCM 토큰 저장에 실패했습니다." );
        }

        return result;
    }


    public CommonResult saveWatchFcmToken(WatchFcmReq fcm, User user){
        CommonResult result = new CommonResult(CommonEnum.Result.SUCCESS,"WATCH FCM 토큰 저장에 성공했습니다." ); //userRepository.get

        try{
            user.setWatchDeviceToken(fcm.getWatchFcmToken());
            User selectedUser = userRepository.save(user);
        }
        catch (Exception ex){
            result = new CommonResult(CommonEnum.Result.FAIL,"WATCH FCM 토큰 저장에 실패했습니다." );
        }

        return result;
    }
}