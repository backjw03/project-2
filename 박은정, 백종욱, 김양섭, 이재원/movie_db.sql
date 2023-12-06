use db_movie;

-- 회원
create table member_tbl(
	mname VARCHAR(20) NOT null, -- 이름
    mno varchar(13) not null, -- 주민번호
    mph varchar(11) not null, -- 핸드폰번호 
    mem varchar(30) not null, -- 이메일
    mid varchar(15) primary key, -- 아이디 (기본키)
    mpw varchar(20) not null, -- 비밀번호
    mpoint int -- 포인트점수
    );
    
-- 회원데이터 입력    
insert into member_tbl(mname, mno, mph, mem, mid, mpw, mpoint)
value ("박은정", "2009112111111", "01011111111", "kalsias@naver.com", "park01", "1111", "1000");
insert into member_tbl(mname, mno, mph, mem, mid, mpw, mpoint)
value ("백종욱", "2009121111111", "01022222222", "bunggu99@gmail.com", "beck01", "2222", "1000");
insert into member_tbl(mname, mno, mph, mem, mid, mpw, mpoint)
value ("김양섭", "2009131111111", "01033333333", "dudad@naver.com", "kim01", "3333", "1000");
insert into member_tbl(mname, mno, mph, mem, mid, mpw, mpoint)
value ("이재원", "2009141111111", "01044444444", "xkxkfhwk2@naver.com", "lee01", "4444", "1000");

-- 극장    
CREATE TABLE theater_tbl (
	tcode VARCHAR(20)  primary key, -- 지점코드(기본키)
	tname VARCHAR(20) not null, -- 지점명
	tlocation VARCHAR(50) not null -- 위치
	);

-- 극장데이터 입력 
insert into theater_tbl(tcode,tname,tlocation)
values ("AAA","인천점","인천");
insert into theater_tbl(tcode,tname,tlocation)
values ("BBB","강남점","서울");
insert into theater_tbl(tcode,tname,tlocation)
values ("CCC","해운대점","부산");
insert into theater_tbl(tcode,tname,tlocation)
values ("DDD","부여점","충남");

-- 상영관
create table cinema_tbl (
	ccode varchar(20) PRIMARY KEY, -- 상영관코드(기본키)
    tcode varchar(20), -- 지점코드
    cname varchar(10) not null, -- 상영관명
    cseat int not null, -- 좌석수
    foreign key (tcode) references theater_tbl(tcode) -- 지점코드 (외래키) 지정
    on update cascade on delete set null
    );
    
-- 상영관데이터 입력    
INSERT INTO cinema_tbl (ccode, tcode, cname, cseat)
VALUES ('004038', 'AAA', '4관', 25);
INSERT INTO cinema_tbl(ccode,tcode,cname,cseat)
VALUES('002204','BBB','1관', 25);
INSERT INTO cinema_tbl(ccode,tcode,cname,cseat)
VALUES('002303','CCC','7관', 25);
INSERT INTO cinema_tbl(ccode,tcode,cname,cseat)
VALUES('012051','DDD','5관', 25);

-- 영화    
CREATE TABLE movie_tbl (
	mcode VARCHAR(10) PRIMARY KEY , -- 영화코드(기본키)
	mdate DATE  NOT NULL, -- 상영일자
	ccode VARCHAR(20), -- 상영관 코드 
	btime TIME  NOT NULL, -- 상영시간
	mtitle VARCHAR(50)  NOT NULL, -- 영화제목
	mdirec VARCHAR(20), -- 감독
	mactor VARCHAR(20)  NOT NULL, -- 주연배우 
	foreign key (ccode) references cinema_tbl (ccode) -- 상영관코드(외래키)
    on update cascade on delete set null
	);
    
