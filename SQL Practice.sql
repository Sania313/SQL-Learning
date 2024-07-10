SQL Practice
create database cutomers;
use customers
-- Table customers
create table customer(
Id int auto_increment primary key,
FirstName varchar(50),
LastName varchar(50),
Age int,
city varchar(50)
)auto_increment=1;
-- Inserting Values in table
insert into customer (FirstName, LastName, Age, city)
values('Sania', 'Syed', 21, 'Islamabad');
insert into customer (FirstName, LastName, Age, city)
values('Shano', 'Naqvi', 23, 'Islamabad');
insert into customer (FirstName, LastName, Age, city)
values('Dania', 'Tres', 23, 'Texas');
insert into customer (FirstName, LastName, Age, city)
values('Aliya', 'Flenzx', 44, 'Houston');
insert into customer (FirstName, LastName, Age, city)
values('Nicholas', 'Tren', 21, 'Lahore');
-- Select and  Where Clause 
select FirstName, Age from customer where age<10;
select FirstName, Age from customer where age = 23;
select distinct FirstName, Age from customer where LastName ='Abbas';
-- Like 
select distinct FirstName, Age from customer where FirstName like '%ni%';
select FirstName,LastName, Age from customer where LastName ='Abbas' and FirstName like 'san__';

-- Update
update customer set Age = 24 where FirstName = 'Shano';
update customer set FirstName = 'Saleena' where LastName = 'fles';

-- Delete
Delete from customer
where FirstName = 'Danita' and Age = 26;

-- Alter Table / Add column
 alter table customer
add City varchar(50);

-- Drop TABLE
 Drop Table customer;
create table payments(
paymentId int auto_increment primary key,
orderid int not null,
custId int not null,
paymentdate datetime,
amount double,
paymentmethod varchar(80),
paymentstatus varchar(20),
foreign key(orderid) references orders(orderid),
foreign key(custId) references customer(Id)
)
select* from payments;
insert into payments(orderid, custId, paymentdate,
amount, paymentmethod, paymentstatus) values(3, 2, now(), 200.2,'online','paid');

insert into payments(orderid, custId, paymentdate,
amount, paymentmethod, paymentstatus) values(2,4, now(), 400.2,'online','unpaid');

insert into payments(orderid, custId, paymentdate,
amount, paymentmethod, paymentstatus) values(5, 3, now(), 300.4,'online','pending');

insert into payments(orderid, custId, paymentdate,
amount, paymentmethod, paymentstatus) values(5, 3, now(), 3000,'cash','unpaid');

insert into payments(orderid, custId, paymentdate,
amount, paymentmethod, paymentstatus) values(1, 5, now(), 2000,'cash','paid');

-- 2nd Part 
-- Product Table
use customers
create table product(
id int auto_increment primary key,
productname varchar(50)
)
-- Inserting values
insert into product(productname) values('Lipstick');
insert into product(productname) values('HIGHLIGHTER');
insert into product(productname) values('Mascara');
insert into product(productname) values('EyeLiner');
insert into product(productname) values('Sunscreen');
select* from product;
-- Add price column
alter table product add price int;
-- update
update product set price = 500;
update product set price = 900 where productname = 'Lipstick';

-- Creating Order Table

create table orders (
orderid int auto_increment primary key,
orderdate datetime,
custId int,
prodId int
);

select* from orders;
-- Foreign keys
alter table orders add foreign key(custId) references customer(Id);
alter table orders add foreign key(prodId) references product(id);

INSERT INTO orders (orderdate, custId, prodId) VALUES 
(now(), 5, 4),
(now(), 3, 3);
 
 select* from customer;
 select* from product;
 select* from orders;
 -- Joins
SELECT c.FirstName, SUM(p.price), AVG(p.price) AS average
FROM orders AS o INNER JOIN product AS p ON o.prodId = p.id
    INNER JOIN customer AS c ON o.custId = c.Id GROUP BY c.FirstName;
    
 select c.FirstName, c.city, o.orderid, o.orderdate,
 p.productname, p.price from orders AS o inner join customer as c On 
 o.orderid = c.Id inner join product as p on o.orderid = p.id;
 
 -- Aggregate function
