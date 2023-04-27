package com.a804.tictactoc.ttt.request;

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
	@Schema(name = "habitId", description = "어떤 습관의 티끌인지", example = "1", defaultValue = "1")
	long habitId;
}
