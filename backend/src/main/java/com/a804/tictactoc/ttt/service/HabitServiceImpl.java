package com.a804.tictactoc.ttt.service;

import com.a804.tictactoc.ttt.db.entity.Alarm;
import com.a804.tictactoc.ttt.db.entity.Habit;
import com.a804.tictactoc.ttt.db.repository.AlarmRepo;
import com.a804.tictactoc.ttt.db.repository.HabitRepo;
import com.a804.tictactoc.ttt.request.HabitReq;
import com.a804.tictactoc.ttt.response.HabitRes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;

@Service
public class HabitServiceImpl implements HabitService{

    @Autowired
    HabitRepo hRepo;

    @Autowired
    AlarmRepo aRepo;

    @Override
    public List<HabitRes> readAll(long userId) throws SQLException {
        List<Habit> habit = hRepo.test((long)5);
        System.out.println(habit.get(0));

        return hRepo.findByUserIdAndDeleteYnOrderByCategoryId(userId, 0);
    }

//    @Override
//    public HabitRes readOneHabit(long habitId) throws SQLException {
//       Habit habit = hRepo.findById(habitId).get();
//       return null;
//    }

    @Override
    public HabitRes createHabit(HabitReq habitReq, long userId) throws SQLException {
        Habit habit = habitReq.toEntity();
        habit.setUserId(userId);
        habit = hRepo.save(habit);

        int start = Integer.parseInt(habit.getStartTime().substring(0,2)) * 60 + Integer.parseInt(habit.getStartTime().substring(2,4));
        int end = Integer.parseInt(habit.getEndTime().substring(0,2)) * 60 + Integer.parseInt(habit.getEndTime().substring(2,4));
        int term = Integer.parseInt(habit.getTerm().substring(0,2)) * 60 + Integer.parseInt(habit.getTerm().substring(2,4));

        for(int i=start; i<=end; i+=term){
            String alarmTime = i/60<10 ? 0+""+i/60 : ""+i/60;
            alarmTime += i%60<10 ? 0+""+i%60 : ""+i%60;
            Alarm alarm = new Alarm();
            alarm.setHabit(new Habit(habit.getId()));
            alarm.setAlarmTime(alarmTime);
            aRepo.save(alarm);
        }

        return HabitRes.builder().habit(habit).build();
    }

    @Override
    public HabitRes updateHabit(HabitReq habitReq) throws SQLException {
        Habit habit = hRepo.save(habitReq.toEntity());
        return HabitRes.builder().habit(habit).build();
    }

    @Override
    public HabitRes deleteHabit(long userId, long habitId) throws SQLException {
        Habit habit = hRepo.findById(habitId).get();
        habit.setDeleteYn(1);
        habit = hRepo.save(habit);
        return HabitRes.builder().habit(habit).build();
    }
}
