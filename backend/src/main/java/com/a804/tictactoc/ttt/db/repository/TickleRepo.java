package com.a804.tictactoc.ttt.db.repository;


import com.a804.tictactoc.ttt.db.entity.Tickle;
import com.a804.tictactoc.ttt.response.TickleAchieveRes;
import com.a804.tictactoc.ttt.response.TickleCountRes;
import com.a804.tictactoc.ttt.response.TicklePastAchieveRes;
import com.a804.tictactoc.ttt.response.TickleRes;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface TickleRepo extends JpaRepository<Tickle,Long>{
    @Query(value = "select alarm_time as alarmTime, execution_time as executionTime\n" +
            "from alarm left outer join \n" +
            "(select execution_day, execution_time from tickle\n" +
            "where execution_day = ?2 and habit_id = ?1) as tickle\n" +
            "on alarm_time = execution_time\n" +
            "where alarm.habit_id = ?1", nativeQuery = true)
    List<TickleAchieveRes> findTickleAchieve(long habitId, String executionDay);

    @Query(value = "select category.id as categoryId, category.name as categoryName, count(distinct habit_id, execution_day) as count\n" +
            "from category left outer join\n" +
            "(habit join tickle on habit.id = habit_id and habit.user_id = ?1)\n" +
            "on habit.category_id = category.id\n" +
            "group by category.id;", nativeQuery = true)
    List<TickleCountRes> countByTickle(long userId);


    @Query(value = "select category_id as categoryId, habit.name as habitName, execution_time as executionTime, emoji " +
            "from habit join tickle on habit.id = tickle.habit_id and habit.user_id = ?1 and tickle.execution_day = ?2 " +
            "", nativeQuery = true)
    List<TicklePastAchieveRes> findPastTickles(long userId, String day);

    @Query(value = "select distinct execution_day as executionDay " +
            "from habit join tickle on habit.id = tickle.habit_id " +
            "and habit.user_id = ?1 " +
            "and tickle.execution_day like ?2 ", nativeQuery = true)
    List<String> isMonthAchieve(long userId, String day);
    
    TickleRes deleteByHabitIdAndExecutionDayAndExecutionTime(long habitId, String executionDay, String executionTime);
}
