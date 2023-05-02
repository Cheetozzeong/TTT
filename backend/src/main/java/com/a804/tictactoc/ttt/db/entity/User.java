package com.a804.tictactoc.ttt.db.entity;

import lombok.*;

import javax.persistence.*;


@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long userSeq;
    @Column(columnDefinition = "VARCHAR(100)", unique = true)
    private String userEmail;
    @Column(columnDefinition = "VARCHAR(30)", unique = true)
    private String userNickname;

}
