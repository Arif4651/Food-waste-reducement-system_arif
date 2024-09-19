-- Create Manager table
CREATE TABLE MANAGER (
    MANAGER_ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    EMAIL VARCHAR2(50) CONSTRAINT MANAGER_EMAIL_FORMAT CHECK (REGEXP_LIKE(EMAIL, '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')),
    PASSWORD VARCHAR2(50),
    NAME VARCHAR2(40),
    DATE_OF_BIRTH DATE,
    CITY VARCHAR2(40),
    DISTRICT VARCHAR2(40),
    DIVISION VARCHAR2(40),
    STREETNO VARCHAR2(20),
    PHONE VARCHAR2(20)
);

-- Create Volunteer table
CREATE TABLE VOLUNTEER (
    VOLUNTEER_ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    EMAIL VARCHAR2(50) CONSTRAINT VOLUNTEER_EMAIL_FORMAT CHECK (REGEXP_LIKE(EMAIL, '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')),
    PASSWORD VARCHAR2(100),
    NAME VARCHAR2(40),
    DATE_OF_BIRTH DATE,
    CITY VARCHAR2(40),
    DISTRICT VARCHAR2(40),
    DIVISION VARCHAR2(40),
    STREETNO VARCHAR2(20),
    PHONE VARCHAR2(20)
);
ALTER TABLE Volunteer
ADD AVAILABILITY VARCHAR(255);
-- Create Assign table
CREATE TABLE ASSIGN (
    MANAGER_ID NUMBER,
    VOLUNTEER_ID NUMBER,
    PRIMARY KEY (MANAGER_ID, VOLUNTEER_ID),
    FOREIGN KEY (MANAGER_ID) REFERENCES MANAGER(MANAGER_ID),
    FOREIGN KEY (VOLUNTEER_ID) REFERENCES VOLUNTEER(VOLUNTEER_ID)
);
--adding task to the assign table 
ALTER TABLE ASSIGN
ADD task VARCHAR(25); 


-- Create Donor table
CREATE TABLE DONOR (
    DONOR_ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    EMAIL VARCHAR2(50) CONSTRAINT DONOR_EMAIL_FORMAT CHECK (REGEXP_LIKE(EMAIL, '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')),
    PASSWORD VARCHAR2(100),
    INSTITUTION_NAME VARCHAR2(40),
    INSTITUTION_TYPE VARCHAR2(50),
    CITY VARCHAR2(40),
    DISTRICT VARCHAR2(40),
    DIVISION VARCHAR2(40),
    STREETNO VARCHAR2(20),
    PHONE VARCHAR2(20),
    VERIFIED CHAR(10),
    POINTS NUMBER,
    VOLUNTEER_ID NUMBER,
    DATE_D DATE,
    FOREIGN KEY (VOLUNTEER_ID) REFERENCES VOLUNTEER(VOLUNTEER_ID)
);

-- Create Food table
CREATE TABLE FOOD (
    FOOD_ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    NAME VARCHAR2(40),
    QUANTITY NUMBER,
    EXP_DATE DATE,
    PHOTO BLOB, -- Changed from VARCHAR2 to BLOB for storing images
    VERIFIED CHAR(10),
    VOLUNTEER_ID NUMBER,
    DONOR_ID NUMBER,
    DATE_F DATE,
    FOREIGN KEY (VOLUNTEER_ID) REFERENCES VOLUNTEER(VOLUNTEER_ID),
    FOREIGN KEY (DONOR_ID) REFERENCES DONOR(DONOR_ID)
);

-- do you want to donate or sell 
ALTER TABLE FOOD
ADD SELL_OR_DONATE VARCHAR2(20);
-- Create Get_point table
CREATE TABLE GET_POINT (
    DONOR_ID NUMBER,
    FOOD_ID NUMBER,
    POINTS NUMBER,
    PRIMARY KEY (DONOR_ID, FOOD_ID),
    FOREIGN KEY (DONOR_ID) REFERENCES DONOR(DONOR_ID),
    FOREIGN KEY (FOOD_ID) REFERENCES FOOD(FOOD_ID)
);

