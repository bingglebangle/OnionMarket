commit;

----------------------------------------------------------------
-- onion 
-- ����� ���̺�
CREATE TABLE userInfo (
    Userid VARCHAR2(15) PRIMARY KEY,         -- ����� ���̵�
    Uname VARCHAR2(50) NOT NULL,             -- ����� �̸�
    Upwd VARCHAR2(200) NOT NULL,             -- ����� ��й�ȣ (�ؽõ� ���·� ����)
    Ugender VARCHAR2(10) NOT NULL,           -- ����� ����
    Ujumin1 VARCHAR2(13) NOT NULL,           -- ����� �ֹι�ȣ1 (���ڿ��� ����)
    Ujumin2 VARCHAR2(13) NOT NULL,           -- ����� �ֹι�ȣ2 (���ڿ��� ����)
    Utel1 VARCHAR2(5) NOT NULL,              -- ����� ��ȭ��ȣ1(��: 010,011..)
    Utel2 VARCHAR2(4) NOT NULL,              -- ����� ��ȭ��ȣ2 (�����ȣ 4�ڸ�)
    Utel3 VARCHAR2(4) NOT NULL,              -- ����� ��ȭ��ȣ3 (����ȣ 4�ڸ�)
    Uaddr VARCHAR2(100) NOT NULL,            -- ����� �ּ�
    Uemail1 VARCHAR2(50) NOT NULL,           -- ����� �̸���1 (@�պκ�)
    Uemail2 VARCHAR2(50) NOT NULL,           -- ����� �̸���2 (@�޺κ�)
    Ulogtime DATE,                           -- ���� ���� ��¥
    is_active CHAR(1) DEFAULT 'Y',           -- ���� Ȱ��ȭ ����
    last_login_time DATE,                    -- ������ �α��� �ð�
    profile_image VARCHAR2(255),             -- ������ ���� ���
    role VARCHAR2(50) NOT NULL               -- ����� ���� (��: ROLE_USER, ROLE_ADMIN)
);
select * from userInfo;

----------------------------------------------------------------
-- �Խ��� ���(�߰��ǰ ���) ���̺�
create table boardinfo (
    Bseq number,                            -- �۹�ȣ
    Bid varchar2(30) NOT NULL,              -- ���ۼ��� ���̵�
    Bname varchar2(30) NOT NULL,            -- ���ۼ���
    Bsub varchar2(255) NOT NULL,            -- ������
    Bcon varchar2(4000) NOT NULL,           -- �۳���
    BPrc varchar2(255) Not null,            -- �� ���� 
    Bcategory varchar2(100) NOT NULL,       -- �� ī�װ�
    Bimg varchar2(100) NOT NULL,            -- �� ÷�� �̹���
    Blike number NOT NULL,                  -- �� ���ƿ� ��
    Bhit number NOT NULL,                   -- �� ��ȸ��
    Blogtime date,                          -- �� �ۼ���
    primary key(Bseq),
     FOREIGN KEY (Bid) REFERENCES userInfo(Userid)  -- �ܷ� Ű ����
);
create sequence seq_boardinfo nocycle nocache;

select * from boardinfo;

INSERT INTO boardinfo VALUES (seq_boardinfo.nextval, 'choi', '������', '�Ｚ ��ǻ�� ��ü �˴ϴ�', '���̻� ������ ��� �Ⱦƿ� �뷮�� ��1�� �ⱸ���� �ŷ�', '690000', '�����б��', '��ǻ��.jpg', 10, 16, TO_DATE('24/09/23', 'YY/MM/DD'));


commit;
----------------------------------------------------------------
-- ī�װ� ū Ʋ 
CREATE TABLE Categorygroups(
    groupseq number primary key,
    groupname VARCHAR(255)
    );
-- ī�װ� ������ ��ü ����
create sequence seq_Categorygroups nocycle nocache;
select * from Categorygroups;


-- �߰� �ŷ� ī�װ� 
CREATE TABLE Boardcategory(
    id number primary key,
    Boardcategory VARCHAR(255),
    Boardcategoryimg varchar(4000),
    groupseq number,
    FOREIGN KEY (groupseq) REFERENCES Categorygroups(groupseq)    
);
-- �߰� �ŷ�  ������ ��ü ����
create sequence seq_Boardcategory nocycle nocache;
select * from Boardcategory;
insert into Boardcategory values (seq_Boardcategory.nextval ,'�����б��','computer.png',1);
insert into Boardcategory values (seq_Boardcategory.nextval ,'����/���׸���','furniture.png',1);
insert into Boardcategory values (seq_Boardcategory.nextval ,'�Ƿ�/��ȭ','mcloths.png',1);
insert into Boardcategory values (seq_Boardcategory.nextval ,'��Ȱ����','necessities.png',1);
insert into Boardcategory values (seq_Boardcategory.nextval ,'��Ƽ','beauty.png',1);
insert into Boardcategory values (seq_Boardcategory.nextval ,'��Ȱ/�ֹ�','hobby.png',1);
insert into Boardcategory values (seq_Boardcategory.nextval ,'��ǰ','food.png',1);
insert into Boardcategory values (seq_Boardcategory.nextval ,'��Ÿ','etc.png',1);
commit;

