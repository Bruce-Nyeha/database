-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema university_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema university_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `university_db` ;

-- -----------------------------------------------------
-- Table `university_db`.`college`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_db`.`college` (
  `college_id` INT NOT NULL AUTO_INCREMENT,
  `college_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `university_db`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_db`.`department` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `college_id` INT NULL DEFAULT NULL,
  `department_name` VARCHAR(100) NULL DEFAULT NULL,
  `department_code` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`department_id`),
  INDEX `college_id` (`college_id` ASC) VISIBLE,
  CONSTRAINT `department_ibfk_1`
    FOREIGN KEY (`college_id`)
    REFERENCES `university_db`.`college` (`college_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `university_db`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_db`.`course` (
  `course_id` INT NOT NULL AUTO_INCREMENT,
  `department_id` INT NULL DEFAULT NULL,
  `course_num` VARCHAR(10) NOT NULL,
  `course_title` VARCHAR(100) NULL DEFAULT NULL,
  `credits` INT NULL DEFAULT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `department_id` (`department_id` ASC) VISIBLE,
  CONSTRAINT `course_ibfk_1`
    FOREIGN KEY (`department_id`)
    REFERENCES `university_db`.`department` (`department_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `university_db`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_db`.`student` (
  `student_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NULL DEFAULT NULL,
  `last_name` VARCHAR(50) NULL DEFAULT NULL,
  `gender` ENUM('M', 'F') NULL DEFAULT NULL,
  `city` VARCHAR(50) NULL DEFAULT NULL,
  `state` VARCHAR(2) NULL DEFAULT NULL,
  `birthdate` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `university_db`.`faculty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_db`.`faculty` (
  `faculty_id` INT NOT NULL AUTO_INCREMENT,
  `faculty_fname` VARCHAR(50) NULL DEFAULT NULL,
  `faculty_lname` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`faculty_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `university_db`.`section`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_db`.`section` (
  `section_id` INT NOT NULL AUTO_INCREMENT,
  `course_id` INT NULL DEFAULT NULL,
  `faculty_id` INT NULL DEFAULT NULL,
  `year` INT NULL DEFAULT NULL,
  `term` VARCHAR(10) NULL DEFAULT NULL,
  `capacity` INT NULL DEFAULT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `course_id` (`course_id` ASC) VISIBLE,
  INDEX `faculty_id` (`faculty_id` ASC) VISIBLE,
  CONSTRAINT `section_ibfk_1`
    FOREIGN KEY (`course_id`)
    REFERENCES `university_db`.`course` (`course_id`),
  CONSTRAINT `section_ibfk_2`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `university_db`.`faculty` (`faculty_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `university_db`.`enrollment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university_db`.`enrollment` (
  `enrollment_id` INT NOT NULL AUTO_INCREMENT,
  `student_id` INT NULL DEFAULT NULL,
  `section_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`enrollment_id`),
  INDEX `student_id` (`student_id` ASC) VISIBLE,
  INDEX `section_id` (`section_id` ASC) VISIBLE,
  CONSTRAINT `enrollment_ibfk_1`
    FOREIGN KEY (`student_id`)
    REFERENCES `university_db`.`student` (`student_id`),
  CONSTRAINT `enrollment_ibfk_2`
    FOREIGN KEY (`section_id`)
    REFERENCES `university_db`.`section` (`section_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 29
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