--  use customers;
select count(*)from product where price > 500 ; 
select max(price) from product;
select min(price) from product;
select sum(price) as totalprice from product;
select avg(price) as averageprice from product;
-- Group by and Having
select price, count(productname)from product where price = 500 group by  price;
select price, count(productname)from product where price = 500 group by price having count(price) = 1;

-- Views
create or replace view paymentreport as
select c.Age, c.FirstName as FullName ,c.Id, o.orderid, o.orderdate, py.paymentId, py.paymentstatus,
py.paymentdate from orders as o inner join customer as c on o.orderid= c.ID 
inner join payments as py on o.orderid=py.paymentId;

-- changing views column name
alter view paymentreport rename column paymentstatus to PaymentStatus; -- thats for postgresql
alter view paymentreport rename to paymentRepo; -- renaming a view in postgre sql

-- droping a view
drop view paymentreport;
select * from paymentreport;

-- Stored Procedure without parameters
DELIMITER //
CREATE PROCEDURE insertion()
BEGIN
    SELECT city FROM customer;
END //
DELIMITER ;
Call insertion();

DELIMITER //
 CREATE PROCEDURE deleterows()
 begin
 delete from customer where city= 'Islamabad';
 END //
 DELIMITER ;

 Call deleterows();
 
 -- Dropping a procedure
  DROP procedure IF exists parameterized;
  
 -- Stored procedures with parameters
 
DELIMITER //
CREATE PROCEDURE parameterized(IN inputcity varchar(50))
BEGIN
select FirstName from customer as c where c.city = inputcity;
END //
DELIMITER ;
 Call parameterized('Islamabad');
 
-- input and output parameters
DELIMITER //
CREATE PROCEDURE getcount(IN inputcity varchar(50), OUT custCount int)
BEGIN
select count(*) from customer as c where c.city = inputcity;
END //
DELIMITER ; 
CALL getcount('Islamabad', @custCount);

DELIMITER //
create procedure MAXSALES(Tsales int)
begin
select sum(amount) into Tsales from payments  where paymentmenthod ='online';
end //
delimiter ;
drop procedure if exists MAXSALES;
call MAXSALES(@Tsales);
select* from MAXSALES as maximumSales;
-- Triggers in SQL

-- before insert table
create table address(
addId int auto_increment primary key,
province varchar(80),
postalcode int,
country varchar(50)
)

delimiter //
create trigger checkPostalCode
before insert on address
for each row
if new.postalcode < 0 then set new.postalcode = 5666;
end if; //

insert into address (province, postalcode,country) 
values('Rfah',8999,'Palestine'),
('Isl', -1 ,'Pakistan'),
('Mashad',14455,'Iran'),
('Berlin',-0.44,'Luxembourg');
-- dropping trigger 
drop trigger checkPostalCode;
select * from address;

-- Problem solving
delimiter //
create procedure printmsg()
begin
if payments.paymentstatus 
end //
delimiter ;
 -- DCL COMMANDS
 -- GRANT 
 -- Here I have created another user Finance user and I will grant him permission to select from paymenst table
 grant select on payments to FinanceUser;
 -- granting insert and other permmissions to FinanceUser
 grant select,insert, update,delete on payments to FinanceUser;
-- Revoking some permisions from FinanceUser
revoke delete on payments from FinanceUser;

-- 3rd part

use customers;
select * from payments;
select * from customer;
insert into payments(orderid, custId, paymentdate,
amount, paymentmethod, paymentstatus) values(1,4, now(), 500.2,'online','unpaid');
-- max payment using window function
                                            --    ##### ROW_NUMBER() ######
select o.*, max(amount) over(partition by orderid) as maximumorders from payments o;
-- row number 
select p.*, row_number()  over(partition by orderid) as rn from payments as p;

-- Fetch first 2 order that are placed w.r.t order Id
select * from (
select p.*, row_number()  over(partition by orderid order by paymentId)
 as rn from payments as p) x where x.rn <3;
                                            --    ##### RANK ######
