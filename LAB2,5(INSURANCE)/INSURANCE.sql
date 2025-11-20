show databases;
drop database newdatabase;
show databases;
create database insurance;
use insurance;
create table person(
driver_id varchar(10),
name varchar(20),
address varchar(30),
primary key(driver_id));
desc person;
create table car(
reg_num varchar(10),model varchar(10),year int,primary key(reg_num));
desc car;
create table accident(
report_num int,accident_date date,locatin varchar(20),primary key(report_num));
desc accident;
create table owns(
driver_id varchar(10),reg_num varchar(10),primary key(driver_id,reg_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num));
desc owns;
create table participated(driver_id varchar(10),reg_num varchar(10),report_num int,damage_amount int,
primary key(driver_id,reg_num,report_num),
foreign key(driver_id) references person(driver_id),
foreign key(reg_num) references car(reg_num),
foreign key(report_num) references accident(report_num));
desc participated;
insert into person values('A01','Richard','Srinivas nagar');
insert into person values('A02','Pradeep','Rajajinagar');
insert into person values('A03','Smith','Ashok nagar');
insert into person values('A04','Venu','N.R.Colony');
insert into person values('A05','John','Hanumanth nagar');
commit;
select * from person;
insert into car values('KA052250','Indica',1990);
insert into car values('KA031181','Lancer',1957);
insert into car values('KA095477','Toyota',1998);
insert into car values('KA053408','Honda',2008);
insert into car values('KA041702','Audi',2005);
commit;
select * from car;
insert into accident values(11,'01-01-03','Mysore Road');
insert into accident values(12,'02-02-04','Southend circle');
insert into accident values(13,'21-01-03','Bulltemple Road');
insert into accident values(14,'17-02-08','Mysore Road');
insert into accident values(15,'04-03-05','Kanakapura Road');
commit;
select * from accident;
delete from accident where report_num<16;
select * from accident;
insert into accident values(11,'01-01-03','Mysore Road');
insert into accident values(12,'02-02-04','Southend circle');
insert into accident values(13,'21-01-03','Bulltemple Road');
insert into accident values(14,'17-02-08','Mysore Road');
insert into accident values(15,'04-03-05','Kanakapura Road');
commit;
select * from accident;
insert into owns values('A01','KA052250');
insert into owns values('A02','KA053408');
insert into owns values('A03','KA031181');
insert into owns values('A04','KA095477');
insert into owns values('A05','KA041702');
COMMIT;
SELECT * FROM owns;
insert into participated values('A01','KA052250',11,10000);
insert into participated values('A02','KA053408',12,50000);
insert into participated values('A03','KA095477',13,25000);
insert into participated values('A04','KA031181',14,3000);
insert into participated values('A05','KA041702',15,5000);
COMMIT;
select * from participated;
update participated
set damage_amount=25000
where reg_num='KA053408' and report_num=12;
commit;
select * from participated;
insert into accident values(16,'15-03-08','Dolmur');
select * from accident;
select accident_date,locatin from accident;
select driver_id 
from participated
where damage_amount>=25000;
-- week 5(extra problems)
select * from participated order by damage_amount desc;
select avg(damage_amount) from participated;
set sql_safe_updates=0;
delete from participated where damage_amount<(select A from (select avg(damage_amount) as A from participated ) as B);
select * from participated;
select name from person as A,participated as B
where A.driver_id=B.driver_id and damage_amount>(select avg(damage_amount) from participated);
select max(damage_amount) from participated;