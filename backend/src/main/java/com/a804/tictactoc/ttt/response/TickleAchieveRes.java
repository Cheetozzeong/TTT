package com.a804.tictactoc.ttt.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

/**
 * 유저 모델 정의.
 */
@Schema(name="TickleAchieveRes")
//@Getter
//@Setter
//@AllArgsConstructor
//@NoArgsConstructor
//@ToString
public interface TickleAchieveRes {
	String getAlarmTime();
	String getExecutionTime();
}
