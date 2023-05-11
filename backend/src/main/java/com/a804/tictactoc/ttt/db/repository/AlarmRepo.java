package com.a804.tictactoc.ttt.db.repository;


import com.a804.tictactoc.ttt.db.entity.Alarm;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;


@Repository
public interface AlarmRepo extends JpaRepository<Alarm,Long>{
    @Transactional
    @Modifying
    @Query(value = "delete from alarm where habit_id = ?1", nativeQuery = true)
    void deleteByHabitId(long habitId);
}
