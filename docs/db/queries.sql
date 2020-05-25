CREATE TABLE `departmant` (
  `id` int PRIMARY KEY NOT NULL,
  `name` varchar(255) NOT NULL
);

CREATE TABLE `direction_of_training` (
  `id` int PRIMARY KEY NOT NULL,
  `name_of_training` varchar(255)
);

CREATE TABLE `all_courses` (
  `id` int PRIMARY KEY NOT NULL,
  `course` int,
  `name_groups` varchar(255) NOT NULL
);

CREATE TABLE `group` (
  `id` int PRIMARY KEY NOT NULL,
  `name` varchar(255),
  `start` datatime NOT NULL,
  `finish` datatime,
  `form_training` varchar(255),
  `departmant` int NOT NULL,
  `enrollment` datatime
);

CREATE TABLE `group_list` (
  `id` int PRIMARY KEY NOT NULL,
  `full_name_person` varchar(255) NOT NULL,
  `id_number` int
);

CREATE TABLE `person` (
  `id` int PRIMARY KEY NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `midle_name` varchar(255),
  `birthday` datatime,
  `enrollment` datatime NOT NULL,
  `post` varchar(255) NOT NULL DEFAULT "now()"
);

CREATE TABLE `inf_person` (
  `id_number` int NOT NULL DEFAULT "now()",
  `login` varchar(255) UNIQUE NOT NULL,
  `password` varchar(255) UNIQUE NOT NULL
);

CREATE TABLE `subjects` (
  `id` int NOT NULL,
  `name_of_subject` varchar(255) NOT NULL
);

CREATE TABLE `inf_subject` (
  `id` int PRIMARY KEY NOT NULL,
  `academ_plan` varchar(255) NOT NULL,
  `study_time` int,
  `subject_type` varchar(255) NOT NULL
);

CREATE TABLE `subject_type` (
  `id` int PRIMARY KEY NOT NULL,
  `subject_type` varchar(255)
);

CREATE TABLE `academ_plan` (
  `id` int PRIMARY KEY NOT NULL,
  `theme` varchar(255),
  `hour_on_theme` time,
  `exems_or_offset` varchar(255),
  `max_themes_mark` int
);

CREATE TABLE `assessments_card_student` (
  `id` int PRIMARY KEY NOT NULL,
  `name_subject` varchar(255) NOT NULL,
  `all_mark_for_subject` int NOT NULL DEFAULT "now",
  `exams_or_offset` varchar(255),
  `mark_exams_or_offset` int DEFAULT "now"
);

CREATE TABLE `inf_train_student` (
  `id` int PRIMARY KEY NOT NULL,
  `lecture_work_mark` int,
  `practick_work_mark` int,
  `laboratory_work_mark` int,
  `skipping_classes` int,
  `teacher` varchar(255) NOT NULL
);

CREATE TABLE `marks_student` (
  `id` int PRIMARY KEY NOT NULL,
  `work_student_mark` int,
  `date_mark` datatime
);

CREATE TABLE `contol_student` (
  `id` int PRIMARY KEY NOT NULL,
  `name_theme` varchar(255),
  `mark_test` int,
  `data_write_test` datatime,
  `teacher` varchar(255)
);

ALTER TABLE `direction_of_training` ADD FOREIGN KEY (`id`) REFERENCES `departmant` (`name`);

ALTER TABLE `all_courses` ADD FOREIGN KEY (`id`) REFERENCES `direction_of_training` (`id`);

ALTER TABLE `all_courses` ADD FOREIGN KEY (`name_groups`) REFERENCES `group` (`id`);

ALTER TABLE `group` ADD FOREIGN KEY (`id`) REFERENCES `group_list` (`id`);

ALTER TABLE `group` ADD FOREIGN KEY (`departmant`) REFERENCES `departmant` (`name`);

ALTER TABLE `group_list` ADD FOREIGN KEY (`id_number`) REFERENCES `person` (`id`);

ALTER TABLE `inf_person` ADD FOREIGN KEY (`id_number`) REFERENCES `person` (`id`);

ALTER TABLE `subjects` ADD FOREIGN KEY (`name_of_subject`) REFERENCES `direction_of_training` (`name_of_training`);

ALTER TABLE `inf_subject` ADD FOREIGN KEY (`id`) REFERENCES `subjects` (`id`);

ALTER TABLE `subject_type` ADD FOREIGN KEY (`id`) REFERENCES `inf_subject` (`subject_type`);

ALTER TABLE `assessments_card_student` ADD FOREIGN KEY (`id`) REFERENCES `person` (`id`);

ALTER TABLE `contol_student` ADD FOREIGN KEY (`id`) REFERENCES `assessments_card_student` (`all_mark_for_subject`);

ALTER TABLE `academ_plan` ADD FOREIGN KEY (`id`) REFERENCES `inf_subject` (`academ_plan`);

ALTER TABLE `assessments_card_student` ADD FOREIGN KEY (`name_subject`) REFERENCES `inf_train_student` (`id`);

CREATE UNIQUE INDEX `departmant_index_0` ON `departmant` (`name`);

CREATE UNIQUE INDEX `direction_of_training_index_1` ON `direction_of_training` (`name_of_training`);

CREATE UNIQUE INDEX `all_courses_index_2` ON `all_courses` (`course`, `name_groups`);

CREATE UNIQUE INDEX `group_index_3` ON `group` (`departmant`, `name`);

CREATE UNIQUE INDEX `group_list_index_4` ON `group_list` (`id_number`);

CREATE UNIQUE INDEX `inf_person_index_5` ON `inf_person` (`id_number`, `login`, `password`);

CREATE INDEX `subjects_index_6` ON `subjects` (`name_of_subject`);
