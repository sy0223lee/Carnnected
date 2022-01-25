create schema carnnected;
use carnnected;

CREATE TABLE `MEMBER`(
    `id` VARCHAR(15) NOT NULL,
    `pwd` VARCHAR(20) NOT NULL,
    `name` VARCHAR(10) NOT NULL,
    `birth` CHAR(6) NOT NULL,
    `phone` CHAR(11) NOT NULL,
    PRIMARY KEY (`id`));

# 주유 서비스 예약
CREATE TABLE `GAS_RESRV`(
	`id` VARCHAR(15) NOT NULL,
    `time` DATETIME NOT NULL,
    `type` VARCHAR(10) NOT NULL,
    `amount` INT NOT NULL,
    `source` VARCHAR(50) NOT NULL,
    `dest_name` VARCHAR(15) NOT NULL,
    `dest_addr` VARCHAR(50) NOT NULL,
    `price` INT NOT NULL,
    FOREIGN KEY (`id`)
    REFERENCES `MEMBER`(`id`) ON UPDATE CASCADE);

# 세차 서비스 예약    
CREATE TABLE `WASH_RESRV`(
	`id` VARCHAR(15) NOT NULL,
    `time` DATETIME NOT NULL,
    `type` VARCHAR(10) NOT NULL,
    `company` VARCHAR(15) NOT NULL,
    `source` VARCHAR(50) NOT NULL,
    `price` INT NOT NULL,
    FOREIGN KEY (`id`)
    REFERENCES `MEMBER`(`id`) ON UPDATE CASCADE);

# 딜리버리 서비스 예약
CREATE TABLE `DELIV_RESRV`(
	`id` VARCHAR(15) NOT NULL,
    `time` DATETIME NOT NULL,
    `source` VARCHAR(50) NOT NULL,
    `dest_name` VARCHAR(15),
    `dest_addr` VARCHAR(50) NOT NULL,
    `price` INT NOT NULL,
    FOREIGN KEY (`id`)
    REFERENCES `MEMBER`(`id`) ON UPDATE CASCADE);   

# 대리운전 서비스 예약    
CREATE TABLE `DRIVE_RESRV`(
	`id` VARCHAR(15) NOT NULL,
    `time` DATETIME NOT NULL,
    `source` VARCHAR(50) NOT NULL,
    `dest_name` VARCHAR(15),
    `dest_addr` VARCHAR(50) NOT NULL,
    `price` INT NOT NULL,
    FOREIGN KEY (`id`)
    REFERENCES `MEMBER`(`id`) ON UPDATE CASCADE);  