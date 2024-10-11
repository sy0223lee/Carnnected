create schema carnnected;
use carnnected;

# 회원 테이블
CREATE TABLE `MEMBER`(
    `id` VARCHAR(50) NOT NULL,
    `authToken` VARCHAR(500) NOT NULL,
    `pwd` VARCHAR(20) NOT NULL,
    `name` VARCHAR(10) NOT NULL,
    `birth` CHAR(6) NOT NULL,
    `phone` CHAR(11) NOT NULL,
    PRIMARY KEY (`id`));
    
# 차량 테이블
CREATE TABLE `CAR`(
	`id` VARCHAR(25) NOT NULL,			# 회원 id
    `model` VARCHAR(30) NOT NULL,		# 차종
    `year` INT NOT NULL,				# 차 연식
    `number` CHAR(11) NOT NULL,			# 차 번호
    `name` VARCHAR(30) NULL,			# 차 별명
    `image` VARCHAR(50) NOT NULL,		# 차 사진 경로
    `vehicleId` INT NOT NULL,			# 차량 id
    PRIMARY KEY(`number`),
    FOREIGN KEY(`id`)
    REFERENCES `MEMBER`(`id`) ON UPDATE CASCADE);

# 즐겨찾는 주소
CREATE TABLE `FAVORITE_ADDR`(
	`id` VARCHAR(25) NOT NULL,			# 회원 id
    `addr` VARCHAR(100) NOT NULL,		# 즐겨찾는 주소
    `detailAddr` VARCHAR(100) NOT NULL,	# 즐겨찾는 상세 주소
    `num` INT NOT NULL,					# 보여줄 순서
    FOREIGN KEY(`id`)
    REFERENCES `MEMBER`(`id`) ON UPDATE CASCADE,
    PRIMARY KEY(`id`, `addr`, `detailAddr`));	# 기본키 여러개로 설정해서 중복 안되도록

# 주유 서비스 예약
CREATE TABLE `GAS_RESRV`(
	`tablename` VARCHAR(20) NOT NULL DEFAULT '주유',
	`id` VARCHAR(25) NOT NULL,			# 회원 id
    `number` CHAR(11) NOT NULL,			# 차 번호
    `time` DATETIME NOT NULL,			# 예약 날짜, 시간
    `type` VARCHAR(20) NOT NULL,		# 연료 종류
    `amount` INT NOT NULL,				# 주유 금액
    `source` VARCHAR(100) NOT NULL,		# 차량 위치
    `detailSrc` VARCHAR(100) NOT NULL,	# 차량 상세 위치
    `dest_name` VARCHAR(30) NOT NULL,	# 주유소 이름
    `price` INT NOT NULL,				# 예상 가격
    `payment` VARCHAR(15) NOT NULL,		# 결제 방식
    `status` VARCHAR(10) NOT NULL DEFAULT 'reserved',	# 예약 상태
    FOREIGN KEY (`id`)
    REFERENCES `MEMBER`(`id`) ON UPDATE CASCADE);

# 세차 서비스 예약    
CREATE TABLE `WASH_RESRV`(
	`tablename` VARCHAR(20) NOT NULL DEFAULT '세차',
	`id` VARCHAR(25) NOT NULL,			# 회원 id
    `number` CHAR(11) NOT NULL,			# 차 번호
    `time` DATETIME NOT NULL,			# 예약 날짜, 시간
    `detail` VARCHAR(600),				# 추가 요청 사항
    `type` VARCHAR(30) NOT NULL,		# 세차 종류
    `source` VARCHAR(100) NOT NULL,		# 차량 위치
    `detailSrc` VARCHAR(100) NOT NULL,	# 차량 상세 위치
    `price` INT NOT NULL,				# 예상 가격
    `payment` VARCHAR(15) NOT NULL,		# 결제 방식
    `status` VARCHAR(10) NOT NULL DEFAULT 'reserved',	# 예약 상태
    FOREIGN KEY (`id`)
    REFERENCES `MEMBER`(`id`) ON UPDATE CASCADE);

