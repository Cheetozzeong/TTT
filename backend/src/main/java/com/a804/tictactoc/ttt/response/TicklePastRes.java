package com.a804.tictactoc.ttt.response;

import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

/**
 * 유저 모델 정의.
 */
@Schema(name="TicklePastRes")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class TicklePastRes implements Comparable<TicklePastRes>{
	String habitName;

	String executionTime;

	String emoji;

	@Override
	public int compareTo(TicklePastRes o) {
		return Integer.parseInt(this.executionTime) - Integer.parseInt(o.executionTime);
	}
}
