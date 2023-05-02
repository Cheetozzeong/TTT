package com.a804.tictactoc.ttt.db.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * 유저 모델 정의.
 */
@Entity
@Table(name="habit")
@DynamicInsert
@DynamicUpdate
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Habit {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Schema(hidden = true)
    long id;

	@Schema(name = "어떤 유저의 습관인지", example = "1", defaultValue = "1", hidden = true)
	@Column(name="user_id", updatable = false)
	long userId;

//	@Schema(name = "어떤 카테고리의 습관인지", example = "1", defaultValue = "1")
//	@Column(name="category_id")
//	int categoryId;

	@Schema(name = "습관의 이름", example = "물마시기", defaultValue = "물마시기")
	@Column(name="name")
	String name;

	@Schema(name = "습관을 대표하는 이모지 이름", example="happy", defaultValue = "happy")
	@Column(name="emoji")
    String emoji;

	@Schema(name = "알람 시작 시간 HHmm", example = "0930", defaultValue = "0930")
	@Column(name="start_time")
	String startTime;

	@Schema(name = "알람 종료 시간 HHmm", example = "1930", defaultValue = "1930")
	@Column(name="end_time")
	String endTime;


	@Schema(name = "알람이 울리는 주기 HHmm", example = "0030", defaultValue = "0030")
	@Column(name="term")
	String term;

	@Schema(name = "알람이 울리는 요일 7비트", example = "1011011", defaultValue = "1011011")
	@Column(name="repeat_day")
	String repeatDay;

	@Schema(hidden = true)
	@Column(name="delete_yn")
	int deleteYn;

	@Schema(hidden = true)
	@Column(name="created_date", updatable = false, insertable = false)
	String createdDate;

	@Schema(hidden = true)
	@Column(name="modified_date", updatable = false, insertable = false)
	String modifiedDate;

	@OneToMany(mappedBy = "habit", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
	List<Tickle> tickles = new ArrayList<>();

	@OneToMany(mappedBy = "habit", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
	List<Alarm> alarms  = new ArrayList<>();

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "category_id")
	Category category;

	public Habit(long id){
		this.id = id;
	}
}
