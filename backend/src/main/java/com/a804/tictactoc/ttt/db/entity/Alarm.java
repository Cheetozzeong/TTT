package com.a804.tictactoc.ttt.db.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;

/**
 * 유저 모델 정의.
 */
@Entity
@Table(name="alarm")
@DynamicInsert
@DynamicUpdate
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Alarm {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Schema(hidden = true)
    long id;
	
//	@Schema(name = "어떤 습관의 알람인지", example = "1", defaultValue = "1")
//	@Column(name="habit_id", updatable = false)
//	long habitId;

	@Schema(name = "알람이 울려야 하는 시간 HHmm", example = "0930", defaultValue = "0930")
	@Column(name="alarm_time")
	String alarmTime;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "habit_id")
	Habit habit;
}
