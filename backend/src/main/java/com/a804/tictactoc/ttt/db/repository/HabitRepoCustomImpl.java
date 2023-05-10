package com.a804.tictactoc.ttt.db.repository;

import com.a804.tictactoc.ttt.db.entity.Habit;
import com.a804.tictactoc.ttt.db.entity.QHabit;
import com.a804.tictactoc.ttt.response.HabitRes;
import com.querydsl.jpa.impl.JPAQueryFactory;

import java.util.ArrayList;
import java.util.List;

public class HabitRepoCustomImpl implements HabitRepoCustom{

    private final JPAQueryFactory jpaQueryFactory;
    private QHabit habit = QHabit.habit;

    public HabitRepoCustomImpl(JPAQueryFactory jpaQueryFactory){
        this.jpaQueryFactory = jpaQueryFactory;
    }

    @Override
    public List<HabitRes> findByUserId(long userId) {
        List<Habit> habits = jpaQueryFactory.selectFrom(habit).where(habit.userId.eq(userId)).fetch();

        List<HabitRes> result = new ArrayList<>();
        for(Habit habit : habits)
            result.add(HabitRes.builder().habit(habit).build());
        
        return result;
    }
}
