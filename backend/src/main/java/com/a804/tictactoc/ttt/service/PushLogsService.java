package com.a804.tictactoc.ttt.service;

import com.a804.tictactoc.ttt.common.CommonResult;
import com.a804.tictactoc.ttt.request.PushLogsReq;

public interface PushLogsService {
    // 일단은 하나씩 저장하게 해두고 나중에 모아서 저장하게 수정해야한다.
    public CommonResult SavePushLog(PushLogsReq res);

}
