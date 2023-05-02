package com.a804.tictactoc.ttt.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class TokenRes {

    String refreshToken;
    String userEmail;
}
