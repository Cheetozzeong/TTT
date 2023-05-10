package com.a804.tictactoc.ttt.db.entity;

import lombok.Getter;

import javax.persistence.*;

@Entity
@Getter
public class Config {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    int id;

    @Column(name="name")
    String name;

    @Column(name="value")
    int value;
}
