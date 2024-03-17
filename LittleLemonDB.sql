-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customers` (
  `CustomerID` INT NOT NULL,
  `CustomerName` VARCHAR(45) NULL,
  `CustomerContact` VARCHAR(45) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Staff` (
  `StaffID` INT NOT NULL,
  `StaffRole` VARCHAR(45) NOT NULL,
  `StaffSalary` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`StaffID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bookings` (
  `BookingID` INT NOT NULL,
  `BookingDate` DATETIME NOT NULL,
  `TableNumber` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `StaffID` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `CustomerID_fk_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `StaffID_fk_idx` (`StaffID` ASC) VISIBLE,
  CONSTRAINT `Booking_Customer_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `mydb`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Booking_Staff_fk`
    FOREIGN KEY (`StaffID`)
    REFERENCES `mydb`.`Staff` (`StaffID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Menus` (
  `MenuID` INT NOT NULL,
  `Cuisine` VARCHAR(45) NULL,
  `Course` VARCHAR(45) NULL,
  `ItemCost` DECIMAL(2) NOT NULL,
  PRIMARY KEY (`MenuID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Orders` (
  `OrderID` INT NOT NULL,
  `OrderDate` DATETIME NOT NULL,
  `OrderQuantity` INT NULL,
  `OrderTotalCost` DECIMAL(2) NOT NULL,
  `MenuID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `MenuID_fk_idx` (`MenuID` ASC) VISIBLE,
  INDEX `CustomerID_fk_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `Order_Menu_fk`
    FOREIGN KEY (`MenuID`)
    REFERENCES `mydb`.`Menus` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Order_Customer_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `mydb`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Deliveries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Deliveries` (
  `DeliveryID` INT NOT NULL,
  `DeliveryDate` DATETIME NULL,
  `DeliveryStatus` VARCHAR(45) NULL,
  `OrderID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  PRIMARY KEY (`DeliveryID`),
  INDEX `OrderID_fk_idx` (`OrderID` ASC) VISIBLE,
  INDEX `CustomerID_fk_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `Delivery_Order_fk`
    FOREIGN KEY (`OrderID`)
    REFERENCES `mydb`.`Orders` (`OrderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Delivery_Customer_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `mydb`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
