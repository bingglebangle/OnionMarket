commit;

----------------------------------------------------------------
-- onion 
-- 사용자 테이블
CREATE TABLE userInfo (
    Userid VARCHAR2(15) PRIMARY KEY,         -- 사용자 아이디
    Uname VARCHAR2(50) NOT NULL,             -- 사용자 이름
    Upwd VARCHAR2(200) NOT NULL,             -- 사용자 비밀번호 (해시된 형태로 저장)
    Ugender VARCHAR2(10) NOT NULL,           -- 사용자 성별
    Ujumin1 VARCHAR2(13) NOT NULL,           -- 사용자 주민번호1 (문자열로 저장)
    Ujumin2 VARCHAR2(13) NOT NULL,           -- 사용자 주민번호2 (문자열로 저장)
    Utel1 VARCHAR2(5) NOT NULL,              -- 사용자 전화번호1(예: 010,011..)
    Utel2 VARCHAR2(4) NOT NULL,              -- 사용자 전화번호2 (가운데번호 4자리)
    Utel3 VARCHAR2(4) NOT NULL,              -- 사용자 전화번호3 (끝번호 4자리)
    Uaddr VARCHAR2(100) NOT NULL,            -- 사용자 주소
    Uemail1 VARCHAR2(50) NOT NULL,           -- 사용자 이메일1 (@앞부분)
    Uemail2 VARCHAR2(50) NOT NULL,           -- 사용자 이메일2 (@뒷부분)
    Ulogtime DATE,                           -- 계정 생성 날짜
    is_active CHAR(1) DEFAULT 'Y',           -- 계정 활성화 상태
    last_login_time DATE,                    -- 마지막 로그인 시간
    profile_image VARCHAR2(255),             -- 프로필 사진 경로
    role VARCHAR2(50) NOT NULL               -- 사용자 권한 (예: ROLE_USER, ROLE_ADMIN)
);
select * from userInfo;

----------------------------------------------------------------
-- 게시판 등록(중고상품 등록) 테이블
create table boardinfo (
    Bseq number,                            -- 글번호
    Bid varchar2(30) NOT NULL,              -- 글작성자 아이디
    Bname varchar2(30) NOT NULL,            -- 글작성자
    Bsub varchar2(255) NOT NULL,            -- 글제목
    Bcon varchar2(4000) NOT NULL,           -- 글내용
    BPrc varchar2(255) Not null,            -- 글 가격 
    Bcategory varchar2(100) NOT NULL,       -- 글 카테고리
    Bimg varchar2(100) NOT NULL,            -- 글 첨부 이미지
    Blike number NOT NULL,                  -- 글 좋아요 수
    Bhit number NOT NULL,                   -- 글 조회수
    Blogtime date,                          -- 글 작성일
    primary key(Bseq),
     FOREIGN KEY (Bid) REFERENCES userInfo(Userid)  -- 외래 키 설정
);
create sequence seq_boardinfo nocycle nocache;

select * from boardinfo;

INSERT INTO boardinfo VALUES (seq_boardinfo.nextval, 'choi', '최지우', '삼성 컴퓨터 본체 팝니다', '더이상 쓸일이 없어서 팔아요 노량진 역1번 출구에서 거래', '690000', '디지털기기', '컴퓨터.jpg', 10, 16, TO_DATE('24/09/23', 'YY/MM/DD'));


commit;
----------------------------------------------------------------
-- 카테고리 큰 틀 
CREATE TABLE Categorygroups(
    groupseq number primary key,
    groupname VARCHAR(255)
    );
-- 카테고리 시퀀스 객체 생성
create sequence seq_Categorygroups nocycle nocache;
select * from Categorygroups;


-- 중고 거래 카테고리 
CREATE TABLE Boardcategory(
    id number primary key,
    Boardcategory VARCHAR(255),
    Boardcategoryimg varchar(4000),
    groupseq number,
    FOREIGN KEY (groupseq) REFERENCES Categorygroups(groupseq)    
);
-- 중고 거래  시퀀스 객체 생성
create sequence seq_Boardcategory nocycle nocache;
select * from Boardcategory;
insert into Boardcategory values (seq_Boardcategory.nextval ,'디지털기기','computer.png',1);
insert into Boardcategory values (seq_Boardcategory.nextval ,'가구/인테리어','furniture.png',1);
insert into Boardcategory values (seq_Boardcategory.nextval ,'의류/잡화','mcloths.png',1);
insert into Boardcategory values (seq_Boardcategory.nextval ,'생활가전','necessities.png',1);
insert into Boardcategory values (seq_Boardcategory.nextval ,'뷰티','beauty.png',1);
insert into Boardcategory values (seq_Boardcategory.nextval ,'생활/주방','hobby.png',1);
insert into Boardcategory values (seq_Boardcategory.nextval ,'식품','food.png',1);
insert into Boardcategory values (seq_Boardcategory.nextval ,'기타','etc.png',1);
commit;

