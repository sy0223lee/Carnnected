create schema carnnected;
use carnnected;

# 회원 테이블
CREATE TABLE `MEMBER`(
    `id` VARCHAR(15) NOT NULL,
    `pwd` VARCHAR(20) NOT NULL,
    `name` VARCHAR(10) NOT NULL,
    `birth` CHAR(6) NOT NULL,
    `phone` CHAR(11) NOT NULL,
    PRIMARY KEY (`id`));

# 주유 서비스 예약
CREATE TABLE `GAS_RESRV`(
	`id` VARCHAR(15) NOT NULL,			# 회원 id
    `time` DATETIME NOT NULL,			# 예약 날짜, 시간
    `type` VARCHAR(10) NOT NULL,		# 연료 종류
    `amount` INT NOT NULL,				# 주유 금액
    `source` VARCHAR(50) NOT NULL,		# 차량 위치
    `dest_name` VARCHAR(15) NOT NULL,	# 주유소 이름
    `dest_addr` VARCHAR(50) NOT NULL,	# 주유소 주소
    `price` INT NOT NULL,				# 예상 가격
    FOREIGN KEY (`id`)
    REFERENCES `MEMBER`(`id`) ON UPDATE CASCADE);

# 세차 서비스 예약    
CREATE TABLE `WASH_RESRV`(
	`id` VARCHAR(15) NOT NULL,			# 회원 id
    `time` DATETIME NOT NULL,			# 예약 날짜, 시간
    `type` VARCHAR(10) NOT NULL,		# 세차 종류
    `company` VARCHAR(15) NOT NULL,		# 세차 업체
    `source` VARCHAR(50) NOT NULL,		# 차량 위치
    `price` INT NOT NULL,				# 예상 가격
    FOREIGN KEY (`id`)
    REFERENCES `MEMBER`(`id`) ON UPDATE CASCADE);

# 딜리버리 서비스 예약
CREATE TABLE `DELIV_RESRV`(
	`id` VARCHAR(15) NOT NULL,			# 회원 id
    `time` DATETIME NOT NULL,			# 예약 날짜, 시간
    `source` VARCHAR(50) NOT NULL,		# 차량 위치
    `dest_name` VARCHAR(15),			# 목적지 이름
    `dest_addr` VARCHAR(50) NOT NULL,	# 목적지 주소
    `price` INT NOT NULL,				# 예상 가격
    FOREIGN KEY (`id`)
    REFERENCES `MEMBER`(`id`) ON UPDATE CASCADE);   

# 대리운전 서비스 예약    
CREATE TABLE `DRIVE_RESRV`(
	`id` VARCHAR(15) NOT NULL,			# 회원 id
    `time` DATETIME NOT NULL,			# 예약 날짜, 시간
    `source` VARCHAR(50) NOT NULL,		# 차량 위치
    `dest_name` VARCHAR(15),			# 목적지 이름
    `dest_addr` VARCHAR(50) NOT NULL,	# 목적지 주소
    `price` INT NOT NULL,				# 예상 가격
    FOREIGN KEY (`id`)
    REFERENCES `MEMBER`(`id`) ON UPDATE CASCADE);  

# 방문교체 서비스 예약    
CREATE TABLE `REPLACE_RESRV`(
	`id` VARCHAR(15) NOT NULL,			# 회원 id
    `time` DATETIME NOT NULL,			# 예약 날짜, 시간
	`item` VARCHAR(20) NOT NULL,		# 교체 용품
    `source` VARCHAR(50) NOT NULL,		# 차량 위치
    `price` INT NOT NULL,				# 예상 가격
    FOREIGN KEY (`id`)
    REFERENCES `MEMBER`(`id`) ON UPDATE CASCADE);
    
# 대리정비 서비스 예약
CREATE TABLE `REPAIR_RESRV`(
	`id` VARCHAR(15) NOT NULL,			# 회원 id
    `time` DATETIME NOT NULL,			# 예약 날짜, 시간
    `type` VARCHAR(10) NOT NULL,		# 검사 종류
    `detail` VARCHAR(100),				# 추가 요청 사항
    `source` VARCHAR(50) NOT NULL,		# 차량 위치
    `dest_name` VARCHAR(15) NOT NULL,	# 정비소 이름
    `dest_addr` VARCHAR(50) NOT NULL,	# 정비소 주소
    `price` INT NOT NULL,				# 예상 가격
    FOREIGN KEY (`id`)
    REFERENCES `MEMBER`(`id`) ON UPDATE CASCADE);  