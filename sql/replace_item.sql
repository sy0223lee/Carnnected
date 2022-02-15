use carnnected;

# 교체 아이템 테이블 생성
CREATE TABLE `REPLACE_ITEM`(
    `index` INT AUTO_INCREMENT,
    `company` VARCHAR(30) NOT NULL,
    `item` VARCHAR(30) NOT NULL,
    `detail` VARCHAR(100) NOT NULL,
    `price` INT NOT NULL,
    PRIMARY KEY (`detail`));

# 교체 아이템 추가
# item: 와이퍼, 에어컨필터, 워셔액, 엔진오일, 배터리, 타이어, 타이어 공기압
INSERT INTO `REPLACE_ITEM` (`company`, `item`, `detail`, `price`) VALUES 
# 와이퍼
('보쉬', '와이퍼', '보쉬 에어로트원 와이퍼', 10000),
('보쉬', '와이퍼', '보쉬 클리어핏 와이퍼', 4000),
('카렉스', '와이퍼', '카렉스 레인스톰 하이브리드 와이퍼', 4500),
('불스원', '와이퍼', '불스원 레인OK 메탈X실리콘 와이퍼', 16000),
('불스원', '와이퍼', '불스원 레인OK 메탈 하이브리드 초발수 와이퍼', 15000),
#에어컨 필터
('3M', '에어컨필터', '3M PM2.5 초미세먼지 활성탄 필터 F6274', 7000),
('현대모비스', '에어컨필터', '현대모비스 베스핏츠 에어컨히터 필터 97133-3SAA0', 7000),
('대한청정산업', '에어컨필터', '대한청정산업 PM0.3 H11 헤파 프리미엄 극초미세먼지 에어컨필터 H134', 6100),
('맑은에어텍', '에어컨필터', '맑은에어텍 맑은필터 활성탄필터 005', 3500),
('한일텍', '에어컨필터', '한일텍 한일 파티클 필터 B174', 3200),
# 워셔액
('한눈알', '워셔액', '한눈알 에탄올 워셔액 1.8L', 3000),
('불스원', '워셔액', '불스원 레인OK 프리미엄 에탄올 발수코팅 워셔액 1.8L', 7000),
('현대모비스', '워셔액', '현대모비스 프리미엄 에탄올 워셔액 2L', 7000),
('불스원', '워셔액', '불스원 레인OK 에탄올 그린워셔 1.8L', 5500),
('소낙스', '워셔액', '소낙스 더 뷰 에탄올 워셔액 2L', 8000),
# 엔진오일
('킥스', '엔진오일', 'GS칼텍스 킥스 파오 A3/B4 5W30 1L', 5000),
('킥스', '엔진오일', 'GS칼텍스 킥스 파오 C2/C3 5W30 1L', 5000),
('지크', '엔진오일', 'SK루브리컨츠 지크 탑 5W30 1L', 8000),
('에쓰오일', '엔진오일', '에쓰오일 세븐 골드 #9 C3 5W40 1L', 4300),
('쉘', '엔진오일', '쉘 힐릭스 울트라 ECT C3 5W30 1L', 8000),
# 배터리
('델코', '배터리', '델코 AGM LN3(AGM70)', 121000),
('델코', '배터리', '델코 AGM LN4(AGM80)', 141000),
('세방전지', '배터리', ' 세방전지 로케트 AGM95 L5', 150000),
('아트라스BX', '배터리', '아트라스BX AGM95DL', 177000),
('바르타', '배터리', '바르타 AGM105', 284000),
# 타이어
('금호타이어', '타이어', '금호타이어 마제스티9 솔루스 TA91 245/45R18', 150000),
('금호타이어', '타이어', '금호타이어 크루젠 HP71 235/55R19', 110000),
('한국타이어', '타이어', '한국타이어 옵티모 H426 245/45R18', 75000),
('넥센타이어', '타이어', '넥센타이어 CP672 215/55R17', 65000),
('미쉐린타이어', '타이어', '미쉐린타이어 크로스 클라이밋 플러스 245/45R18', 161000),
# 타이어 공기압
('타이어공기압', '공기압', '타이어 공기압 체크 및 충전', 2000);