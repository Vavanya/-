CREATE TABLE "departmant" (
  "id" int PRIMARY KEY NOT NULL,
  "name" varchar NOT NULL
);

CREATE TABLE "direction_of_training" (
  "id" int PRIMARY KEY NOT NULL,
  "name_of_training" varchar
);

CREATE TABLE "all_courses" (
  "id" int PRIMARY KEY NOT NULL,
  "course" int,
  "name_groups" varchar NOT NULL
);

CREATE TABLE "group" (
  "id" int PRIMARY KEY NOT NULL,
  "name" varchar,
  "start" datatime NOT NULL,
  "finish" datatime,
  "form_training" varchar,
  "departmant" int NOT NULL,
  "enrollment" datatime
);

CREATE TABLE "group_list" (
  "id" int PRIMARY KEY NOT NULL,
  "full_name_person" varchar NOT NULL,
  "id_number" int
);

CREATE TABLE "person" (
  "id" int PRIMARY KEY NOT NULL,
  "first_name" varchar NOT NULL,
  "last_name" varchar NOT NULL,
  "midle_name" varchar,
  "birthday" datatime,
  "enrollment" datatime NOT NULL,
  "post" varchar NOT NULL DEFAULT 'now()'
);

CREATE TABLE "inf_person" (
  "id_number" int NOT NULL DEFAULT 'now()',
  "login" varchar UNIQUE NOT NULL,
  "password" varchar UNIQUE NOT NULL
);

CREATE TABLE "subjects" (
  "id" int NOT NULL,
  "name_of_subject" varchar NOT NULL
);

CREATE TABLE "inf_subject" (
  "id" int PRIMARY KEY NOT NULL,
  "academ_plan" varchar NOT NULL,
  "study_time" int,
  "subject_type" varchar NOT NULL
);

CREATE TABLE "subject_type" (
  "id" int PRIMARY KEY NOT NULL,
  "subject_type" varchar
);

CREATE TABLE "academ_plan" (
  "id" int PRIMARY KEY NOT NULL,
  "theme" varchar,
  "hour_on_theme" time,
  "exems_or_offset" varchar,
  "max_themes_mark" int
);

CREATE TABLE "assessments_card_student" (
  "id" int PRIMARY KEY NOT NULL,
  "name_subject" varchar NOT NULL,
  "all_mark_for_subject" int NOT NULL DEFAULT 'now',
  "exams_or_offset" varchar,
  "mark_exams_or_offset" int DEFAULT 'now'
);

CREATE TABLE "inf_train_student" (
  "id" int PRIMARY KEY NOT NULL,
  "lecture_work_mark" int,
  "practick_work_mark" int,
  "laboratory_work_mark" int,
  "skipping_classes" int,
  "teacher" varchar NOT NULL
);

CREATE TABLE "contol_student" (
  "id" int PRIMARY KEY NOT NULL,
  "name_theme" varchar,
  "mark_test" int,
  "data_write_test" datatime,
  "teacher" varchar
);

ALTER TABLE "direction_of_training" ADD FOREIGN KEY ("id") REFERENCES "departmant" ("name");

ALTER TABLE "all_courses" ADD FOREIGN KEY ("id") REFERENCES "direction_of_training" ("id");

ALTER TABLE "all_courses" ADD FOREIGN KEY ("name_groups") REFERENCES "group" ("id");

ALTER TABLE "group" ADD FOREIGN KEY ("id") REFERENCES "group_list" ("id");

ALTER TABLE "group" ADD FOREIGN KEY ("departmant") REFERENCES "departmant" ("name");

ALTER TABLE "group_list" ADD FOREIGN KEY ("id_number") REFERENCES "person" ("id");

ALTER TABLE "inf_person" ADD FOREIGN KEY ("id_number") REFERENCES "person" ("id");

ALTER TABLE "subjects" ADD FOREIGN KEY ("name_of_subject") REFERENCES "direction_of_training" ("name_of_training");

ALTER TABLE "inf_subject" ADD FOREIGN KEY ("id") REFERENCES "subjects" ("id");

ALTER TABLE "subject_type" ADD FOREIGN KEY ("id") REFERENCES "inf_subject" ("subject_type");

ALTER TABLE "assessments_card_student" ADD FOREIGN KEY ("id") REFERENCES "person" ("id");

ALTER TABLE "contol_student" ADD FOREIGN KEY ("id") REFERENCES "assessments_card_student" ("all_mark_for_subject");

ALTER TABLE "academ_plan" ADD FOREIGN KEY ("id") REFERENCES "inf_subject" ("academ_plan");

ALTER TABLE "assessments_card_student" ADD FOREIGN KEY ("name_subject") REFERENCES "inf_train_student" ("id");

CREATE UNIQUE INDEX ON "departmant" ("name");

CREATE UNIQUE INDEX ON "direction_of_training" ("name_of_training");

CREATE UNIQUE INDEX ON "all_courses" ("course", "name_groups");

CREATE UNIQUE INDEX ON "group" ("departmant", "name");

CREATE UNIQUE INDEX ON "group_list" ("id_number");

CREATE UNIQUE INDEX ON "inf_person" ("id_number", "login", "password");

CREATE INDEX ON "subjects" ("name_of_subject");
