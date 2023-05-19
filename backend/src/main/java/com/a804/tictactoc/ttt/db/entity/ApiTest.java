package com.a804.tictactoc.ttt.db.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Entity
@Getter
@Setter
public class ApiTest {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int at_id;
    private String at_title;
}