-- 영화데이터 입력    
INSERT INTO movie_tbl (mcode, mdate, ccode, btime, mtitle, mdirec, mactor)
VALUES ('20231496D', '2023-08-01', '004038', '02:30', '가디언즈 오브 갤럭시: Volume 3', '제임스 건', '크리스 프랫, 조에 살다나');
INSERT INTO movie_tbl (mcode, mdate, ccode, btime, mtitle, mdirec, mactor)
VALUES ('20183782D', '2019-05-30', '002204', '02:11', '기생충', '봉준호', '송강호,이선균,조여정');
INSERT INTO movie_tbl (mcode, mdate, ccode, btime, mtitle, mdirec, mactor)
VALUES ('20126674D', '2013-08-01', '002303', '02:06', '설국열차', '봉준호', '크리스 에반스, 송강호,고아성');
INSERT INTO movie_tbl (mcode, mdate, ccode, btime, mtitle, mdirec, mactor)
VALUES ('20228555D', '2022-12-03', '012051', '02:04', '더 퍼스트 슬램덩크', '이노우에 다케히코','카사마 준,키무라 스바루');

SELECT * FROM movie_tbl;

-- 좌석
CREATE TABLE seat_tbl (
	scode VARCHAR(10) PRIMARY KEY , -- 좌석코드(기본키)
	ccode VARCHAR(20) , -- 상영관 코드
	srow VARCHAR(5)  NOT NULL , -- 좌석행 
	scolumn VARCHAR(5)  NOT NULL, -- 좌석열
	foreign key (ccode) references cinema_tbl (ccode) -- 상영관 코드(외래키)
    on update cascade on delete set null
	);

-- 좌석데이터 입력    
INSERT INTO seat_tbl (scode ,ccode, srow , scolumn )
VALUES ('J8','004038','1~12','J');
INSERT INTO seat_tbl (scode ,ccode, srow , scolumn )
VALUES ('H9','002204','1~12','H');
INSERT INTO seat_tbl (scode ,ccode, srow , scolumn )
VALUES ('G6','002303','1~12','G');
INSERT INTO seat_tbl (scode ,ccode, srow , scolumn )
VALUES ('F10','012051','1~12','F');

SELECT * FROM seat_tbl;

-- 예매
CREATE TABLE booking_tbl(
	mcode VARCHAR(10), -- 영화코드
	mid VARCHAR(15), -- 회원 아이디 
	bquantity INT not null, -- 예매수량
    btime time not null, -- 상영시간 
	bdate date not null, -- 예매일자 
	scode VARCHAR(10), -- 좌석코드
	bcode VARCHAR(10) primary key, -- 예매번호 (기본키)
	bpoint int, -- 포인트 점수
	foreign key (mcode) references movie_tbl (mcode) -- 영화코드(외래키)
    on update cascade on delete set null,
	foreign key (mid) references member_tbl (mid) -- 회원아이디(외래키)
    on update cascade on delete set null,
	foreign key (scode) references seat_tbl (scode) -- 좌석코드(외래키)
    on update cascade on delete set null
	);

-- 예매데이터 입력
	INSERT INTO  booking_tbl(mcode,mid,bquantity,btime,bdate,scode,bcode,bpoint)
    values('20231496D','park01',1,'11:00','2023-09-13','J8','51232',1000);
    update cinema_tbl c join movie_tbl m on c.ccode = m.ccode join booking_tbl b on m.mcode = b.mcode set c.cseat = c.cseat - b.bquantity where c.ccode = '004038';
    UPDATE member_tbl m JOIN booking_tbl b ON m.mid = b.mid SET m.mpoint = m.mpoint + b.bpoint WHERE m.mid = 'park01';
    insert into  booking_tbl(mcode,mid,bquantity,btime,bdate,scode,bcode,bpoint)
    values('20183782D','beck01',10,'12:30','2023-10-11','H9','12684',2000);
    update cinema_tbl c join movie_tbl m on c.ccode = m.ccode join booking_tbl b on m.mcode = b.mcode set c.cseat = c.cseat - b.bquantity where c.ccode = '002204';
    UPDATE member_tbl m JOIN booking_tbl b ON m.mid = b.mid SET m.mpoint = m.mpoint + b.bpoint WHERE m.mid = 'beck01';
    insert into  booking_tbl(mcode,mid,bquantity,btime,bdate,scode,bcode,bpoint)
    values('20126674D','kim01',20,'14:25','2023-12-31','G6','51212',3000);
    update cinema_tbl c join movie_tbl m on c.ccode = m.ccode join booking_tbl b on m.mcode = b.mcode set c.cseat = c.cseat - b.bquantity where c.ccode = '002303';
    UPDATE member_tbl m JOIN booking_tbl b ON m.mid = b.mid SET m.mpoint = m.mpoint + b.bpoint WHERE m.mid = 'kim01';
    insert into  booking_tbl(mcode,mid,bquantity,btime,bdate,scode,bcode,bpoint)
    values('20228555D','lee01',5,'09:00','2023-11-11','F10','45452',4000);
    update cinema_tbl c join movie_tbl m on c.ccode = m.ccode join booking_tbl b on m.mcode = b.mcode set c.cseat = c.cseat - b.bquantity where c.ccode = '012051';
    UPDATE member_tbl m JOIN booking_tbl b ON m.mid = b.mid SET m.mpoint = m.mpoint + b.bpoint WHERE m.mid = 'lee01';


