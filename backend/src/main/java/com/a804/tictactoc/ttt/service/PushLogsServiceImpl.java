package com.a804.tictactoc.ttt.service;

import com.a804.tictactoc.ttt.common.CommonEnum;
import com.a804.tictactoc.ttt.common.CommonResult;
import com.a804.tictactoc.ttt.db.repository.PushLogsRepo;
import com.a804.tictactoc.ttt.request.PushLogsReq;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class PushLogsServiceImpl implements PushLogsService {

    PushLogsRepo pushLogsRepo;

    @Override
    public CommonResult SavePushLog(PushLogsReq res) {
        CommonResult result = new CommonResult();

        try{
            pushLogsRepo.save(res.toEntity());
            result = new CommonResult(CommonEnum.Result.SUCCESS, "푸시로그 저장에 성공했습니다-.");
        }
        catch (Exception ex){
            System.out.println(ex);
            result = new CommonResult(CommonEnum.Result.FAIL, "푸시로그 저장에 실패했습니다.");
        }

        return result;
    }
}
