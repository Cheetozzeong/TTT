package com.a804.tictactoc.ttt.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

/**
 * 유저 모델 정의.
 */
@Schema(name="TickleCategoryRes")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class TickleTodayRes implements Comparable<TickleTodayRes>{
	@Schema(description = "달성 여부", example = "false", defaultValue = "false")
	boolean achieved = false;

	String habitName;

	String executionTime;

	String emoji;

	@Override
	public int compareTo(TickleTodayRes o) {
		return Integer.parseInt(this.executionTime) - Integer.parseInt(o.executionTime);
	}
}
