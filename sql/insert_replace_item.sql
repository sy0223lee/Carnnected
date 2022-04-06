use carnnected;

# 교체 아이템 테이블 생성
CREATE TABLE `REPLACE_ITEM`(
    `index` INT AUTO_INCREMENT,
    `company` VARCHAR(30) NOT NULL,
    `image` VARCHAR(100),
    `type` VARCHAR(30) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `opName` VARCHAR(50),
    `option` VARCHAR(300),
    `opPrice` VARCHAR(100),
    `price` INT NOT NULL,
    PRIMARY KEY (`index`));

# 교체 아이템 추가
# item: 와이퍼, 에어컨필터, 워셔액, 엔진오일, 배터리, 타이어, 타이어 공기압
INSERT INTO `REPLACE_ITEM` (`company`, `image`, `type`, `name`, `opName`, `option`, `opPrice`, `price`) VALUES
# 와이퍼
('보쉬', 'image/replace_item/bosch_aerotwin.jpg', '와이퍼', '보쉬 에어로트윈 와이퍼', '사이즈', '["300mm", "400mm", "500mm"]', '[1000,2000,3000]', 10000),
('보쉬', 'image/replace_item/bosch_clearfit.jpg', '와이퍼', '보쉬 클리어핏 와이퍼', '사이즈', '["300mm", "350mm", "400mm", "450mm", "500mm", "550mm", "600mm", "650mm"]', '[0, 200, 600, 900, 1600, 2300, 3500, 4200]', 10000),
('카렉스', 'image/replace_item/carex_hybrid.jpg','와이퍼', '카렉스 레인스톰 하이브리드 와이퍼', '사이즈', '["350mm", "400mm", "450mm", "500mm", "550mm", "600mm", "650mm"]', '[0, 0, 0, 0, 0, 0, 0]', 5000),
('현대모비스', 'image/replace_item/mobis_hybrid.jpg','와이퍼', '현대모비스 발수코팅 실리콘 하이브리드 와이퍼', '사이즈', '["350mm", "400mm", "450mm", "500mm", "550mm", "600mm", "650mm"]', '[0, 0, 1000, 1000, 2000, 2500, 3000, 3500]', 13000),
#에어컨 필터
('3M', 'image/replace_item/3M_filter.jpg', '에어컨필터', '3M PM2.5 초미세먼지 활성탄 필터 F62', '크기', '["251*222*28mm","210*227*30mm","196*239*28mm","212*239*30mm"]', '[1000,0,0,1000]', 6500),
('현대모비스', 'image/replace_item/mobis_filter.jpg', '에어컨필터', '현대모비스 베스핏츠 에어컨히터 필터', '크기', '["180*180*12mm","230*260*33mm","200*240*20mm","225*200*17mm"]', '[0,1000,500,700]', 5500),
('대한청정산업', 'image/replace_item/dhfilter_filter.jpg', '에어컨필터', '대한청정산업 PM0.3 H11 헤파 프리미엄 극초미세먼지 에어컨필터', '크기', '["253*226*20mm","240*200*28mm","225*252*30mm","240*203*34mm"]', '[0,0,0,0]', 6100),
('맑은에어텍', 'image/replace_item/cleanairtech_filter.jpg', '에어컨필터', '맑은에어텍 맑은필터 활성탄필터', '크기', '["253x226x20mm","193x238x20mm","180x160x25mm","223x253x28mm"]', '[0,0,0,0]', 3500),
('한일텍', 'image/replace_item/hanil_filter.jpg', '에어컨필터', '한일텍 한일 파티클 필터', '크기', '["225x252x20mm","200x235x35mm","180x160x25mm","175x173x12mm"]', '[0,0,0,0]', 3200),
# 워셔액
('한눈알', 'image/replace_item/hannoon_washerfluid.jpg', '워셔액', '한눈알 에탄올 워셔액 1.8L', null, null, null, 3000),
('불스원', 'image/replace_item/bullsone_premium_washerfluid.jpg', '워셔액', '불스원 레인OK 프리미엄 에탄올 발수코팅 워셔액 1.8L', null, null, null, 5000),
('현대모비스', 'image/replace_item/mobis_washerfluid.jpg', '워셔액', '현대모비스 프리미엄 에탄올 워셔액 2L', null, null, null, 7000),
('불스원', 'image/replace_item/bullsone_greenwasher.jpg', '워셔액', '불스원 레인OK 에탄올 그린워셔 1.8L', null, null, null, 5500),
('소낙스', 'image/replace_item/sonax_washerfluid.jpg', '워셔액', '소낙스 더 뷰 에탄올 워셔액 2L', null, null, null, 8000),
# 엔진오일
('킥스', 'image/replace_item/kixx_A3B4.jpg', '엔진오일', 'GS칼텍스 킥스 파오 A3/B4 5W30 1L', '적용엔진', '["가솔린"]', '[0]', 5000),
('킥스', 'image/replace_item/kixx_C2C3.jpg', '엔진오일', 'GS칼텍스 킥스 파오 C2/C3 5W30 1L', '적용엔진', '["가솔린","디젤"]', '[0,0]', 5000),
('지크', 'image/replace_item/zic_top.jpg', '엔진오일', 'SK루브리컨츠 지크 탑 5W30 1L', '적용엔진', '["가솔린","디젤","LPG"]', '[0,0,0]', 8000),
('에쓰오일', 'image/replace_item/soil_sevengold.jpg', '엔진오일', '에쓰오일 세븐 골드 #9 C3 5W40 1L', '적용엔진', '["가솔린","디젤","LPG"]', '[0,0,0]', 4300),
('쉘', 'image/replace_item/shell_helix.jpg', '엔진오일', '쉘 힐릭스 울트라 ECT C3 5W30 1L', '적용엔진', '["가솔린","디젤","LPG"]', '[0,0,0]', 8000),
# 배터리
('델코', 'image/replace_item/delkor_AGM.jpg', '배터리', '델코 AGM LN', '용량', '["60Ah","70Ah","80Ah","95Ah","105Ah"]', '[0,0,40000,60000,100000]', 100000),
('세방전지', 'image/replace_item/sebang_rocket.jpg', '배터리', '세방전지 로케트 AGM', '용량', '["60Ah","70Ah","80Ah","95Ah","105Ah"]', '[0,10000,20000,60000,110000]', 110000),
('아트라스BX', 'image/replace_item/atlasbx_AGM.jpg', '배터리', '아트라스BX AGM', '용량', '["60Ah","70Ah","80Ah","95Ah","105Ah"]', '[0,30000,40000,70000,145000]', 105000),
('바르타', 'image/replace_item/varta_AGM.jpg', '배터리', '바르타 AGM', '용량', '["70Ah","80Ah","95Ah","105Ah"]', '[0,25000,70000,120000]', 160000),
# 타이어
('금호타이어', 'image/replace_item/kumho_crugen.jpg', '타이어', '금호타이어 마제스티9 솔루스 TA91', '단면폭(mm)/편평비(%)R휠지름(인치)', '["245/45R18","245/40R19","225/55/R17","215/55R17"]', '[40000,10000,0,20000]', 120000),
('금호타이어', 'image/replace_item/kumho_majesty9.jpg', '타이어', '금호타이어 크루젠 HP71', '단면폭(mm)/편평비(%)R휠지름(인치)', '["235/55R19","235/60R18","225/60R18","245/45R19"]', '[0,20000,18000,13000]', 110000),
('한국타이어', 'image/replace_item/hankook_optimo.jpg', '타이어', '한국타이어 옵티모 H426', '단면폭(mm)/편평비(%)R휠지름(인치)', '["195/65R15","235/45R18","245/40R19","245/45R18"]', '[0,20000,40000,20000]', 75000),
('넥센타이어', 'image/replace_item/nexen_CP672.jpg', '타이어', '넥센타이어 CP672', '단면폭(mm)/편평비(%)R휠지름(인치)', '["225/55R17","215/50R17","205/55R16","205/65R15"]', '[10000,5000,0,5000]', 65000),
('미쉐린타이어', 'image/replace_item/michelin_cross.jpg', '타이어', '미쉐린타이어 크로스 클라이밋 플러스', '단면폭(mm)/편평비(%)R휠지름(인치)', '["205/55R16","225/55R17","225/45R18","215/50R17"]', '[0,20000,25000,5000]', 120000),
# 타이어 공기압
('타이어공기압', 'image/none.png', '공기압', '타이어 공기압 체크 및 충전', null, null, null, 2000);