-- ����Ͻ� �Խ��� ī�װ� 
CREATE TABLE Bizcategory(
    id number primary key,
    Bizcategory VARCHAR(255),
    groupseq number,
    FOREIGN KEY (groupseq) REFERENCES Categorygroups(groupseq)    
);
-- ����Ͻ� ī�װ� ������ ����
drop sequence seq_Bizcategory;
create sequence seq_Bizcategory nocycle nocache;

select * from Bizcategory;


---------------------------------------
-- ���� ��ǰ ī�װ� 
CREATE TABLE StoreCategory (
    SCseq NUMBER PRIMARY KEY,                 -- ������ �⺻Ű
    SCname VARCHAR2(50) NOT NULL ,              -- ī�װ� d
    Bizid Number,
    CONSTRAINT unique_SCname UNIQUE (SCname), -- ī�װ� �̸��� ���� �ߺ� ����
    FOREIGN KEY (Bizid) REFERENCES Bizcategory(id)    
);

-- ���� ī�� ������
create sequence seq_StoreCategory nocycle nocache;
select * from StoreCategory;

commit;

-----------------------------------------------------------------
-- ä�ù� ���̺�
CREATE TABLE chatroom (
    CRroomnum NUMBER PRIMARY KEY,        -- ä�ù� ��ȣ
    CRsendid VARCHAR2(15) ,              -- ä�� ������ ���̵�
    CRrecid VARCHAR2(15) ,               -- ä�� �߽��� ���̵�
    CRlogtime DATE                       -- ä�ù� ���� ��¥
);
select * from chatroom;

-- ä�ù� ������ ��ü ����
create sequence seq_chatroom nocycle nocache;
SELECT * FROM user_sequences WHERE sequence_name = 'SEQ_CHATROOM';
----------------------------------------------------------------
-- ä�� �޽��� ���̺�
CREATE TABLE chatmessage (
    CMmsgnum NUMBER PRIMARY KEY,          -- ä�� �޽��� ��ȣ
    CMroomnum NUMBER,                     -- ä�ù� ��ȣ
    CMsendid VARCHAR2(15),                -- ä�� ���̵�
    CMsendmsg VARCHAR2(999),              -- ä�� �޽��� ����
    CMsendtime DATE,                      -- ä�� �޽��� ���� �ð�
    FOREIGN KEY (CMroomnum) REFERENCES chatroom(CRroomnum)  -- �ܷ� Ű ����
);
select * from chatmessage;

-- ä�� �޽���  ������ ��ü ����
create sequence seq_chatmessage nocycle nocache;
commit;

----------------------------------------------------------------
-- �Ŵ��� ���̺�
--drop table manager purge;
create table manager (
    Mid varchar2(300) primary key,
    Mpwd varchar2(300),
    Mlogtime Date,
    role VARCHAR2(255 CHAR)
);

select * from manager;



----------------------------------------------------------------
-- �Ŵ��� ���� ���̺� 

-- ������ ��ü ����
create sequence MBseq_num nocycle nocache;

create table manager_board (
    MBseq number not null,       -- �۹�ȣ
    MBid varchar2(30) not null,
    MBsub varchar2(255) not null,
    MBcon varchar2(4000) not null,
    MBimg varchar2(200), 
    MBhit number default 0,      -- ��ȸ��
    MBlogtime date default sysdate -- �ۼ���
);

select * from manager_board;

----------------------------------------------------------------
-- �Ǹ��� ���� ����

--drop table SaleUser purge;
commit;
create table SaleUser (
    Saleid varchar2(30) primary key,        -- ���̵�
    Saletel varchar2(20)not null,           -- ��ȭ��ȣ
    Salepwd varchar2(100) not null,         -- ��й�ȣ 
    Saleemail varchar2(100) not null,       -- �̸���
    SaleCEO varchar2(100) not null,         -- ��ǥ �̸�
    Salecompanyname varchar2(100) not null, -- ��ȣ��
    SaleStorename varchar2(100) not null,   -- ���Ը�
    Salestoretel varchar(20) not null,      -- ���� ��ȣ
    Saleurl varchar2(4000) ,                -- ���� url
    Salecategory varchar(200) not null,     -- ���� ī�װ�
    Saleimage varchar2(4000)  not null,     -- ���� �̹���
    Saleopen varchar2(10) not null,         -- ���� ���� �ð�
    Saleclose varchar2(10) not null,        -- ���� ���� �ð�
    SalebusinessNum varchar2(100) not null, -- ����� ��Ϲ�ȣ
    Saleaddress varchar2(4000) not null,    -- ����� �ּ�
    Salebusinessimg varchar(4000) not null, -- ����� �����
    Salelogtime date
);