-- 결제
create table pay_tbl(
	pcode VARCHAR(40) PRIMARY KEY, -- 승인번호(기본키)
    bcode VARCHAR(10), -- 예매번호
    psum INT not null, -- 결제금액
    pmethod VARCHAR(40) not null, -- 결제수단
    pdate VARCHAR(20) not null, -- 결제날짜
    foreign key (bcode) references booking_tbl (bcode) -- 예매번호(외래키)
	);
    
-- pay데이터 입력
INSERT INTO pay_tbl (pcode, bcode, psum, pmethod, pdate)
VALUES ('8456', '51232', 900, '현금', '2023-09-01 21:30:00');
INSERT INTO pay_tbl (pcode, bcode, psum, pmethod, pdate)
VALUES ('9744', '12684', 1500, '카드', '2023-04-01 19:30:00');
INSERT INTO pay_tbl (pcode, bcode, psum, pmethod, pdate)
VALUES ('4685', '51212', 1500, '현금', '2023-04-01 21:30:00');
INSERT INTO pay_tbl (pcode, bcode, psum, pmethod, pdate)
VALUES ('8465', '45452', 1500, '카드', '2023-04-01 21:30:00');
INSERT INTO pay_tbl (pcode, bcode, psum, pmethod, pdate)
VALUES ('4474', '51232', 1500, '카드', '2023-04-01 21:30:00');
INSERT INTO pay_tbl (pcode, bcode, psum, pmethod, pdate)
VALUES ('3975', '45452', 1500, '카드', '2023-04-01 21:30:00');

SELECT * FROM pay;

-- 결제 수단
create table method_tbl(
	bank varchar(40), -- 계좌이체
    card varchar(40), -- 카드결제 
	pcode varchar(40), -- 승인번호
    foreign key (pcode) references pay_tbl(pcode) -- 승인번호(외래키)
    on update cascade on delete set null
    );

-- 결제수단데이터 입력    
insert into method_tbl(bank, card, pcode)
values (1111-11-111-1111, null, '8456');
insert into method_tbl(bank, card, pcode)
values (null, 1111-1111-1111-1111, '9744');
insert into method_tbl(bank, card, pcode)
values (22-2222-2222-22, null, '4685');
insert into method_tbl(bank, card, pcode)
values (null, 3333-3333-1111-2222, '8465');
insert into method_tbl(bank, card, pcode)
values (null, 2222-1111-2222-1111, '4474');
insert into method_tbl(bank, card, pcode)
values (null, 4444-3333-2222-1111, '3975');
    
-- 취소수단    
create table cancel_tbl(
	partc varchar(40), -- 부분취소
    allc varchar(40), -- 전체취소
    pcode varchar(40), -- 승인번호 
    foreign key (pcode) references pay_tbl (pcode) -- 승인번호(외래키)
    on update cascade on delete set null
    );
    
-- 취소수단 데이터 입력    
insert into cancel_tbl(partc, allc, pcode)
values ('Y', NULL, '8456');
DELETE FROM method_tbl WHERE pcode = '8456';
insert into cancel_tbl(partc, allc, pcode)
values (null, 'Y', '3975');
DELETE FROM method_tbl WHERE pcode = '3975';
DELETE FROM pay_tbl WHERE pcode = '3975';
update cinema_tbl c join movie_tbl m on c.ccode = m.ccode join booking_tbl b on m.mcode = b.mcode set c.cseat = c.cseat + b.bquantity where c.ccode = '012051';
UPDATE member_tbl m JOIN booking_tbl b ON m.mid = b.mid SET m.mpoint = m.mpoint - b.bpoint WHERE m.mid = 'lee01';


rollback;
commit;