/* I have create a table emp , with id, emp name,department name, salary)
 -- Fetching maximum salaries of the top 2 employees in each department with maximum salary */
 create table emp(
empId INT primary key,
emp_name varchar(50),
dept_name Varchar(60),
salary int
);

insert into emp (empId,emp_name, dept_name, salary)
values (101,'Sania','DBA',80000),
 (102,'Zadde','Admin',60000),
 (105,'Fenx','DBA',98000),
 (106,'Saneya','HR',35000),
 (108,'Gearge','Admin',40000),
 (104,'Alex','Finanace',85000),
 (109,'Swan','Finance',100000),
 (111,'David','HSE',90000),
 (141,'Anezala','HSE',80000),
 (171,'Rosie','Technician',16000),
 (131,'Lina','Technician',10000),
 (161,'Aaron','HR',22000);
 
 --     RANK()

 select * from emp;
 select* from(
 select e.*, rank() over(partition by dept_name order by salary desc) as rnk from emp as e) x 
 where x.rnk <3; 

--                                      DENSE RANK
-- It is similar to rank() nut it does not skip a value for duplicate records
select e.*, rank() over(partition by dept_name order by salary desc) as rnk,
 DENSErank() over(partition by dept_name order by salary desc) as denernk,
 row_number() over(partition by dept_name order by salary desc) as rn
  from emp as e;

   -- LAG() AND LEAD
  -- getting the records in which the salary of emp is higher or lower or equal to previous
  
  select e.*, lag(salary, 1, 0) over( partition by dept_name order by empId desc) as previous_salary
  from emp e;
  -- this 1 is the number of rows that we need to check for the previous record , 0 is default value
  select e.*, lag(salary) over( partition by dept_name order by empId desc) 
  as previous_salary,
  lead(salary) over( partition by dept_name order by empId desc) 
  as next_salary
  from emp e;
  
  -- Case if salary of current emp is higher lower or equal then previous emp 
  
select e.*, lag(salary) over( partition by dept_name order by empId desc) 
  as previous_salary ,
  case when e.salary >  lag(salary) over( partition by dept_name order by empId desc) then 'Higher'
  when e.salary <  lag(salary) over( partition by dept_name order by empId desc) then 'Lower Salary'
  when e.salary =  lag(salary) over( partition by dept_name order by empId desc) then 'Same Salary' 
  end Sal_Range
  from emp e;
  
/* Windows Function
To get the most expensive product from all the categories */
-- FIRST_VALUE
select *, first_value(prod_name) over( partition by prod_category order by price desc) as
Most_Expensive_Product from
products;
/*
LAST_VALUE
To get the most expensive product from all the categories */
select *,first_value(prod_name) over( partition by prod_category order by price desc) as
Most_Expensive_Product, last_value(prod_name) over(partition by prod_category order by price desc)
 as Least_Expensive_Prod
from products;
-- DEFAULT Frame Clause
select *,
last_value(prod_name)
over(partition by prod_category order by
price ASC range between unbounded preceding and unbounded following) 
 as Least_Expensive_Prod from products;
-- range tells range of record that last_value needs to consider
-- unbounded preceding for checking from 1st row to end 
-- unbounded following -- to the end

-- Another way to write window queries
select *,first_value(prod_name) over w as
Most_Expensive_Product, last_value(prod_name) over w
as Least_Expensive_Prod
from products window  w as
(partition by prod_category order by price desc range between unbounded preceding and unbounded following );
-- Nth_Value to extract from a position

-- Query to Extract second most expensive product under each category
select *,
nth_value(prod_name, 2) over w as second_expensive_product
from products window  w as
(partition by prod_category order by price
 desc range between unbounded preceding and unbounded following );

-- NTILE 
-- NTILE GROUP / SEGREGATE DATA INTO DIFFERENT GROUPS
-- Query to segregate all skin care products in expensive normal and least range
Select prod_name, prod_category, 
case when x.buckets= 1 then 'Most Expensive Product'
	 when x.buckets = 2 then 'Moderate'
	 when x.buckets = 3 then 'Least Expensive' END Category
from (select* ,
ntile(3) over(order by price desc) as buckets
from products where prod_category ='Body') x ;
