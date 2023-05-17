package com.a804.tictactoc.ttt.config.jwt;

import com.a804.tictactoc.ttt.db.entity.User;
import com.a804.tictactoc.ttt.db.repository.UserRepository;

import com.a804.tictactoc.ttt.service.UserService;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;

import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.auth0.jwt.interfaces.DecodedJWT;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;
import org.springframework.util.StringUtils;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import static com.a804.tictactoc.ttt.config.jwt.JwtProperties.*;

public class JwtAuthorizationFilter extends BasicAuthenticationFilter {

    private UserRepository userRepository;

    private RedisTemplate redisTemplate;
    private UserService userService;

    private String uid;


    public JwtAuthorizationFilter(AuthenticationManager authenticationManager, UserRepository userRepository, UserService userService,RedisTemplate redisTemplate) {
        super(authenticationManager);
        this.userRepository = userRepository;
        this.userService = userService;
        this.redisTemplate = redisTemplate;

    }


    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {


        //String header = request.getHeader(JwtProperties.HEADER_STRING);
        //System.out.println(header);
        //액세스 토큰 가져옴(Bearer 없애고 가져오쟈) 인가는 'Authorization'으로 된다!
        String accessToken = request.getHeader(ACCESS_HEADER);
        //리프레시 토큰 가져옴(Bearer 없애고 가져오쟈)
        String refreshToken = request.getHeader(REFRESH_HEADER);

        accessToken = changeToken(accessToken);
        //변화 과정에서 방식이 이상하면 아예 return해야됨(해커임 ;)

        if (accessToken == null) {
            chain.doFilter(request, response);
            return;
        }

        if(refreshToken==null){
            try {

                DecodedJWT accssJwt = JWT.require(Algorithm.HMAC512(JwtProperties.SECRET)).build().verify(accessToken);
                Date expiration = accssJwt.getExpiresAt();
                long now = new Date().getTime();

                if(expiration.getTime() > now) {
                    // AccessToken이 유효한 경우
                    identifyUid(accessToken); //uid 제공

                }

            } catch (JWTVerificationException e) {
                // AccessToken이 만료된 경우
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "{\"code\": \"T004\", \"message\": \"Access Token is Expired\"}");
                redisTemplate.delete("AT:" + accessToken); //레디스에서 기존 accesstoken 삭제.
                return;
            }
        }else{
            refreshToken = changeToken(refreshToken);
            //액세스 토큰 변화해줌
            PrincipalDetails principalDetails = PrincipalDetailInfo.staticPrincipalDetailis;
            try {
                //7일 남았으면 재갱신
                DecodedJWT refreshJwt = JWT.require(Algorithm.HMAC512(JwtProperties.SECRET)).build().verify(accessToken);
                Date expiration = refreshJwt.getExpiresAt();
                long now = new Date().getTime();

                long time = 1000 * 60 * 60 * 24 * 7;


                // do something with principalDetails

                if (expiration.getTime() < now + time){};

            }catch(JWTVerificationException e) {
               // 리프레시 토큰 7일밖에 안남았으면 재갱신하기


                    redisTemplate.delete("RT:" + uid); // 레디스에서 유저 삭제
                    refreshToken = JWT.create()
                            .withSubject(principalDetails.getUsername())
                            .withExpiresAt(new Date(System.currentTimeMillis() + JwtProperties.REFRESH_EXPIRATION_TIME))
                            .withClaim("uid", principalDetails.getUser().getUid())
                            .sign(Algorithm.HMAC512(JwtProperties.SECRET));
                    //RefreshToken을 Redis에 저장 (expirationTime 설정을 통해 자동 삭제 처리)
                    redisTemplate.opsForValue()
                            .set("RT:" + principalDetails.getUsername(), refreshToken, JwtProperties.REFRESH_EXPIRATION_TIME, TimeUnit.MILLISECONDS);
                    System.out.println("refresh 갱신");
                }
            Map<String, String> doit = userService.reissue(refreshToken);
            accessToken = doit.get("accessToken");
            accessToken = changeToken(accessToken);
            //redis에 access 저장

            redisTemplate.opsForValue()
                    .set("AT:" + principalDetails.getUsername(), accessToken, JwtProperties.ACCESS_EXPIRATION_TIME, TimeUnit.MILLISECONDS);

            identifyUid(accessToken);
        }
        if (uid != null) {
            User user = userRepository.findByUid(uid);
            PrincipalDetails principalDetails = new PrincipalDetails(user);
            Authentication authentication =
                    new UsernamePasswordAuthenticationToken(
                            principalDetails,
                            null,  //패스워드는 모른다. 인증 용도 x
                            principalDetails.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(authentication); // 권한 관리를 위해 세션에 값 저장
            request.setAttribute("USER", user);  //api 호출을 위해 request에 user 정보 저장
        }

        if(refreshToken!=null){
            String refresh = JwtProperties.TOKEN_PREFIX+refreshToken;
            response.setHeader(JwtProperties.REFRESH_HEADER, refresh);
        }

        String access = JwtProperties.TOKEN_PREFIX+accessToken;
        response.setHeader(JwtProperties.ACCESS_HEADER, access);


        chain.doFilter(request, response);

    }


    private boolean identifyUid(String token) {

        try {
            DecodedJWT userJwt = JWT.require(Algorithm.HMAC512(JwtProperties.SECRET)).build().verify(token);
            uid = userJwt.getClaim("uid").asString();
            return true;
        } catch (TokenExpiredException expiredException) {

            return false;
        }
    }

    private String changeToken(String token) {

        // 인증 헤더가 존재하고, 인증 헤더 내용이 BEARER_PREFIX로 시작한다면 인증 정보를 파싱해서 리턴한다.
        if (StringUtils.hasText(token) && token.startsWith(TOKEN_PREFIX)) {
            return token.replace(TOKEN_PREFIX, "");
        }

        return null;


    }
}


