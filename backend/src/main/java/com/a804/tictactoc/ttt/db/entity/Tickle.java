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
@Builder
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

	@Schema(name = "이 티끌이 만들어진 날짜", example = "20230427", defaultValue = "YYYYMMDD")
	@Column(name="execution_day")
	String executionDay;

	@Schema(name = "이 티끌이 만들어진 시간", example = "0930", defaultValue = "HHmm")
	@Column(name="execution_time")
	String executionTime;


	@Schema(hidden = true)
	@Column(name="created_date", updatable = false, insertable = false)
	String createdDate;
}
