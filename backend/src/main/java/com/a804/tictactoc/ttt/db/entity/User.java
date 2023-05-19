package com.a804.tictactoc.ttt.db.entity;

import javax.persistence.*;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import java.util.ArrayList;
import java.util.List;

/**
 * 유저 모델 정의.
 */
@Entity
@Table(name="user")
@DynamicInsert
@DynamicUpdate
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class User{

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Schema(hidden = true)
	long id;

	@Schema(name = "유저의 uid", example = "fk9AqAXtRjXyBJIPD6wFDqcXlHs1", defaultValue = "fk9AqAXtRjXyBJIPD6wFDqcXlHs1")
	@Column(name="uid")
	String uid;

	@Schema(name = "방해금지 시작 시간 HHmm", example = "2330", defaultValue = "2330")
	@Column(name="sleep_start_time")
	String sleepStartTime;

	@Schema(name = "방해금지 끝 시간 HHmm", example = "0730", defaultValue = "0730")
	@Column(name="sleep_end_time")
	String sleepEndTime;

	@Schema(hidden = true)
	@Column(name="delete_yn")
	int deleteYn;

	@Schema(hidden = true)
	@Column(name="phone_device_token")
	String phoneDeviceToken;

	@Schema(hidden = true)
	@Column(name="watch_device_token")
	String watchDeviceToken;

	@Schema(hidden = true)
	@Column(name="created_date", updatable = false, insertable = false)
	String createdDate;

	@Schema(hidden = true)
	@Column(name="modified_date", updatable = false, insertable = false)
	String modifiedDate;

	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
	List<Habit> habits = new ArrayList<>();
}