-- Create VulnerableCitizen table
CREATE TABLE VULNERABLECITIZEN (
    NID NUMBER PRIMARY KEY,
    NAME VARCHAR2(40),
    DATE_OF_BIRTH DATE,
    CITY VARCHAR2(40),
    DISTRICT VARCHAR2(40),
    DIVISION VARCHAR2(40),
    STREETNO VARCHAR2(20),
    PHONE VARCHAR2(20)
);

ALTER TABLE VULNERABLECITIZEN ADD  PASSWORD VARCHAR2(255) NOT NULL;

-- Create Sells table
CREATE TABLE SELLS (
    DONOR_ID NUMBER,
    NID NUMBER,
    FOOD_ID NUMBER,
    ORIGINAL_PRICE NUMBER,
    DISCOUNTED_PRICE NUMBER,
    DATE_S DATE,
    PRIMARY KEY (DONOR_ID, NID, FOOD_ID),
    FOREIGN KEY (DONOR_ID) REFERENCES DONOR(DONOR_ID),
    FOREIGN KEY (NID) REFERENCES VULNERABLECITIZEN(NID),
    FOREIGN KEY (FOOD_ID) REFERENCES FOOD(FOOD_ID)
);

-- Create Recipient table
CREATE TABLE RECIPIENT (
    RECIPIENT_ID NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    EMAIL VARCHAR2(50) CONSTRAINT RECIPIENT_EMAIL_FORMAT CHECK (REGEXP_LIKE(EMAIL, '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')),
    PASSWORD VARCHAR2(100),
    INSTITUTION_NAME VARCHAR2(40),
    INSTITUTION_TYPE VARCHAR2(50),
    CITY VARCHAR2(40),
    DISTRICT VARCHAR2(40),
    DIVISION VARCHAR2(40),
    STREETNO VARCHAR2(20),
    PHONE VARCHAR2(20),
    NUMBER_OF_PEOPLE NUMBER,
    VOLUNTEER_ID NUMBER,
    DATE_R DATE,
    VERIFIED CHAR(10),
    FOREIGN KEY (VOLUNTEER_ID) REFERENCES VOLUNTEER(VOLUNTEER_ID)
);


-- Create Receives table
CREATE TABLE RECEIVES (
    MANAGER_ID NUMBER,
    FOOD_ID NUMBER,
    RECIPIENT_ID NUMBER,
    DATE_RECEIVES DATE,
    PRIMARY KEY (MANAGER_ID, FOOD_ID, RECIPIENT_ID),
    FOREIGN KEY (MANAGER_ID) REFERENCES MANAGER(MANAGER_ID),
    FOREIGN KEY (FOOD_ID) REFERENCES FOOD(FOOD_ID),
    FOREIGN KEY (RECIPIENT_ID) REFERENCES RECIPIENT(RECIPIENT_ID)
);

desc donor;

DROP TABLE MANAGER CASCADE CONSTRAINTS;

DROP TABLE MOON CASCADE CONSTRAINTS;

DROP TABLE VOLUNTEER CASCADE CONSTRAINTS;

DROP TABLE ASSIGN CASCADE CONSTRAINTS;

DROP TABLE DONOR CASCADE CONSTRAINTS;

DROP TABLE FOOD CASCADE CONSTRAINTS;

DROP TABLE GET_POINT CASCADE CONSTRAINTS;

DROP TABLE VULNERABLECITIZEN CASCADE CONSTRAINTS;

DROP TABLE SELLS CASCADE CONSTRAINTS;

DROP TABLE RECIPIENT CASCADE CONSTRAINTS;

DROP TABLE RECEIVES CASCADE CONSTRAINTS;

SELECT
    *
FROM
    MANAGER;

SELECT
    *
FROM
    VOLUNTEER;

SELECT
    *
FROM
    ASSIGN;

SELECT
    *
FROM
    DONOR;

SELECT
    *
FROM
    FOOD;

SELECT
    *
FROM
    GET_POINT;

SELECT
    *
FROM
    VULNERABLECITIZEN;

SELECT
    *
FROM
    SELLS;

SELECT
    *
FROM
    RECIPIENT;

SELECT
    *
FROM
    RECEIVES;

SELECT
    'DROP TABLE '
    || TABLE_NAME
    || ' CASCADE CONSTRAINTS;'
FROM
    USER_TABLES;

SELECT
    'SELECT * FROM '
    || TABLE_NAME
    || ';'
FROM
    USER_TABLES;

CONNECT admin/admin@localhost:8080