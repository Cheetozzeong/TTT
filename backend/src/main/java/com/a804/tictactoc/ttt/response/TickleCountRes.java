package com.a804.tictactoc.ttt.response;

import com.a804.tictactoc.ttt.db.entity.Tickle;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

/**
 * 유저 모델 정의.
 */
@Schema(name="TickleRes")
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class TickleCountRes {
	@Schema(description = "어떤 카테고리인지", example = "1", defaultValue = "1")
	long categoryId;

	@Schema(description = "해당 카테고리 티끌들의 숫자")
	int count;
}
