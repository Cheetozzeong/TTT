package com.a804.tictactoc.ttt.config.batch;

import com.a804.tictactoc.ttt.service.ScheduleServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class ScheduledConfig {


    @Autowired
    ScheduleServiceImpl scheduleService;

    @Scheduled(fixedDelay = 1000 * 60 * 1)
    public void SendPushAlarm(){
        scheduleService.SendPushAlarm();
//        System.out.println("하하하하 잘 돈다.");
    }

}
