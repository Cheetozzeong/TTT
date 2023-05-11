package com.a804.tictactoc.ttt.controller;
import com.a804.tictactoc.ttt.config.jwt.JwtProperties;
import com.a804.tictactoc.ttt.db.entity.User;
import com.a804.tictactoc.ttt.request.HabitReq;
import com.a804.tictactoc.ttt.request.LoginReq;
import com.a804.tictactoc.ttt.request.UserSleepReq;
import com.a804.tictactoc.ttt.response.TickleCountRes;
import com.a804.tictactoc.ttt.response.UserSleepRes;
import com.a804.tictactoc.ttt.service.UserServiceImpl;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.hibernate.annotations.Fetch;
import org.springdoc.api.annotations.ParameterObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Tag(name = "유저", description = "유저 api 입니다.")
@RestController
@CrossOrigin(origins = "*", allowedHeaders = "*")
@RequiredArgsConstructor
public class UserController {
    private final UserServiceImpl userService;
    @PostMapping("/login")
    public ResponseEntity<Object> login(@RequestBody LoginReq loginReq) throws Exception {

        return ResponseEntity.ok().body(HttpStatus.OK);
    }

/*
    @PostMapping("/reissue")
    public ResponseEntity<?> reissueToken(HttpServletRequest request) {
        String refreshToken = tokenRes.getRefreshToken();
        Map<String, String> response = new HashMap<>();
        if(refreshToken == null || !refreshToken.startsWith(JwtProperties.TOKEN_PREFIX)) {
            response.put("message", "리프레시 토큰을 보내주세요.");
        } else {
            tokenRes.setRefreshToken(refreshToken.replace(JwtProperties.TOKEN_PREFIX, ""));
            User user = (User) request.getAttribute("USER");
            String uid = user.getUid();
            response = userService.reissue(tokenRes,uid);
        }
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
*/

    @GetMapping("/logout")
    public ResponseEntity<?> logout(HttpServletRequest request) {
        User user = (User) request.getAttribute("USER");
        String accessToken = request.getHeader(JwtProperties.ACCESS_HEADER);
        Map<String, String> response = userService.logout(user, accessToken);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @PatchMapping("/user/quit")
    public ResponseEntity<?> quit(HttpServletRequest request) throws Exception {
        User user = (User) request.getAttribute("USER");
        long userId = user.getId();
        userService.quit(userId);
        return ResponseEntity.ok().body(HttpStatus.OK);
    }

    @GetMapping("/user/sleep")
    public ResponseEntity<?> getSleepTime(HttpServletRequest request) throws Exception {
        User user = (User) request.getAttribute("USER");
        long userId = user.getId();
        UserSleepRes userSleepRes = userService.getSleepTime(userId);
        return new ResponseEntity<UserSleepRes>(userSleepRes, HttpStatus.OK);
    }

    @PatchMapping("/user/sleep")
    public ResponseEntity<?> setSleepTime(@ParameterObject UserSleepReq userSleepReq, HttpServletRequest request) throws Exception {
        User user = (User) request.getAttribute("USER");
        long userId = user.getId();
        userService.sleepTime(userId, userSleepReq);
        return ResponseEntity.ok().body(HttpStatus.OK);
    }


    @ExceptionHandler(SQLException.class)
    @ResponseStatus(value = HttpStatus.BAD_REQUEST, reason = "유효하지 않은 입력 값")
    public void sqlException() {
        System.out.println("SQLException 발생");
        return;
    }
}
