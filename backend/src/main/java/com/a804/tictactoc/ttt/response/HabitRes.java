package com.a804.tictactoc.ttt.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

import javax.persistence.*;

/**
 * 유저 모델 정의.
 */
@Schema(name="HabitRes")
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class HabitRes {

	@Schema(hidden = true)
    long id;

	@Schema(name = "어떤 유저의 습관인지", example = "1", defaultValue = "1", hidden = true)
	long userId;

	@Schema(name = "어떤 카테고리의 습관인지", example = "1", defaultValue = "1")
	long categoryId;

	@Schema(name = "습관의 이름", example = "물마시기", defaultValue = "물마시기")
	String name;

	@Schema(name = "습관을 대표하는 이모지 이름", example="happy", defaultValue = "happy")
    String emoji;

	@Schema(name = "알람 시작 시간 HHmm", example = "0930", defaultValue = "0930")
	String startTime;

	@Schema(name = "알람 종료 시간 HHmm", example = "1930", defaultValue = "1930")
	String endTime;


	@Schema(name = "알람이 울리는 주기 HHmm", example = "0030", defaultValue = "0030")
	String term;

	@Schema(name = "알람이 울리는 요일 7비트", example = "1011011", defaultValue = "1011011")
	String repeatDay;

}
