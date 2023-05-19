package com.a804.tictactoc.ttt.service;

import com.a804.tictactoc.ttt.db.entity.Habit;
import com.a804.tictactoc.ttt.db.entity.Tickle;
import com.a804.tictactoc.ttt.db.repository.HabitRepo;
import com.a804.tictactoc.ttt.db.repository.TickleRepo;
import com.a804.tictactoc.ttt.request.TickleReq;
import com.a804.tictactoc.ttt.response.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class TickleServiceImpl implements TickleService{
    @Autowired
    TickleRepo tRepo;

    @Autowired
    HabitRepo hRepo;

    @Autowired
    CategoryService cService;


    @Override
    public TickleRes readTickle(long tickleId) throws SQLException {
        Tickle tickle = tRepo.findById(tickleId).get();
        return TickleRes.builder().tickle(tickle).build();
    }

    @Override
    public TickleRes createTickle(long userId, TickleReq tickleReq) throws SQLException {
        Habit habit = hRepo.findById(tickleReq.getHabitId()).get();
        if(habit.getUser().getId() == userId){
            Tickle tickle = tickleReq.toEntity();
            tRepo.save(tickle);
            System.out.println();
            return TickleRes.builder().tickle(tickle).build();
        }
        return null;
    }

    public int getYoil(String day){
        LocalDate date = LocalDate.of(Integer.parseInt(day.substring(0,4)),
                Integer.parseInt(day.substring(4,6)),Integer.parseInt(day.substring(6,8)));
        int yoil = date.getDayOfWeek().getValue();

        if(yoil == 7)
            yoil = 0;
        return yoil;
    }

    @Override
    public List<TickleCategoryRes> todaySchedule(long userId, String day) throws SQLException {
        int yoil = getYoil(day);

        //카테고리 숫자에 맞춰 카테고리별 티끌을 정리한 리스트를 만듬
        List<CategoryRes> categoryList = cService.findAllCategory();
        List<TickleCategoryRes> result = new ArrayList<>();
        for(CategoryRes categoryRes : categoryList){
            TickleCategoryRes tickleCategoryRes = new TickleCategoryRes();
            tickleCategoryRes.setTickles(new ArrayList<>());
            tickleCategoryRes.setCategoryId(categoryRes.getId());
            tickleCategoryRes.setCategoryName(categoryRes.getName());
            result.add(tickleCategoryRes);
        }

        StringBuilder repeatDayLike = new StringBuilder();
        repeatDayLike.append("_".repeat(yoil));
        repeatDayLike.append("1");
        repeatDayLike.append("_".repeat(6-yoil));

        //각 오늘 실행해야할 습관들을 티끌로 만들고, 수행 여부도 확인한다
        List<HabitRes> habitList = hRepo.findByUserIdAndDeleteYnAndRepeatDayLikeOrderByCategoryId(userId, 0, repeatDayLike.toString());

        for(HabitRes habit : habitList){
            TickleCategoryRes tickleCategoryRes =   result.stream().
                                                    filter(tcRes -> tcRes.getCategoryId() == habit.getCategoryId())
                                                    .findFirst().get();

            List<TickleAchieveRes> tickleAchieveReses = tRepo.findTickleAchieve(habit.getId(), day);//여기서 값을 받아오고 -> 곧 만들 조인쿼리

            for(TickleAchieveRes tickleAchieveRes : tickleAchieveReses){
                TickleTodayRes tickleTodayRes = new TickleTodayRes();
                if(tickleAchieveRes.getExecutionTime() == null)
                    tickleTodayRes.setAchieved(false);
                else
                    tickleTodayRes.setAchieved(true);

                tickleTodayRes.setHabitId(habit.getId());
                tickleTodayRes.setHabitName(habit.getName());
                tickleTodayRes.setExecutionTime(tickleAchieveRes.getAlarmTime());
                tickleTodayRes.setEmoji(habit.getEmoji());

                tickleCategoryRes.getTickles().add(tickleTodayRes);
            }
        }

        //시간순으로 정렬
        for(TickleCategoryRes tickleCategoryRes : result){
            Collections.sort(tickleCategoryRes.getTickles());
        }

        return result;
    }

    @Override
    public List<TickleCountRes> countTickle(long userId) throws SQLException {
        return tRepo.countByTickle(userId);
    }

    @Override
    public List<TickleCategoryPastRes> pastTickles(long userId, String day) throws SQLException {
        List<CategoryRes> categoryList = cService.findAllCategory();
        List<TickleCategoryPastRes> result = new ArrayList<>();
        for(CategoryRes categoryRes : categoryList){
            TickleCategoryPastRes tickleCategoryPastRes = new TickleCategoryPastRes();
            tickleCategoryPastRes.setTickles(new ArrayList<>());
            tickleCategoryPastRes.setCategoryId(categoryRes.getId());
            tickleCategoryPastRes.setCategoryName(categoryRes.getName());
            result.add(tickleCategoryPastRes);
        }

        List<TicklePastAchieveRes> ticklePastAchieveResList = tRepo.findPastTickles(userId, day);
        for(TicklePastAchieveRes ticklePastAchieveRes : ticklePastAchieveResList){
            TickleCategoryPastRes tickleCategoryPastRes =   result.stream().
                    filter(tcRes -> tcRes.getCategoryId() == ticklePastAchieveRes.getCategoryId())
                    .findFirst().get();

            TicklePastRes ticklePastRes = new TicklePastRes();
            ticklePastRes.setEmoji(ticklePastAchieveRes.getEmoji());
            ticklePastRes.setExecutionTime(ticklePastAchieveRes.getExecutionTime());
            ticklePastRes.setHabitName(ticklePastAchieveRes.getHabitName());

            tickleCategoryPastRes.getTickles().add(ticklePastRes);
        }

        for(TickleCategoryPastRes tickleCategoryPastRes : result){
            Collections.sort(tickleCategoryPastRes.getTickles());
        }

        return result;
    }

    @Override
    public List<String> monthTickleAchieve(long userId, String month) throws SQLException {
        return tRepo.isMonthAchieve(userId, month+"__");
    }



    @Override
    public void deleteTickle(long userId, TickleReq tickleReq) throws SQLException {
        Habit habit = hRepo.findById(tickleReq.getHabitId()).get();
        if(habit.getUser().getId() == userId) {
            System.out.println("삭제완료");
            tRepo.deleteByHabitIdAndExecutionDayAndExecutionTime(tickleReq.getHabitId(),
                    tickleReq.getExecutionDay(), tickleReq.getExecutionTime());
        }
    }
}
