package com.a804.tictactoc.ttt.config.jwt;

import com.a804.tictactoc.ttt.response.UserFirebaseRes;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.fasterxml.jackson.databind.ObjectMapper;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.firebase.cloud.FirestoreClient;
import lombok.RequiredArgsConstructor;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.TimeUnit;




@RequiredArgsConstructor
public class JwtAuthenticationFilter extends UsernamePasswordAuthenticationFilter  {

    //컬렉션 네임 생성
    public static final String COLLECTION_NAME = "users";


    private final AuthenticationManager authenticationManager;
    //스프링과 레디스 사이에서 쓰레드 세이프한 브리지를 제공해 주는 역할
    private final RedisTemplate<String, Object> redisTemplate;

    /**
        인증 요청 시 실행되는 함수 (/login)
    */
    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
        throws AuthenticationException {
        /*
        여기서 프론트가 준 ID TOKEN을 가지고
        구글에 유저 정보를 요청한다(userid)
        */
        /*
        1. id token 받는다.
        2. 그거 기반 uid를 갖고와서 유저 이메일을 갖고와
        3. 그거 토대로 select, null이면 insert

        1. 로그인 api
        * */


        String idToken = "idToken";
        //request에 있는 username과 password를 java Object로 받기
        ObjectMapper om = new ObjectMapper();
        UserFirebaseRes user = null;
        try {
            user = om.readValue(request.getInputStream(), UserFirebaseRes.class);
        } catch (Exception e) {
            e.printStackTrace();
        }

        String userid = "test"; //구글에서 받은 유저 아이디
        //유저네임패스워드 토큰 생성
        UsernamePasswordAuthenticationToken authenticationToken =
                new UsernamePasswordAuthenticationToken(
                        userid,null);

        Authentication authentication = authenticationManager.authenticate(authenticationToken);

        return authentication;
    }
    /**
        Authentication 객체가 성공적으로 만들어지면 JWT Token 생성해서 response에 담기
     */
    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain,
                                            Authentication authResult) throws IOException, ServletException {
        PrincipalDetails principalDetailis = (PrincipalDetails) authResult.getPrincipal();

        String accessToken = JWT.create()
                .withSubject(principalDetailis.getUsername())
                .withExpiresAt(new Date(System.currentTimeMillis()+JwtProperties.ACCESS_EXPIRATION_TIME))
                .sign(Algorithm.HMAC512(JwtProperties.SECRET));

        String refreshToken = JWT.create()
                .withExpiresAt(new Date(System.currentTimeMillis()+JwtProperties.REFRESH_EXPIRATION_TIME))
                .sign(Algorithm.HMAC512(JwtProperties.SECRET));
        //RefreshToken을 Redis에 저장 (expirationTime 설정을 통해 자동 삭제 처리)
        redisTemplate.opsForValue()
                .set("RT:" + principalDetailis.getUsername(), refreshToken, JwtProperties.REFRESH_EXPIRATION_TIME, TimeUnit.MILLISECONDS);

        String jwtToken = JwtProperties.TOKEN_PREFIX+accessToken + "_AND_" + JwtProperties.TOKEN_PREFIX+refreshToken;

        response.addHeader(JwtProperties.HEADER_STRING, jwtToken);
    }
}
