package com.a804.tictactoc.ttt.db.entity;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

import javax.persistence.*;

/**
 * 유저 모델 정의.
 */
@Entity
@Table(name="alarm")
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
	
	@Schema(name = "어떤 습관의 알람인지", example = "1", defaultValue = "1")
	@Column(name="habit_id")
	long habitId;

	@Schema(name = "알람이 울려야 하는 시간 HHmm", example = "0930", defaultValue = "0930")
	@Column(name="alarm_time")
	String alarmTime;
}
