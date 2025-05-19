 DROP DATABASE IF EXISTS carrentalsystem;
create database carrentalsystem;
use carrentalsystem;
show databases; 
 
CREATE TABLE CUSTOMER
( aadhar_no char(12) NOT NULL,
 DL_NUMBER CHAR(8) NOT NULL,
  FNAME VARCHAR(25) NOT NULL,
  LNAME VARCHAR(25) NOT NULL,
  PHONE_NUMBER DEC(10) NOT NULL,
  EMAIL_ID VARCHAR(30) NOT NULL,
  PASSWORD_ VARCHAR(256) NOT NULL,
  CONSTRAINT CUSTOMERPK
  PRIMARY KEY (aadhar_no)
);

CREATE TABLE CAR
(plate_id varchar(8),
 model VARCHAR(32) NOT NULL,
  make VARCHAR(32) NOT NULL,
  year_ VARCHAR(25) NOT NULL,
   price VARCHAR(25) NOT NULL, 
   registration_date DATE NOT NULL,
   office_id VARCHAR(25) NOT NULL, 
  CONSTRAINT PLATEIDPK
  PRIMARY KEY (plate_id)
);

CREATE TABLE CUSTOMER_CREDIT
( aadhar_no CHAR(4) NOT NULL,
  card_no CHAR(4) NOT NULL,
  CONSTRAINT AADHARNOPK
  PRIMARY KEY (aadhar_no)
);

CREATE TABLE office
( office_id varchar(4) NOT NULL,
  name_ CHAR(4) NOT NULL,
  email  VARCHAR(25) NOT NULL,
  phone_no  DATE NOT NULL,
  password_  DEC(4,2)  NOT NULL,
  CONSTRAINT officeidpk
  PRIMARY KEY (office_id)
);

CREATE TABLE Reservation
(  reservation_no varchar(4) NOT NULL,
   aadhar_no CHAR(4) NOT NULL,
   plate_id varchar(8),
   reservation_date DATE,
   pickup_date Date,
   return_date date,
   payment_date date,
  CONSTRAINT reservationnopk
  PRIMARY KEY (reservation_no),
  CONSTRAINT aadhanosk
  UNIQUE (aadhar_no)
);

CREATE TABLE car_status
( plate_id varchar(8),
  status_code varchar(8),
  status_date varchar(8),
  CONSTRAINT plateidpk
  PRIMARY KEY (plate_id)
);

CREATE TABLE credit_card
(card_no varchar(8),
 holder_name char(32),
 cvv varchar(3),
 exp_date date,
  CONSTRAINT card_no
  PRIMARY KEY (card_no)

);


