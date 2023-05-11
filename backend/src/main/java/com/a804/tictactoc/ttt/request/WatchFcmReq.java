package com.a804.tictactoc.ttt.request;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;

@Getter
public class WatchFcmReq {
    String watchFcmToken;
    @Schema(name="워치에 완료 알람 보내면 true, 안보내면 false")
    boolean sendPush;
}
