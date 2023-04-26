package com.a804.tictactoc.ttt.db.entity;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;

/**
 * 유저 모델 정의.
 */
@Entity
@Table(name="tickle")
@DynamicInsert
@DynamicUpdate
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Tickle {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Schema(hidden = true)
    long id;
	
	@Schema(name = "어떤 습관의 티끌인지", example = "1", defaultValue = "1")
	@Column(name="habit_id")
	long habitId;

	@Schema(hidden = true)
	@Column(name="created_date")
	String createdDate;
}
