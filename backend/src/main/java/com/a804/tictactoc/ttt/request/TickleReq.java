package com.a804.tictactoc.ttt.request;

import com.a804.tictactoc.ttt.db.entity.Habit;
import com.a804.tictactoc.ttt.db.entity.Tickle;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;

/**
 * 유저 모델 정의.
 */
@Schema(name="TickleReq")
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class TickleReq {
	@Schema(name = "습관의 아이디", description = "어떤 습관의 티끌인지", example = "1")
	long habitId;

	@Schema(name = "이 티끌이 만들어진 날짜", example = "20230427", defaultValue = "YYYYMMDD")
	String executionDay;

	@Schema(name = "이 티끌이 만들어진 시간", example = "0930", defaultValue = "HHmm")
	String executionTime;

	public Tickle toEntity() {
		return Tickle.builder()
				//.habitId(habitId)
				.habit(new Habit(habitId))
				.executionDay(executionDay)
				.executionTime(executionTime)
				.build();
	}
}
