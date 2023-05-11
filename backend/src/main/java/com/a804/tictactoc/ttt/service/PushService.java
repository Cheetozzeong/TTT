package com.a804.tictactoc.ttt.service;

import com.a804.tictactoc.ttt.common.CommonEnum;

import java.util.Dictionary;
import java.util.List;

public interface PushService {
    public boolean SendPush(String title, String sendMessage, String deviceToken, CommonEnum.PushType type, long userId, String uid);
}