-- 비즈니스 게시판 카테고리 
CREATE TABLE Bizcategory(
    id number primary key,
    Bizcategory VARCHAR(255),
    groupseq number,
    FOREIGN KEY (groupseq) REFERENCES Categorygroups(groupseq)    
);
-- 비즈니스 카테고리 시퀀시 생성
drop sequence seq_Bizcategory;
create sequence seq_Bizcategory nocycle nocache;

select * from Bizcategory;


---------------------------------------
-- 가게 상품 카테고리 
CREATE TABLE StoreCategory (
    SCseq NUMBER PRIMARY KEY,                 -- 숫자형 기본키
    SCname VARCHAR2(50) NOT NULL ,              -- 카테고리 d
    Bizid Number,
    CONSTRAINT unique_SCname UNIQUE (SCname), -- 카테고리 이름에 대한 중복 방지
    FOREIGN KEY (Bizid) REFERENCES Bizcategory(id)    
);

-- 음식 카테 시퀀시
create sequence seq_StoreCategory nocycle nocache;
select * from StoreCategory;

commit;

-----------------------------------------------------------------
-- 채팅방 테이블
CREATE TABLE chatroom (
    CRroomnum NUMBER PRIMARY KEY,        -- 채팅방 번호
    CRsendid VARCHAR2(15) ,              -- 채팅 수신자 아이디
    CRrecid VARCHAR2(15) ,               -- 채팅 발신자 아이디
    CRlogtime DATE                       -- 채팅방 생성 날짜
);
select * from chatroom;

-- 채팅방 시퀀스 객체 생성
create sequence seq_chatroom nocycle nocache;
SELECT * FROM user_sequences WHERE sequence_name = 'SEQ_CHATROOM';
----------------------------------------------------------------
-- 채팅 메시지 테이블
CREATE TABLE chatmessage (
    CMmsgnum NUMBER PRIMARY KEY,          -- 채팅 메시지 번호
    CMroomnum NUMBER,                     -- 채팅방 번호
    CMsendid VARCHAR2(15),                -- 채팅 아이디
    CMsendmsg VARCHAR2(999),              -- 채팅 메시지 내용
    CMsendtime DATE,                      -- 채팅 메시지 보낸 시간
    FOREIGN KEY (CMroomnum) REFERENCES chatroom(CRroomnum)  -- 외래 키 설정
);
select * from chatmessage;

-- 채팅 메시지  시퀀스 객체 생성
create sequence seq_chatmessage nocycle nocache;
commit;

----------------------------------------------------------------
-- 매니저 테이블
--drop table manager purge;
create table manager (
    Mid varchar2(300) primary key,
    Mpwd varchar2(300),
    Mlogtime Date,
    role VARCHAR2(255 CHAR)
);

select * from manager;



----------------------------------------------------------------
-- 매니저 보드 테이블 

-- 시퀀스 객체 생성
create sequence MBseq_num nocycle nocache;

create table manager_board (
    MBseq number not null,       -- 글번호
    MBid varchar2(30) not null,
    MBsub varchar2(255) not null,
    MBcon varchar2(4000) not null,
    MBimg varchar2(200), 
    MBhit number default 0,      -- 조회수
    MBlogtime date default sysdate -- 작성일
);

select * from manager_board;

----------------------------------------------------------------
-- 판매자 유저 정보

--drop table SaleUser purge;
commit;
create table SaleUser (
    Saleid varchar2(30) primary key,        -- 아이디
    Saletel varchar2(20)not null,           -- 전화번호
    Salepwd varchar2(100) not null,         -- 비밀번호 
    Saleemail varchar2(100) not null,       -- 이메일
    SaleCEO varchar2(100) not null,         -- 대표 이름
    Salecompanyname varchar2(100) not null, -- 상호명
    SaleStorename varchar2(100) not null,   -- 가게명
    Salestoretel varchar(20) not null,      -- 가게 번호
    Saleurl varchar2(4000) ,                -- 가게 url
    Salecategory varchar(200) not null,     -- 음식 카테고리
    Saleimage varchar2(4000)  not null,     -- 가게 이미지
    Saleopen varchar2(10) not null,         -- 가게 오픈 시간
    Saleclose varchar2(10) not null,        -- 가게 종료 시간
    SalebusinessNum varchar2(100) not null, -- 사업자 등록번호
    Saleaddress varchar2(4000) not null,    -- 사업자 주소
    Salebusinessimg varchar(4000) not null, -- 사업자 등록증
    Salelogtime date
);