select * from SaleUser;
delete from saleuser where Saleid='1';
commit;
update SaleUser set Salecategory='���/Ŭ����' where salepwd ='123';
-------------------------------
--��Ƽ��/�/���/Ŭ����/�п�
-------------------------------------
-- �޴� ���̺� 
CREATE TABLE Menuitems (
    MIid VARCHAR(30) NOT NULL,
    MIseq number PRIMARY KEY ,
    MIitemname VARCHAR(100) NOT NULL,
    MIprice  VARCHAR(100) NOT NULL,
    MIimg VARCHAR(4000) ,
    MIhit number ,
    is_available NUMBER(1) DEFAULT 1,  -- 1�� TRUE��, 0�� FALSE�� ���
    MIlogtime date,
    FOREIGN KEY (MIid) REFERENCES SaleUser(Saleid)
);
select * from Menuitems;

-- �޴� ������ ��ü ����
create sequence seq_Menuitems nocycle nocache;

---------------
-- �Ǹ��� �Խ��� 
CREATE TABLE Saleboard(
    SBid VARCHAR2(30) NOT NULL,
    SBseq number PRIMARY KEY ,
    SBsubject  VARCHAR2(30) NOT NULL,
    SBcontent  VARCHAR2(4000) NOT NULL,
    SBimg VARCHAR2(4000),
    is_available NUMBER(1) DEFAULT 1,  -- 1�� TRUE��, 0�� FALSE�� ���
    SBlogtime date,
    FOREIGN KEY (SBid) REFERENCES SaleUser(Saleid)
);
delete from Saleboard where SBid='1';

select * from saleboard;
-- �Ǹ��� �Խ��� ������ 
create sequence seq_Saleboard nocycle nocache;

------------------------------------------
select * from Jobboard;
delete from Jobboard where JBid='1';

-- ä�� ���� �Խ��� 
CREATE TABLE Jobboard(
    JBid VARCHAR2(30) not null,            -- ���� Ű
    JBseq number primary key,              -- �۹�ȣ (Saleboard ���̺� ����)
    JBsub varchar2(100) not null,
    JBcon varchar(100) not null,
    JBPeoplenum number,                   -- ��� �ο� ��
    JBWorkingdate varchar2(1000),         -- �ٹ� ����
    JBWorkinghours varchar2(1000),        -- �ٹ� �ð�
    JBEnddate varchar2(1000),             -- ä�� ������
    JBSalarytype varchar2(1000),          -- �޿� ����
    JBSalary number,                      -- �޿� �ݾ�
    is_available NUMBER(1) DEFAULT 1,  -- 1�� TRUE��, 0�� FALSE�� ���
    JBlogtime Date,
    FOREIGN KEY (JBid) REFERENCES SaleUser(Saleid) -- SaleUser ���̺� ����
);
create sequence seq_Jobboard nocycle nocache;
---------------
-- Ŀ�´�Ƽ ���̺�
CREATE TABLE community(
    Cseq number,                            -- �۹�ȣ
    Cid varchar2(30) NOT NULL,              -- ���ۼ� ���̵�
    Cname varchar2(30) NOT NULL,            -- ���ۼ���
    Csub varchar2(255) NOT NULL,            -- ������
    Ccon varchar2(4000) NOT NULL,           -- �۳���
    Cimg varchar2(100),                     -- �� ÷�� �̹���
    Clike number NOT NULL,                  -- �� ���ƿ� ��
    Chate number NOT NULL,                  -- �� �Ⱦ�� ��
    Chit number NOT NULL,                   -- �� ��ȸ��
    Clogtime date,                          -- �� �ۼ���
    primary key(Cseq)
);
select * from community;

commit;
-----------------------
-- Ŀ�´�Ƽ ��� ���̺� 
CREATE TABLE comments (
    comment_id NUMBER PRIMARY KEY,
    community_id NUMBER,
    user_id VARCHAR2(50),
    content VARCHAR2(1000),
    logtime DATE DEFAULT SYSDATE,
    FOREIGN KEY (community_id) REFERENCES community(cseq)
);
-- Ŀ�´�Ƽ ��� ������
CREATE SEQUENCE seq_comment START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-----------------------
--���
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
-- ��� ������
CREATE SEQUENCE BANNER_SEQSTART WITH 1 INCREMENT BY 1NOCACHE;


-- Step 1: ���ο� �� ���� (�ӽ� ��)
ALTER TABLE banner ADD description_temp VARCHAR2(255 CHAR);

-- Step 2: ���� description �����͸� ���ο� ���� ����
UPDATE banner SET description_temp = DBMS_LOB.SUBSTR(description, 255);

-- Step 3: ���� �� ����
ALTER TABLE banner DROP COLUMN description;

-- Step 4: �ӽ� ���� ���� �� �̸����� ����
ALTER TABLE banner RENAME COLUMN description_temp TO description;