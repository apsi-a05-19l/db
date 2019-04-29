-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema apsi
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema apsi
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `apsi` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema test_schema
-- -----------------------------------------------------
USE `apsi` ;

-- -----------------------------------------------------
-- Table `apsi`.`ActivityTag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apsi`.`ActivityTag` (
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apsi`.`RoleInClub`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apsi`.`RoleInClub` (
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apsi`.`Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apsi`.`Person` (
  `idPerson` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `phone_number` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `date_from` DATE NULL,
  `RoleInClub_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPerson`),
  INDEX `idx_first_name` (`first_name` ASC),
  INDEX `idx_last_name` (`last_name` ASC),
  INDEX `idx_first_name_last_name` (`first_name` ASC, `last_name` ASC),
  INDEX `fk_Person_RoleInClub1_idx` (`RoleInClub_name` ASC),
  CONSTRAINT `fk_Person_RoleInClub1`
    FOREIGN KEY (`RoleInClub_name`)
    REFERENCES `apsi`.`RoleInClub` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apsi`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apsi`.`User` (
  `login` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `Person_idPerson` INT NOT NULL,
  UNIQUE INDEX `login_UNIQUE` (`login` ASC),
  INDEX `idx_login` USING BTREE (`login`) KEY_BLOCK_SIZE = 50,
  INDEX `idx_login_password` USING BTREE (`login`, `password`),
  PRIMARY KEY (`Person_idPerson`),
  CONSTRAINT `fk_User_Person1`
    FOREIGN KEY (`Person_idPerson`)
    REFERENCES `apsi`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apsi`.`PermissionInSystem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apsi`.`PermissionInSystem` (
  `Permission` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Permission`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apsi`.`Project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apsi`.`Project` (
  `idProject` INT NOT NULL AUTO_INCREMENT,
  `date_from` DATE NULL,
  `name` VARCHAR(45) NULL,
  `project_leader` INT NOT NULL,
  PRIMARY KEY (`idProject`),
  INDEX `fk_Project_Person1_idx` (`project_leader` ASC),
  INDEX `idx_name` (`name` ASC),
  CONSTRAINT `fk_Project_Person1`
    FOREIGN KEY (`project_leader`)
    REFERENCES `apsi`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apsi`.`Report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apsi`.`Report` (
  `idReport` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(1000) NULL,
  `date` DATE NULL,
  `Project_idProject` INT NOT NULL,
  PRIMARY KEY (`idReport`, `Project_idProject`),
  INDEX `fk_Report_Project1_idx` (`Project_idProject` ASC),
  CONSTRAINT `fk_Report_Project1`
    FOREIGN KEY (`Project_idProject`)
    REFERENCES `apsi`.`Project` (`idProject`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apsi`.`Persons_Projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apsi`.`Persons_Projects` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Person_idPerson` INT NOT NULL,
  `Project_idProject` INT NOT NULL,
  `date_from` DATE NULL,
  INDEX `fk_PersonsProjects_Project1_idx` (`Project_idProject` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_Persons_Projects_Person1_idx` (`Person_idPerson` ASC),
  CONSTRAINT `fk_PersonsProjects_Project1`
    FOREIGN KEY (`Project_idProject`)
    REFERENCES `apsi`.`Project` (`idProject`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Persons_Projects_Person1`
    FOREIGN KEY (`Person_idPerson`)
    REFERENCES `apsi`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apsi`.`Topic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apsi`.`Topic` (
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apsi`.`Post`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apsi`.`Post` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  `author` INT NOT NULL,
  `Topic_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_title` (`title` ASC),
  INDEX `fk_author_idx` (`author` ASC),
  INDEX `fk_Post_Topic1_idx` (`Topic_name` ASC),
  CONSTRAINT `fk_Post_Person1`
    FOREIGN KEY (`author`)
    REFERENCES `apsi`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Post_Topic1`
    FOREIGN KEY (`Topic_name`)
    REFERENCES `apsi`.`Topic` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apsi`.`PostTag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apsi`.`PostTag` (
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apsi`.`Part`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apsi`.`Part` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `header` VARCHAR(45) NULL,
  `contents` VARCHAR(2000) NULL,
  `Post_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Post_id`),
  INDEX `fk_Content_Post1_idx` (`Post_id` ASC),
  CONSTRAINT `fk_Content_Post1`
    FOREIGN KEY (`Post_id`)
    REFERENCES `apsi`.`Post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apsi`.`Link`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apsi`.`Link` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_number` INT NULL,
  `source` VARCHAR(200) NULL,
  `Part_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Link_Content1_idx` (`Part_id` ASC),
  CONSTRAINT `fk_Link_Content1`
    FOREIGN KEY (`Part_id`)
    REFERENCES `apsi`.`Part` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apsi`.`PostTags_Posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apsi`.`PostTags_Posts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Post_id` INT NOT NULL,
  `PostTag_name` VARCHAR(45) NOT NULL,
  INDEX `fk_PostTagsPosts_Post1_idx` (`Post_id` ASC),
  INDEX `fk_PostTagsPosts_PostTag1_idx` (`PostTag_name` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_PostTagsPosts_Post1`
    FOREIGN KEY (`Post_id`)
    REFERENCES `apsi`.`Post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PostTagsPosts_PostTag1`
    FOREIGN KEY (`PostTag_name`)
    REFERENCES `apsi`.`PostTag` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apsi`.`Activity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apsi`.`Activity` (
  `idActivity` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NULL,
  `points` INT NULL,
  `ActivityTag_name` VARCHAR(45) NOT NULL,
  `Person_idPerson` INT NOT NULL,
  PRIMARY KEY (`idActivity`),
  INDEX `fk_Activity_ActivityTag1_idx` (`ActivityTag_name` ASC),
  INDEX `idx_date` (`date` ASC),
  INDEX `fk_Activity_Person1_idx` (`Person_idPerson` ASC),
  CONSTRAINT `fk_Activity_ActivityTag1`
    FOREIGN KEY (`ActivityTag_name`)
    REFERENCES `apsi`.`ActivityTag` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Activity_Person1`
    FOREIGN KEY (`Person_idPerson`)
    REFERENCES `apsi`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `apsi`.`Persons_Permissions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `apsi`.`Persons_Permissions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `PermissionInSystem_Permission` VARCHAR(45) NOT NULL,
  `User_Person_idPerson` INT NOT NULL,
  INDEX `fk_Persons_Permissions_PermissionInSystem1_idx` (`PermissionInSystem_Permission` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_Persons_Permissions_User1_idx` (`User_Person_idPerson` ASC),
  CONSTRAINT `fk_Persons_Permissions_PermissionInSystem1`
    FOREIGN KEY (`PermissionInSystem_Permission`)
    REFERENCES `apsi`.`PermissionInSystem` (`Permission`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Persons_Permissions_User1`
    FOREIGN KEY (`User_Person_idPerson`)
    REFERENCES `apsi`.`User` (`Person_idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
