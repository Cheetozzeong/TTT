package com.a804.tictactoc.ttt.db.entity;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

import javax.persistence.*;

@Entity
@Getter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class PushLogs {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name="user_id")
    private long userId;
    private String title;
    private String body;
    private String token;
    private String type;
    @Column(name="push_token")
    private String pushToken;

    @Schema(hidden = true)
    @Column(name="created_date", updatable = false, insertable = false)
    String createdDate;

    @Schema(hidden = true)
    @Column(name="modified_date", updatable = false, insertable = false)
    String modifiedDate;

    public PushLogs(int id, long userId, String title, String body, String token, String type, String pushToken){
        this.id = id;
        this.userId = userId;
        this.title = title;
        this.body = body;
        this.token = token;
        this.type = type;
        this.pushToken = pushToken;


    }
}
