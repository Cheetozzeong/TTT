package com.a804.tictactoc.ttt.request;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;

/**
 * 유저 모델 정의.
 */
@Schema(name="alarm")
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class AlarmReq {
    long id;
	
	@Schema(name = "habitId", description = "어떤 습관의 알람인지", example = "1", defaultValue = "1")
	@Column(name="habit_id", updatable = false)
	long habitId;

	@Schema(name = "alarmTime", description = "알람이 울려야 하는 시간 HHmm", example = "0930", defaultValue = "0930")
	@Column(name="alarm_time")
	String alarmTime;
}
