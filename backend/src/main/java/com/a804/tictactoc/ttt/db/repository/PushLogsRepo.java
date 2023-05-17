package com.a804.tictactoc.ttt.db.repository;

import com.a804.tictactoc.ttt.db.entity.PushLogs;
import com.a804.tictactoc.ttt.db.entity.Tickle;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PushLogsRepo  extends JpaRepository<PushLogs,Integer> {

}
