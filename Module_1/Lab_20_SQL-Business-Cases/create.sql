create database Lab_20;

use Lab_20;
create table cars(
vin_num varchar(20),
manufac varchar(10),
model varchar(20),
caryear int,
color varchar(10));
create table customers(
cst_id int,
cst_name varchar(20),
phone varchar(20),
address varchar(20),
city varchar(10),
state varchar(20),
country varchar(20),
postal int);
create table salespersons(
staff_id int,
store varchar(20),
staff_name varchar(20));
create table invoices(
innum int,
indate date,
incar int,
cust int,
sperson int);