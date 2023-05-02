package com.a804.tictactoc.ttt.controller;
import com.a804.tictactoc.ttt.config.jwt.JwtProperties;
import com.a804.tictactoc.ttt.db.entity.User;
import com.a804.tictactoc.ttt.request.LoginReq;
import com.a804.tictactoc.ttt.response.TokenRes;
import com.a804.tictactoc.ttt.service.UserServiceImpl;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Tag(name = "테스트", description = "테스트 api 입니다.")
@RestController
@RequiredArgsConstructor
public class UserController {
    private final UserServiceImpl userService;
    @PostMapping("/login")
    public ResponseEntity<Object> login(@RequestBody LoginReq loginReq) throws Exception {
        System.out.println("이건 됨? 컨트롤러");

        return ResponseEntity.ok().body(HttpStatus.OK);
    }

    @PostMapping("/reissue")
    public ResponseEntity<?> reissueToken(@RequestBody TokenRes tokenRes) {
        String refreshToken = tokenRes.getRefreshToken();
        Map<String, String> response = new HashMap<>();
        if(refreshToken == null || !refreshToken.startsWith(JwtProperties.TOKEN_PREFIX)) {
            response.put("message", "리프레시 토큰을 보내주세요.");
        } else {
            tokenRes.setRefreshToken(refreshToken.replace(JwtProperties.TOKEN_PREFIX, ""));
            response = userService.reissue(tokenRes);
        }
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    @GetMapping("/logout")
    public ResponseEntity<?> logout(HttpServletRequest request) {
        User user = (User) request.getAttribute("USER");
        String accessToken = request.getHeader(JwtProperties.HEADER_STRING);
        Map<String, String> response = userService.logout(user, accessToken);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}
