CREATE TABLE user (
    id    Integer UNSIGNED primary key NOT NULL AUTO_INCREMENT,
    sleep_start_time    CHAR(4)    NOT NULL    DEFAULT '0000'    COMMENT 'HHmm',
    sleep_end_time    CHAR(4)    NOT NULL    DEFAULT '0000'    COMMENT 'HHmm',
    delete_yn    BOOLEAN    NOT NULL    DEFAULT FALSE,
    created_date    DATETIME    NOT NULL DEFAULT NOW(),
    modified_date    DATETIME    NOT NULL DEFAULT NOW() ON UPDATE NOW(),
    uid 	varchar(255) 	not null
);

CREATE TABLE category (
    id    TINYINT    NOT NULL PRIMARY KEY,
    name    VARCHAR(16)    NOT NULL,
    delete_yn    BOOLEAN    NOT NULL    DEFAULT FALSE,
    created_date    DATETIME    NOT NULL    DEFAULT NOW(),
    modified_date    DATETIME    NOT NULL    DEFAULT NOW() ON UPDATE NOW()
);

CREATE TABLE habit (
    id    INTEGER UNSIGNED    NOT NULL AUTO_INCREMENT PRIMARY KEY,
    user_id    INTEGER UNSIGNED    NOT NULL,
    category_id    TINYINT    NOT NULL,
    name    VARCHAR(16)    NOT NULL,
    emoji    VARCHAR(16)    NOT NULL,
    start_time    CHAR(4)    NOT NULL    COMMENT 'HHmm',
    end_time    CHAR(4)    NOT NULL    COMMENT 'HHmm',
    term    CHAR(4)    NOT NULL    COMMENT 'HHmm',
    repeat_day    VARCHAR(7)    NOT NULL,
    delete_yn    BOOLEAN    NOT NULL    DEFAULT FALSE,
    created_date    DATETIME    NOT NULL    DEFAULT NOW(),
    modified_date    DATETIME    NOT NULL    DEFAULT NOW()    ON UPDATE NOW(),
    CONSTRAINT fk_user_habit FOREIGN KEY (user_id) REFERENCES user (id) ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT fk_category_habit FOREIGN KEY (category_id) REFERENCES category (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE tickle (
    id    INTEGER UNSIGNED 	NOT NULL AUTO_INCREMENT PRIMARY KEY,
    habit_id    INTEGER UNSIGNED    NOT NULL,
    execution_day VARCHAR(8) NOT NULL,
    execution_time VARCHAR(4) NOT NULL,
    created_date    DATETIME    NOT NULL    DEFAULT NOW(),
    UNIQUE KEY uk_tickle (habit_id, execution_day, execution_time),
    CONSTRAINT fk_habit_tickle FOREIGN KEY (habit_id) REFERENCES habit (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE alarm (
    id    INTEGER UNSIGNED    NOT NULL AUTO_INCREMENT PRIMARY KEY,
    habit_id    INTEGER UNSIGNED    NOT NULL,
    alarm_time    CHAR(4)    NOT NULL    COMMENT 'HHmm',
    CONSTRAINT fk_habit_alarm FOREIGN KEY (habit_id) REFERENCES habit (id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `api_test` (
  `at_id` int NOT NULL AUTO_INCREMENT,
  `at_title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`at_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `config` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `value` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `push_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `body` varchar(255) DEFAULT NULL,
  `created_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `push_token` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;









