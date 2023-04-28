package com.a804.tictactoc.ttt.db.repository;


import com.a804.tictactoc.ttt.db.entity.Alarm;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface AlarmRepo extends JpaRepository<Alarm,Long>{

}