# 딜리버리 서비스 예약
CREATE TABLE `DELIV_RESRV`(
	`tablename` VARCHAR(20) NOT NULL DEFAULT '딜리버리',
	`id` VARCHAR(25) NOT NULL,			# 회원 id
    `number` CHAR(11) NOT NULL,			# 차 번호
    `time` DATETIME NOT NULL,			# 예약 날짜, 시간
    `detail` VARCHAR(600),				# 추가 요청 사항
    `source` VARCHAR(100) NOT NULL,		# 차량 위치
    `detailSrc` VARCHAR(100) NOT NULL,	# 차량 상세 위치
    `dest_name` VARCHAR(30),			# 목적지 이름
    `dest_addr` VARCHAR(100) NOT NULL,	# 목적지 주소
    `price` INT NOT NULL,				# 예상 가격
    `payment` VARCHAR(15) NOT NULL,		# 결제 방식
    `status` VARCHAR(10) NOT NULL DEFAULT 'request',	# 예약 상태
    FOREIGN KEY (`id`)
    REFERENCES `MEMBER`(`id`) ON UPDATE CASCADE);

# 대리운전 서비스 예약    
CREATE TABLE `DRIVE_RESRV`(
	`tablename` VARCHAR(20) NOT NULL DEFAULT '대리운전',
	`id` VARCHAR(25) NOT NULL,			# 회원 id
    `number` CHAR(11) NOT NULL,			# 차 번호
    `time` DATETIME NOT NULL,			# 예약 날짜, 시간
    `source` VARCHAR(100) NOT NULL,		# 차량 위치
    `detailSrc` VARCHAR(100) NOT NULL,	# 차량 상세 위치
    `dest_name` VARCHAR(30),			# 목적지 이름
    `dest_addr` VARCHAR(100) NOT NULL,	# 목적지 주소
    `price` INT NOT NULL,				# 예상 가격
    `payment` VARCHAR(15) NOT NULL,		# 결제 방식
    `status` VARCHAR(10) NOT NULL DEFAULT 'request',	# 예약 상태
    FOREIGN KEY (`id`)
    REFERENCES `MEMBER`(`id`) ON UPDATE CASCADE);

# 방문교체 서비스 예약    
CREATE TABLE `REPLACE_RESRV`(
	`tablename` VARCHAR(20) NOT NULL DEFAULT '방문교체',
	`id` VARCHAR(25) NOT NULL,			# 회원 id
    `number` CHAR(11) NOT NULL,			# 차 번호
    `time` DATETIME NOT NULL,			# 예약 날짜, 시간
	`item` VARCHAR(300) NOT NULL,		# 교체 용품
    `repair` BOOLEAN NOT NULL,			# 간단 정비 옵션 - true, false
	`detail` VARCHAR(600),				# 추가 요청 사항
    `source` VARCHAR(100) NOT NULL,		# 차량 위치
    `detailSrc` VARCHAR(100) NOT NULL,	# 차량 상세 위치
    `price` INT NOT NULL,				# 예상 가격
    `payment` VARCHAR(15) NOT NULL,		# 결제 방식
    `status` VARCHAR(10) NOT NULL DEFAULT 'reserved',	# 예약 상태
    FOREIGN KEY (`id`)
    REFERENCES `MEMBER`(`id`) ON UPDATE CASCADE);
    
# 정비 서비스 예약
CREATE TABLE `REPAIR_RESRV`(
	`tablename` VARCHAR(20) NOT NULL DEFAULT '대리정비',
	`id` VARCHAR(25) NOT NULL,			# 회원 id
    `number` CHAR(11) NOT NULL,			# 차 번호
    `time` DATETIME NOT NULL,			# 예약 날짜, 시간
    `type` VARCHAR(30) NOT NULL,		# 검사 종류
    `detail` VARCHAR(600),				# 추가 요청 사항
    `source` VARCHAR(100) NOT NULL,		# 차량 위치
    `detailSrc` VARCHAR(100) NOT NULL,	# 차량 상세 위치
    `dest_name` VARCHAR(30) NOT NULL,	# 정비소 이름
    `dest_addr` VARCHAR(100) NOT NULL,	# 정비소 주소
    `price` INT NOT NULL,				# 예상 가격
    `payment` VARCHAR(15) NOT NULL,		# 결제 방식
    `status` VARCHAR(10) NOT NULL DEFAULT 'reserved',	# 예약 상태
    FOREIGN KEY (`id`)
    REFERENCES `MEMBER`(`id`) ON UPDATE CASCADE);