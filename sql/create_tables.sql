create schema mosigg;
use mosigg;

CREATE TABLE `MEMBER`(
    `id` VARCHAR(15) NOT NULL,
    `pwd` VARCHAR(20) NOT NULL,
    `name` VARCHAR(10) NOT NULL,
    `birth` CHAR(6) NOT NULL,
    `phone` CHAR(11) NOT NULL,
    PRIMARY KEY (`id`));
    