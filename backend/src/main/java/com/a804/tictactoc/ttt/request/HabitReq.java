package com.a804.tictactoc.ttt.request;

import com.a804.tictactoc.ttt.db.entity.Habit;
import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.links.LinkParameter;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

import javax.persistence.*;

/**
 * 유저 모델 정의.
 */
@Schema(name="HabitReq")
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class HabitReq {
	@Schema(example = "0", defaultValue = "0")
    long id;//생성 req면 0으로 올거고

//	@Schema(name = "어떤 유저의 습관인지", example = "1", defaultValue = "1", hidden = true, required = false)
//	@Parameter(hidden = true)
//	long userId;

	@Schema(name = "categoryId", description = "어떤 카테고리의 습관인지", example = "1", defaultValue = "1")
	int categoryId;

	@Schema(name = "name", description = "습관의 이름", example = "물마시기", defaultValue = "물마시기")
	String name;

	@Schema(name = "emoji", description = "습관을 대표하는 이모지 이름", example="happy", defaultValue = "happy")
    String emoji;

	@Schema(name = "startTime", description = "알람 시작 시간 HHmm", example = "0930", defaultValue = "0930")
	String startTime;

	@Schema(name = "endTime", description = "알람 종료 시간 HHmm", example = "1930", defaultValue = "1930")
	String endTime;

	@Schema(name = "term", description = "알람이 울리는 주기 HHmm", example = "0030", defaultValue = "0030")
	String term;

	@Schema(name = "repeatDay", description = "알람이 울리는 요일 7비트", example = "1011011", defaultValue = "1011011")
	String repeatDay;

	public Habit toEntity() {
		return Habit.builder()
				.id(id)
				.categoryId(categoryId)
				.name(name)
				.emoji(emoji)
				.startTime(startTime)
				.endTime(endTime)
				.term(term)
				.repeatDay(repeatDay)
				.build();
	}
}