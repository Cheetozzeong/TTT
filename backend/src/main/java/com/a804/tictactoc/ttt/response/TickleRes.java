package com.a804.tictactoc.ttt.response;

import com.a804.tictactoc.ttt.db.entity.Tickle;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;

/**
 * 유저 모델 정의.
 */
@Schema(name="TickleRes")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class TickleRes {
	@Schema(hidden = true)
    long id;
	
	@Schema(description = "어떤 습관의 티끌인지", example = "1", defaultValue = "1")
	long habitId;

	@Schema(name = "이 티끌이 만들어진 날짜", example = "20230427", defaultValue = "YYYYMMDD")
	String executionDay;

	@Schema(name = "이 티끌이 만들어진 시간", example = "0930", defaultValue = "HHmm")
	String executionTime;

	@Builder
	public TickleRes(Tickle tickle){
		this.id = tickle.getId();
		this.habitId = tickle.getHabit().getId();
		this.executionDay = tickle.getExecutionDay();
		this.executionTime = tickle.getExecutionTime();
	}
}
