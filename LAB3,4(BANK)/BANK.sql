show databases;
create database bank;
use bank;
create table branch(
branch_name varchar(30) primary key,
branch_city varchar(30),
assets real);
create table bankaccount(
acc_no int primary key,
branch_name varchar(30),
balance real,
foreign key (branch_name) references branch(branch_name));
create table bankcustomer(
customer_name varchar(50) primary key,
street varchar(50),
city varchar(50));
create table depositer(
customer_name varchar(50),
acc_no int,
foreign key (customer_name) references bankcustomer(customer_name),
foreign key (acc_no) references bankaccount(acc_no),
primary key(customer_name,acc_no));
create table loan(
loan_number int primary key,
branch_name varchar(50),
amount real,
foreign key(branch_name) references branch(branch_name));
INSERT INTO branch VALUES
('SBI_Chamrajpet', 'Bangalore', 50000),
('SBI_ResidencyRoad', 'Bangalore', 10000),
('SBI_ShivajiRoad', 'Bombay', 20000),
('SBI_ParlimentRoad', 'Delhi', 10000),
('SBI_Jantarmantar', 'Delhi', 20000);
INSERT INTO bankaccount VALUES
(1, 'SBI_Chamrajpet', 2000),
(2, 'SBI_ResidencyRoad', 5000),
(3, 'SBI_ShivajiRoad', 6000),
(4, 'SBI_ParlimentRoad', 9000),
(5, 'SBI_Jantarmantar', 8000),
(6, 'SBI_ShivajiRoad', 4000),
(7, 'SBI_ResidencyRoad', 4000),
(8, 'SBI_ResidencyRoad', 4000),
(9, 'SBI_ParlimentRoad', 3000),
(10, 'SBI_ResidencyRoad', 5000),
(11, 'SBI_Jantarmantar', 2000);
INSERT INTO bankcustomer VALUES
('Avinash', 'Bull_Temple_Road', 'Bangalore'),
('Dinesh', 'Bannerghatta_Road', 'Bangalore'),
('Mohan', 'NationalCollege_Road', 'Bangalore'),
('Nikil', 'Akbar_Road', 'Delhi'),
('Ravi', 'Prithviraj_Road', 'Delhi');
INSERT INTO depositer VALUES
('Avinash', 1),
('Dinesh', 2),
('Nikil', 4),
('Ravi', 5),
('Avinash', 8),
('Nikil', 9),
('Dinesh', 10),
('Nikil', 11);
INSERT INTO Loan VALUES
(1, 'SBI_Chamrajpet', 1000),
(2, 'SBI_ResidencyRoad', 2000),
(3, 'SBI_ShivajiRoad', 3000),
(4, 'SBI_ParlimentRoad', 4000),
(5, 'SBI_Jantarmantar', 5000);
SELECT c.customer_name
FROM bankcustomer AS c
WHERE (
    SELECT COUNT(d.customer_name)
    FROM depositer AS d
    WHERE d.customer_name = c.customer_name
      AND d.acc_no IN (
          SELECT ba.acc_no
          FROM bankaccount AS ba
          WHERE ba.branch_name = 'SBI_ResidencyRoad'
      )
) >= 2;
SELECT d.customer_name
FROM depositer as d, bankaccount
WHERE d.acc_no = bankaccount.acc_no
  AND bankaccount.branch_name IN (
    SELECT branch_name
    FROM branch
    WHERE branch_city = 'Delhi'
  )
  GROUP BY d.customer_name
  HAVING COUNT(DISTINCT bankaccount.branch_name) = (
    SELECT COUNT(*)
    FROM branch
    WHERE branch_city = 'Delhi'
);
delete from bankaccount
where branch_name in (
					SELECT branch_name
                    FROM Branch
                    WHERE branch_city='Bombay');                    
select * from bankaccount;
-- week4(extra queries)
select * from Loan order by  amount desc;
select customer_name from depositer union 
(select customer_name from depositer,bankaccount 
where bankaccount.acc_no=depositer.acc_no);
create view branch_total_loan(branch_name,total_loan) as select branch_name,sum(amount) from Loan group by branch_name;
drop view branch_total_loan;
select * from bankaccount;
SET SQL_SAFE_UPDATES =0;
update bankaccount
set balance=balance*1.05;
select * from bankaccount;
select branch_name,(assets/100000) as'assets in lakhs'
from branch;


