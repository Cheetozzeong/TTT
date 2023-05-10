package com.a804.tictactoc.ttt.db.repository;

import com.a804.tictactoc.ttt.db.entity.Habit;
import com.a804.tictactoc.ttt.db.entity.QCategory;
import com.a804.tictactoc.ttt.db.entity.QHabit;
import com.a804.tictactoc.ttt.db.entity.QTickle;
import com.a804.tictactoc.ttt.response.TickleCountRes;
import com.querydsl.jpa.JPAExpressions;
import com.querydsl.jpa.impl.JPAQueryFactory;
import org.hibernate.query.criteria.internal.expression.function.AggregationFunction;

import java.util.ArrayList;
import java.util.List;

public class TickleRepoCustomImpl implements TickleRepoCustom{

    private final JPAQueryFactory jpaQueryFactory;
    private QTickle tickle = QTickle.tickle;
    private QCategory category = QCategory.category;
    private QHabit habit = QHabit.habit;

    public TickleRepoCustomImpl(JPAQueryFactory jpaQueryFactory){
        this.jpaQueryFactory = jpaQueryFactory;
    }

    @Override
    public List<TickleCountRes> findCount(long userId) {
        jpaQueryFactory.select(category.id, category.name)
                .from(category)
                .leftJoin(habit)
                .on(category.id.eq(habit.categoryId))
                .groupBy(category.id);
        return null;
    }
}
//jpaQueryFactory.selectFrom(habit).join(tickle).on(habit.id.eq(tickle.habitId)).fetch()
