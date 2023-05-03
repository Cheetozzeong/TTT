package com.a804.tictactoc.ttt.response;

import com.a804.tictactoc.ttt.db.entity.Tickle;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

/**
 * 유저 모델 정의.
 */
@Schema(name="TickleCountRes")
//@Getter
//@Setter
//@AllArgsConstructor
//@NoArgsConstructor
//@ToString
public interface TickleCountRes {
	long getCategoryId();
	String getCategoryName();
	int getCount();
}
