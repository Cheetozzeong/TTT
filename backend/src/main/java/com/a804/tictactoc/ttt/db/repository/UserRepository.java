package com.a804.tictactoc.ttt.db.repository;

import com.a804.tictactoc.ttt.db.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository  extends JpaRepository<User, Long> {

    User findByUid(String uid);
}