select * from SaleUser;
delete from saleuser where Saleid='1';
commit;
update SaleUser set Salecategory='취미/클래스' where salepwd ='123';
-------------------------------
--뷰티샵/운동/취미/클래스/학원
-------------------------------------
-- 메뉴 테이블 
CREATE TABLE Menuitems (
    MIid VARCHAR(30) NOT NULL,
    MIseq number PRIMARY KEY ,
    MIitemname VARCHAR(100) NOT NULL,
    MIprice  VARCHAR(100) NOT NULL,
    MIimg VARCHAR(4000) ,
    MIhit number ,
    is_available NUMBER(1) DEFAULT 1,  -- 1을 TRUE로, 0을 FALSE로 사용
    MIlogtime date,
    FOREIGN KEY (MIid) REFERENCES SaleUser(Saleid)
);
select * from Menuitems;

-- 메뉴 시퀀스 객체 생성
create sequence seq_Menuitems nocycle nocache;

---------------
-- 판매자 게시판 
CREATE TABLE Saleboard(
    SBid VARCHAR2(30) NOT NULL,
    SBseq number PRIMARY KEY ,
    SBsubject  VARCHAR2(30) NOT NULL,
    SBcontent  VARCHAR2(4000) NOT NULL,
    SBimg VARCHAR2(4000),
    is_available NUMBER(1) DEFAULT 1,  -- 1을 TRUE로, 0을 FALSE로 사용
    SBlogtime date,
    FOREIGN KEY (SBid) REFERENCES SaleUser(Saleid)
);
delete from Saleboard where SBid='1';

select * from saleboard;
-- 판매자 게시판 시퀀시 
create sequence seq_Saleboard nocycle nocache;

------------------------------------------
select * from Jobboard;
delete from Jobboard where JBid='1';

-- 채용 공고 게시판 
CREATE TABLE Jobboard(
    JBid VARCHAR2(30) not null,            -- 고유 키
    JBseq number primary key,              -- 글번호 (Saleboard 테이블 참조)
    JBsub varchar2(100) not null,
    JBcon varchar(100) not null,
    JBPeoplenum number,                   -- 고용 인원 수
    JBWorkingdate varchar2(1000),         -- 근무 요일
    JBWorkinghours varchar2(1000),        -- 근무 시간
    JBEnddate varchar2(1000),             -- 채용 종료일
    JBSalarytype varchar2(1000),          -- 급여 종류
    JBSalary number,                      -- 급여 금액
    is_available NUMBER(1) DEFAULT 1,  -- 1을 TRUE로, 0을 FALSE로 사용
    JBlogtime Date,
    FOREIGN KEY (JBid) REFERENCES SaleUser(Saleid) -- SaleUser 테이블 참조
);
create sequence seq_Jobboard nocycle nocache;
---------------
-- 커뮤니티 테이블
CREATE TABLE community(
    Cseq number,                            -- 글번호
    Cid varchar2(30) NOT NULL,              -- 글작성 아이디
    Cname varchar2(30) NOT NULL,            -- 글작성자
    Csub varchar2(255) NOT NULL,            -- 글제목
    Ccon varchar2(4000) NOT NULL,           -- 글내용
    Cimg varchar2(100),                     -- 글 첨부 이미지
    Clike number NOT NULL,                  -- 글 좋아요 수
    Chate number NOT NULL,                  -- 글 싫어요 수
    Chit number NOT NULL,                   -- 글 조회수
    Clogtime date,                          -- 글 작성일
    primary key(Cseq)
);
select * from community;

commit;
-----------------------
-- 커뮤니티 댓글 테이블 
CREATE TABLE comments (
    comment_id NUMBER PRIMARY KEY,
    community_id NUMBER,
    user_id VARCHAR2(50),
    content VARCHAR2(1000),
    logtime DATE DEFAULT SYSDATE,
    FOREIGN KEY (community_id) REFERENCES community(cseq)
);
-- 커뮤니티 댓글 시퀀시
CREATE SEQUENCE seq_comment START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-----------------------
--배너
CREATE TABLE banner (
    id NUMBER PRIMARY KEY,
    image_url VARCHAR2(255) NOT NULL,
    title VARCHAR2(255),
    description CLOB,
    is_active NUMBER(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE OR REPLACE TRIGGER banner_update_trg
BEFORE UPDATE ON banner
FOR EACH ROW
BEGIN
    :NEW.updated_at := CURRENT_TIMESTAMP;
END;
/
-- 배너 시퀀시
CREATE SEQUENCE BANNER_SEQSTART WITH 1 INCREMENT BY 1NOCACHE;


-- Step 1: 새로운 열 생성 (임시 열)
ALTER TABLE banner ADD description_temp VARCHAR2(255 CHAR);

-- Step 2: 기존 description 데이터를 새로운 열로 복사
UPDATE banner SET description_temp = DBMS_LOB.SUBSTR(description, 255);

-- Step 3: 기존 열 삭제
ALTER TABLE banner DROP COLUMN description;

-- Step 4: 임시 열을 원래 열 이름으로 변경
ALTER TABLE banner RENAME COLUMN description_temp TO description;