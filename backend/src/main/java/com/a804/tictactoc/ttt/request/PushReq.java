package com.a804.tictactoc.ttt.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@Getter
@AllArgsConstructor
public class PushReq {
    String habitName;
    String emoji;
    long userId;
}
