-- week8--
create database supplier;
use supplier;
create table suppliers(
sid int primary key,sname varchar(30),
address varchar(50));
create table parts(pid int primary key,pname varchar(30),color varchar(10));
create table catalog(sid int,pid int,cost real,primary key(sid,pid),foreign key(sid) references suppliers(sid),foreign key(pid) references parts(pid));
insert into suppliers values(10001,'Acme Widget','Bangalore'),
(10002,'Johns','Kolkata'),
(10003,'Vimal','Mumbai'),
(10004,'Reliance','Delhi'),
(10005,'Mahindra','Mumbai');
insert into parts values(20001,'book','red'),
(20002,'pen','red'),
(20003,'pencil','green'),(20004,'mobile','green'),(20005,'charger','black');
insert into CATALOG values(10001, 20001,10),
(10001, 20002,10),
(10001, 20003,30),
(10001, 20004,10),
(10001, 20005,10),
(10002, 20001,10),
(10002, 20002,20),
(10003, 20003,30),
(10004, 20003,40);
select  distinct p.pname from parts as p,catalog as c where p.pid=c.pid;
select S.sname from Suppliers S where
(( select count(P.pid)
from Parts P ) =
(select count(C.pid)
from catalog C
where C.sid = S.sid ));
select  distinct sname from suppliers as s,catalog as c
where c.sid=s.sid  and c.pid in (select p.pid from parts as p where p.color='red');
select  distinct p.pname from parts as p,catalog as c,suppliers as s
where c.pid=p.pid and c.sid =s.sid and s.sname='Acme Widget' and not exists (select * from catalog as c1,suppliers as s1 where p.pid=c1.pid and c1.sid=s1.sid and 
s1.sname !='Acme Widget');
select c.sid from catalog as c where c.cost>(select avg(c1.cost) from catalog as c1 where c1.pid=c.pid);
select  distinct p.pid,s.sname from  parts as p,suppliers as s,catalog as c where c.sid=s.sid and c.pid=p.pid and c.cost=(select max(c1.cost) from catalog as c1 where c1.pid=c.pid );
