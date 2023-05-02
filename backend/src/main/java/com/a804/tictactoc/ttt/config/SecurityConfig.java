package com.a804.tictactoc.ttt.config;

import com.a804.tictactoc.ttt.config.jwt.JwtAuthenticationFilter;
import com.a804.tictactoc.ttt.config.jwt.JwtAuthorizationFilter;
import com.a804.tictactoc.ttt.config.jwt.PrincipalDetailsService;
import com.a804.tictactoc.ttt.db.repository.UserRepository;

import com.a804.tictactoc.ttt.service.UserService;
import com.google.firebase.auth.FirebaseAuth;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;

import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@EnableWebSecurity
@Configuration
@RequiredArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    //사용자 인증이 필요한 웹 사이트에 연결하기 위한 구성 정보를 제공합니다.
    private final AuthenticationConfiguration authenticationConfiguration;
    private final UserRepository userRepository;
    private final RedisTemplate<String, Object> redisTemplate;
    private final UserService userService;
    private final FirebaseAuth firebaseAuth;

    private final PrincipalDetailsService principalDetailsService;


    //authenticationManager authenticate이라는 하나의 메소드만 가진다.
    //User가 입력한 username, password등의 인증정보를 가지고, 유효성 확인 후 UserDetailService가 return한
    //객체를 Principal로 담고 있는 Authentication 객체를 return 해준다.
    public AuthenticationManager authenticationManager() throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }
    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager customAuthenticationManager() throws Exception {
        return authenticationManager();
    }
    /*
     스프링시큐리티에서 웹 애플리 케이션에 주로 영향을 주는 방식은
     ServeltRequest 필터를 사용하는 방식이며,
     필터들이 애플리케이션에 대한 모든 요청을 감싸서 처리합니다.
    */
    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http
                .cors().disable()
                .csrf().disable()
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                .formLogin().disable()
                .httpBasic().disable()
                .addFilter(new JwtAuthenticationFilter(authenticationManager(), redisTemplate, firebaseAuth, userService,principalDetailsService ))
                .addFilter(new JwtAuthorizationFilter(authenticationManager(), userRepository))
                .authorizeRequests()
                .antMatchers("/*").permitAll()
                .antMatchers("/swagger-ui/**", "/swagger-resources/**", "/v3/api-docs/**", "/api-docs/**").permitAll()
                .anyRequest().authenticated();


    }


    //스프링 시큐리티(Spring Seurity) 프레임워크에서 제공하는 클래스 중 하나로 비밀번호를 암호화하는 데 사용할 수 있는 메서드를 가진 클래스입니다.

}