create schema carnnected;
use carnnected;

CREATE TABLE `MEMBER`(
    `id` VARCHAR(15) NOT NULL,
    `pwd` VARCHAR(20) NOT NULL,
    `name` VARCHAR(10) NOT NULL,
    `birth` CHAR(6) NOT NULL,
    `phone` CHAR(11) NOT NULL,
    PRIMARY KEY (`id`));

INSERT INTO `MEMBER` VALUES
('dlekdud0102','password1234','이다영','010102','01012345678'),
('mouse0429','password1234','김민지','000429','01023456789'),
('sy02lee','password1234','이승윤','000223','01034567890'),
('harrydh','password1234','정도훈','000601','01045678901'),
('lseyeon0723','password1234','이세연','990326','01056789012'),
('baekhyuneeexo','password1234','변백현','920506','01067890123'),
('dlwlrma','password1234','이지은','930516','01078901234'),
('beeeestdjdjdj','password1234','윤두준','890704','01089012345'),
('yysbeast','password1234','양요섭','900105','01090123456'),
('gttk0000','password1234','이기광','900330','01001234567'),
('highlightdnpn','password1234','손동운','910606','01089756421');