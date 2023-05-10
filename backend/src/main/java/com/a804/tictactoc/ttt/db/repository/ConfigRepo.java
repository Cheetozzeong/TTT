package com.a804.tictactoc.ttt.db.repository;

import com.a804.tictactoc.ttt.db.entity.Config;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ConfigRepo extends JpaRepository<Config,Long> {
    Config findByName(String name);
}
