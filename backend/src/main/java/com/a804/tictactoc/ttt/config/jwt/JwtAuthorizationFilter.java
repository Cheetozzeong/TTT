package com.a804.tictactoc.ttt.config.jwt;

import com.a804.tictactoc.ttt.db.entity.User;
import com.a804.tictactoc.ttt.db.repository.UserRepository;

import com.a804.tictactoc.ttt.service.UserService;
import com.a804.tictactoc.ttt.service.UserServiceImpl;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.exceptions.TokenExpiredException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.auth0.jwt.interfaces.JWTVerifier;
import io.netty.util.internal.StringUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;
import org.springframework.util.StringUtils;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

import static com.a804.tictactoc.ttt.config.jwt.JwtProperties.*;

public class JwtAuthorizationFilter extends BasicAuthenticationFilter {

    private UserRepository userRepository;


    private UserService userService;

    private String uid;

    public JwtAuthorizationFilter(AuthenticationManager authenticationManager, UserRepository userRepository, UserService userService) {
        super(authenticationManager);
        this.userRepository = userRepository;
        this.userService = userService;
    }


    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {

        //String header = request.getHeader(JwtProperties.HEADER_STRING);
        //System.out.println(header);
        //액세스 토큰 가져옴(Bearer 없애고 가져오쟈) 인가는 'Authorization'으로 된다!
        String accessToken = request.getHeader(JwtProperties.HEADER_STRING);
        //리프레시 토큰 가져옴(Bearer 없애고 가져오쟈)
        String refreshToken = request.getHeader(JwtProperties.HEADER_STRING);

        refreshToken = changeToken(refreshToken);
        //액세스 토큰 변화해줌
        accessToken = changeToken(accessToken);
        //변화 과정에서 방식이 이상하면 아예 return해야됨(해커임 ;)
        if (accessToken == null) {
            chain.doFilter(request, response);
            return;
        }
        //accesstoken ok! 인증 ok! 4달라!
        if(checkToken(accessToken) == true) {
            System.out.println("accessToken OK");
        //refreshtoken ok!
        } else if(checkToken(refreshToken) == true) {
            System.out.println("refreshToken OK");
            userService.reissue(refreshToken);
            //로그인 필요...
        } else {
            response.sendError(401);
            return;
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
        chain.doFilter(request, response);

        System.out.println(uid);

    }


    private boolean checkToken(String token) {

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


