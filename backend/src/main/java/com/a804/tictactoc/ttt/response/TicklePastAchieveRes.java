package com.a804.tictactoc.ttt.response;

import io.swagger.v3.oas.annotations.media.Schema;

/**
 * 유저 모델 정의.
 */
@Schema(name="TicklePastAchieveRes")
//@Getter
//@Setter
//@AllArgsConstructor
//@NoArgsConstructor
//@ToString
public interface TicklePastAchieveRes {
	int getCategoryId();

	String getHabitName();

	String getExecutionTime();

	String getEmoji();
}
