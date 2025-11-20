create database student;
use student;
create table student(
stdid int(5),
stdname varchar(20),
dob date,
doj date,
fee int(5),
gender char);
desc student;
insert into student(stdid,stdname,dob,doj,fee,gender)
values (1,'Shareef','01-01-10','01-01-05',10000,'M');
insert into student(stdid,stdname,dob,doj,fee,gender)
values (1,'Nadeem','19-11-03','01-10-26',11000,'M');
alter table student add phone_no int(10);
alter table student
rename column phone_no to student_no;
alter table student rename to student_info;
alter table student_info drop column gender;
select * from student_info;