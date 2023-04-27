package com.a804.tictactoc.ttt.db.repository;


import com.a804.tictactoc.ttt.db.entity.Tickle;
import com.a804.tictactoc.ttt.response.TickleAchieveRes;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface TickleRepo extends JpaRepository<Tickle,Long>{
    @Query(value = "select alarm_time as alarmTime, execution_time as executionTime\n" +
            "from alarm left outer join tickle on alarm_time = execution_time\n" +
            "where alarm.habit_id = ?1", nativeQuery = true)
    List<TickleAchieveRes> findTickleAchieve(long habitId);
}
