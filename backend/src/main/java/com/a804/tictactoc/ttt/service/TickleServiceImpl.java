package com.a804.tictactoc.ttt.service;

import com.a804.tictactoc.ttt.db.entity.Tickle;
import com.a804.tictactoc.ttt.db.repository.CategoryRepo;
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
    public TickleRes createTickle(TickleReq tickleReq) throws SQLException {
        Tickle tickle = tickleReq.toEntity();
        tRepo.save(tickle);
        return TickleRes.builder().tickle(tickle).build();
    }

    @Override
    public List<TickleCategoryRes> todayTickle(long userId, String day) throws SQLException {
        LocalDate date = LocalDate.of(Integer.parseInt(day.substring(0,4)),
                Integer.parseInt(day.substring(4,6)),Integer.parseInt(day.substring(6,8)));

        //오늘이 무슨 요일인지
        int yoil = date.getDayOfWeek().getValue();
        if(yoil == 7)
            yoil = 0;

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

        //각 오늘 실행해야할 습관들을 티끌로 만들고, 수행 여부도 확인한다
        List<HabitRes> habitList = hRepo.findByUserIdAndDeleteYnOrderByCategoryId(userId, 0);
        for(HabitRes habit : habitList){
            if(habit.getRepeatDay().charAt(yoil) == '0')
                continue;

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
    public List<TickleCountRes> countTickle() throws SQLException {
        return tRepo.countByTickle();
    }
}
