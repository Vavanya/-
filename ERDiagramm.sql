CREATE TABLE `course` (
  `id` int PRIMARY KEY NOT NULL,
  `name` varchar(255),
  `start` datatime NOT NULL,
  `finish` datatime,
  `control` varchar(255),
  `departmant` int
);

CREATE TABLE `cohort` (
  `id` int PRIMARY KEY NOT NULL,
  `name` varchar(255) NOT NULL,
  `part` varchar(255) NOT NULL,
  `created` datatime NOT NULL DEFAULT "now",
  `assessments_cohort` int NOT NULL
);

CREATE TABLE `students` (
  `id` int PRIMARY KEY NOT NULL,
  `name_student` int NOT NULL
);

CREATE TABLE `cohorts_enrollments` (
  `id` int PRIMARY KEY NOT NULL,
  `cohort` int NOT NULL,
  `person` int NOT NULL,
  `enrollment` datatime NOT NULL DEFAULT "now"
);

CREATE TABLE `module` (
  `id` int PRIMARY KEY NOT NULL,
  `course` int,
  `name` varchar(255) NOT NULL
);

CREATE TABLE `subject_type` (
  `id` int PRIMARY KEY NOT NULL,
  `tipe` varchar(255) UNIQUE NOT NULL
);

CREATE TABLE `subject` (
  `id` int PRIMARY KEY NOT NULL,
  `module` int,
  `tipe_subject` int NOT NULL,
  `name` varchar(255) NOT NULL
);

CREATE TABLE `attenders` (
  `id` int PRIMARY KEY NOT NULL,
  `subject` int NOT NULL,
  `student` int NOT NULL,
  `status` varchar(255) NOT NULL
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

CREATE TABLE `departmant` (
  `id` int PRIMARY KEY NOT NULL,
  `parent` int,
  `name` varchar(255) NOT NULL
);

CREATE TABLE `inf_person` (
  `education` varchar(255) NOT NULL DEFAULT "now()",
  `ragistration` varchar(255) NOT NULL,
  `passport` int NOT NULL DEFAULT "now()"
);

CREATE TABLE `assessments_card_student` (
  `id` int PRIMARY KEY NOT NULL,
  `name_student` int NOT NULL,
  `name_training` varchar(255) NOT NULL,
  `exams_or_offset` varchar(255),
  `marks` int NOT NULL
);

CREATE TABLE `marks` (
  `id` int PRIMARY KEY NOT NULL,
  `work_lections` int NOT NULL DEFAULT "now()",
  `work_praktik` int NOT NULL DEFAULT "now()",
  `test_control` int NOT NULL DEFAULT "now()",
  `skipping_classes` int,
  `teacher` varchar(255) NOT NULL
);

ALTER TABLE `cohort` ADD FOREIGN KEY (`assessments_cohort`) REFERENCES `students` (`id`);

ALTER TABLE `students` ADD FOREIGN KEY (`name_student`) REFERENCES `person` (`id`);

ALTER TABLE `cohorts_enrollments` ADD FOREIGN KEY (`cohort`) REFERENCES `cohort` (`id`);

ALTER TABLE `module` ADD FOREIGN KEY (`course`) REFERENCES `course` (`id`);

ALTER TABLE `subject` ADD FOREIGN KEY (`module`) REFERENCES `module` (`id`);

ALTER TABLE `subject` ADD FOREIGN KEY (`tipe_subject`) REFERENCES `subject_type` (`id`);

ALTER TABLE `attenders` ADD FOREIGN KEY (`subject`) REFERENCES `subject` (`id`);

ALTER TABLE `attenders` ADD FOREIGN KEY (`student`) REFERENCES `cohorts_enrollments` (`id`);

ALTER TABLE `person` ADD FOREIGN KEY (`post`) REFERENCES `assessments_card_student` (`id`);

ALTER TABLE `departmant` ADD FOREIGN KEY (`parent`) REFERENCES `departmant` (`id`);

ALTER TABLE `inf_person` ADD FOREIGN KEY (`passport`) REFERENCES `person` (`id`);

ALTER TABLE `assessments_card_student` ADD FOREIGN KEY (`name_training`) REFERENCES `attenders` (`subject`);

ALTER TABLE `assessments_card_student` ADD FOREIGN KEY (`marks`) REFERENCES `marks` (`id`);

CREATE UNIQUE INDEX `course_index_0` ON `course` (`departmant`, `name`);

CREATE UNIQUE INDEX `cohort_index_1` ON `cohort` (`part`, `name`, `created`);

CREATE UNIQUE INDEX `cohorts_enrollments_index_2` ON `cohorts_enrollments` (`cohort`, `person`);

CREATE UNIQUE INDEX `module_index_3` ON `module` (`course`, `name`);

CREATE UNIQUE INDEX `subject_index_4` ON `subject` (`module`, `name`);

CREATE UNIQUE INDEX `attenders_index_5` ON `attenders` (`subject`, `student`);

CREATE UNIQUE INDEX `departmant_index_6` ON `departmant` (`parent`, `name`);

CREATE UNIQUE INDEX `inf_person_index_7` ON `inf_person` (`passport`);
