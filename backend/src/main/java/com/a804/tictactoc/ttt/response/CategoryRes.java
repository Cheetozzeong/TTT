package com.a804.tictactoc.ttt.response;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

import javax.persistence.*;

/**
 * 유저 모델 정의.
 */
@Schema(name="category")
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class CategoryRes {
	@Schema(hidden = true)
    int id;
	
	@Schema(name = "카테고리의 이름", example = "운동", defaultValue = "운동")
	String name;
}
