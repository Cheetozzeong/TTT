package com.a804.tictactoc.ttt.controller;
import com.a804.tictactoc.ttt.common.CommonEnum;
import com.a804.tictactoc.ttt.common.CommonResult;
import com.a804.tictactoc.ttt.config.jwt.JwtProperties;
import com.a804.tictactoc.ttt.db.entity.User;
import com.a804.tictactoc.ttt.request.FcmReq;
import com.a804.tictactoc.ttt.request.LoginReq;
import com.a804.tictactoc.ttt.request.WatchFcmReq;
import com.a804.tictactoc.ttt.request.HabitReq;
import com.a804.tictactoc.ttt.request.UserSleepReq;
import com.a804.tictactoc.ttt.service.UserServiceImpl;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.hibernate.annotations.Fetch;
import org.springdoc.api.annotations.ParameterObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;
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

    @Operation(summary = "FCM 토큰 저장", description = "유저의 FCM 토큰을 저장합니다.",
            responses = {
                    @ApiResponse(responseCode = "200", description = "FCM 토큰 변경 성공"),
                    @ApiResponse(responseCode = "500", description = "서버 오류") })
    @PostMapping("/fcmtoken")
    public ResponseEntity<?> saveFcmToken(@RequestBody FcmReq fcmReq, HttpServletRequest request) {
        User user = (User) request.getAttribute("USER");
        String accessToken = request.getHeader(JwtProperties.ACCESS_HEADER);

        CommonResult response = userService.saveFcmToken(fcmReq, user);

        if(response.getCode() == CommonEnum.Result.SUCCESS){
            return new ResponseEntity<CommonResult>(response, HttpStatus.OK);

        }
        else{
            return new ResponseEntity<CommonResult>(response, HttpStatus.INTERNAL_SERVER_ERROR);

        }

    }


    @Operation(summary = "WATCH FCM 토큰 저장", description = "유저의 WATCH FCM 토큰을 저장합니다.",
            responses = {
                    @ApiResponse(responseCode = "200", description = "WATCH FCM 토큰 변경 성공"),
                    @ApiResponse(responseCode = "500", description = "서버 오류") })
    @PostMapping("/watchfcmtoken")
    public ResponseEntity<?> saveWatchFcmToken(@RequestBody WatchFcmReq fcmReq, HttpServletRequest request) {
        User user = (User) request.getAttribute("USER");
        String accessToken = request.getHeader(JwtProperties.ACCESS_HEADER);

        CommonResult response = userService.saveWatchFcmToken(fcmReq, user);

        if(response.getCode() == CommonEnum.Result.SUCCESS){
            return new ResponseEntity<CommonResult>(response, HttpStatus.OK);

        }
        else{
            return new ResponseEntity<CommonResult>(response, HttpStatus.INTERNAL_SERVER_ERROR);

        }
    }

    @PatchMapping("/user/quit")
    public ResponseEntity<?> quit(HttpServletRequest request) throws Exception {
        User user = (User) request.getAttribute("USER");
        long userId = user.getId();
        userService.quit(userId);
        return ResponseEntity.ok().body(HttpStatus.OK);
    }

    @PatchMapping("/user/sleep")
    public ResponseEntity<?> sleepTime(@RequestBody UserSleepReq userSleepReq, HttpServletRequest request) throws Exception {
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
