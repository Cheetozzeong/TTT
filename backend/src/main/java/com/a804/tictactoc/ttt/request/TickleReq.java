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
	@Schema(name = "habitId", description = "어떤 습관의 티끌인지", example = "1")
	long habitId;

	@Schema(name = "executionDay", example = "20230427", defaultValue = "YYYYMMDD")
	String executionDay;

	@Schema(name = "executionTime", example = "0930", defaultValue = "HHmm")
	String executionTime;

	public Tickle toEntity() {
		return Tickle.builder()
				.habitId(habitId)
				.executionDay(executionDay)
				.executionTime(executionTime)
				.build();
	}
}
