-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ediki
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ediki
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ediki` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `ediki` ;

-- -----------------------------------------------------
-- Table `ediki`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ediki`.`categories` (
  `id` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ediki`.`manufacturers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ediki`.`manufacturers` (
  `id` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ediki`.`pvz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ediki`.`pvz` (
  `id` INT NOT NULL,
  `postcode` CHAR(6) NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `street` VARCHAR(50) NOT NULL,
  `house` VARCHAR(5) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ediki`.`orderstatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ediki`.`orderstatus` (
  `id` INT NOT NULL,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ediki`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ediki`.`roles` (
  `id` INT NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ediki`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ediki`.`users` (
  `id` INT NOT NULL,
  `full_name` VARCHAR(50) NOT NULL,
  `login` VARCHAR(50) NOT NULL,
  `password` VARCHAR(30) NOT NULL,
  `role_id` INT NOT NULL,
  `userscol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `role_id_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `role_id`
    FOREIGN KEY (`role_id`)
    REFERENCES `ediki`.`roles` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ediki`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ediki`.`orders` (
  `id` INT NOT NULL,
  `order_date` DATETIME NOT NULL,
  `delivery_date` DATETIME NULL DEFAULT NULL,
  `pvz_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `receive_code` VARCHAR(10) NOT NULL,
  `status_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `pvz_id_idx` (`pvz_id` ASC) VISIBLE,
  INDEX `user_id_idx` (`user_id` ASC) VISIBLE,
  INDEX `status_id_idx` (`status_id` ASC) VISIBLE,
  INDEX `pv564tdr6u5fytdr6fuyz_idx` (`pvz_id` ASC) VISIBLE,
  CONSTRAINT `pvz_id`
    FOREIGN KEY (`pvz_id`)
    REFERENCES `ediki`.`pvz` (`id`),
  CONSTRAINT `status_id`
    FOREIGN KEY (`status_id`)
    REFERENCES `ediki`.`orderstatus` (`id`),
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `ediki`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ediki`.`suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ediki`.`suppliers` (
  `id` INT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ediki`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ediki`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `article` VARCHAR(10) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `unit` VARCHAR(50) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  `discount` INT NOT NULL,
  `stock_qty` INT NOT NULL,
  `description` VARCHAR(250) NULL DEFAULT NULL,
  `photo` VARCHAR(50) NULL DEFAULT NULL,
  `category_id` INT NOT NULL,
  `manufacturer_id` INT NOT NULL,
  `supplier_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_products_category_idx` (`category_id` ASC) VISIBLE,
  INDEX `manufacturer_id_idx` (`manufacturer_id` ASC) VISIBLE,
  INDEX `supplier_id_idx` (`supplier_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `ediki`.`categories` (`id`),
  CONSTRAINT `manufacturer_id`
    FOREIGN KEY (`manufacturer_id`)
    REFERENCES `ediki`.`manufacturers` (`id`),
  CONSTRAINT `supplier_id`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `ediki`.`suppliers` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `ediki`.`prodorders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ediki`.`prodorders` (
  `id` INT NOT NULL,
  `order_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `qty` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `order_id_idx` (`order_id` ASC) VISIBLE,
  INDEX `product_id_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `ediki`.`orders` (`id`)
    ON DELETE CASCADE,
  CONSTRAINT `product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `ediki`.`products` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
