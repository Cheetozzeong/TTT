package com.a804.tictactoc.ttt.db.entity;

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
@Table(name="category")
@DynamicInsert
@DynamicUpdate
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Category {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Schema(hidden = true)
    int id;
	
	@Schema(name = "카테고리의 이름", example = "운동", defaultValue = "운동")
	@Column(name="name")
	String name;

	@Schema(hidden = true)
	@Column(name="delete_yn")
	int deleteYn;

	@Schema(hidden = true)
	@Column(name="created_date", updatable = false, insertable = false)
	String createdDate;

	@Schema(hidden = true)
	@Column(name="modified_date", updatable = false, insertable = false)
	String modifiedDate;

	@OneToMany(mappedBy = "categoryId", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
	List<Habit> habits = new ArrayList<>();
}
