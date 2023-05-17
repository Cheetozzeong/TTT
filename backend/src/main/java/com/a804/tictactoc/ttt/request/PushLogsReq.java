package com.a804.tictactoc.ttt.request;

import com.a804.tictactoc.ttt.db.entity.PushLogs;

public class PushLogsReq {
    private int id;
    private long userId;
    private String title;
    private String body;
    private String token;
    private String type;
    private String pushToken;

    public PushLogs toEntity() {
        return PushLogs.builder()
                .id(id)
                .userId(userId)
                .title(title)
                .body(body)
                .token(token)
                .type(type)
                .pushToken(pushToken)
                .build();
    }
}
