package com.a804.tictactoc.ttt.service;

import com.a804.tictactoc.ttt.db.entity.Alarm;
import com.a804.tictactoc.ttt.db.entity.Habit;
import com.a804.tictactoc.ttt.db.repository.AlarmRepo;
import com.a804.tictactoc.ttt.db.repository.HabitRepo;
import com.a804.tictactoc.ttt.db.repository.UserRepository;
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

    @Autowired
    UserRepository uRepo;

    @Override
    public List<HabitRes> readAll(long userId) throws SQLException {
        return hRepo.findByUserIdAndDeleteYnOrderByCategoryId(userId, 0);
    }

//    @Override
//    public HabitRes readOneHabit(long habitId) throws SQLException {
//       Habit habit = hRepo.findById(habitId).get();
//       return null;
//    }

    @Override
    public HabitRes createHabit(HabitReq habitReq, long userId) throws SQLException {
        if(Integer.parseInt(habitReq.getTerm()) == 0)
            return null;

        Habit habit = habitReq.toEntity();
        habit.setUser(uRepo.findById(userId).get());//habit.setUserId(userId);
        habit = hRepo.save(habit);
        createAlarm(habit.getStartTime(), habit.getEndTime(), habit.getTerm(), habit.getId());

        return HabitRes.builder().habit(habit).build();
    }

    @Override
    public HabitRes updateHabit(HabitReq habitReq) throws SQLException {
        if(Integer.parseInt(habitReq.getTerm()) == 0)
            return null;

        Habit habit = hRepo.findById(habitReq.getId()).get();
        habit.setCategoryId(habitReq.getCategoryId());
        habit.setName(habitReq.getName());
        habit.setEmoji(habitReq.getEmoji());
        habit.setRepeatDay(habitReq.getRepeatDay());

        if(habit.getStartTime().equals(habitReq.getStartTime()) == false || habit.getEndTime().equals(habitReq.getEndTime()) == false ||
                habit.getTerm().equals(habitReq.getTerm()) == false){ //알람 시간이 변경됐다면
            aRepo.deleteByHabitId(habit.getId());//삭제 후
            createAlarm(habitReq.getStartTime(), habitReq.getEndTime(), habitReq.getTerm(), habitReq.getId());//재생성
        }
        habit.setStartTime(habitReq.getStartTime());
        habit.setEndTime((habitReq.getEndTime()));
        habit.setTerm(habitReq.getTerm());

        hRepo.save(habit);

        return HabitRes.builder().habit(habit).build();
    }

    void createAlarm(String startTime, String endTime, String terms, long habitId){
        int start = Integer.parseInt(startTime.substring(0,2)) * 60 + Integer.parseInt(startTime.substring(2,4));
        int end = Integer.parseInt(endTime.substring(0,2)) * 60 + Integer.parseInt(endTime.substring(2,4));
        int term = Integer.parseInt(terms.substring(0,2)) * 60 + Integer.parseInt(terms.substring(2,4));

        for(int i=start; i<=end; i+=term){
            String alarmTime = i/60<10 ? 0+""+i/60 : ""+i/60;
            alarmTime += i%60<10 ? 0+""+i%60 : ""+i%60;
            aRepo.save(new Alarm(0, habitId, alarmTime));
        }
    }

    @Override
    public HabitRes deleteHabit(long userId, long habitId) throws SQLException {
        Habit habit = hRepo.findById(habitId).get();
        if(habit.getUser().getId() == userId){
            habit.setDeleteYn(1);
            habit = hRepo.save(habit);
        }
        return HabitRes.builder().habit(habit).build();
    }
}
