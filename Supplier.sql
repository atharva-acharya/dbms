create database supplier;
use supplier;
create table suppliers(sid integer,sname varchar(60),address varchar(100));
alter table suppliers add primary key (sid);
create table parts(pid integer,pname varchar(60),color varchar(20),primary key (pid));
create table catalog(sid integer,pid integer,cost double,foreign key (sid) references suppliers(sid),foreign key (pid) references parts(pid),primary key (sid,pid));
insert into suppliers(sid,sname,address)values
(1,"Acme Widget","650 Palo Alto"),
(2,"Johns","Redmond Seattle"),
(3,"Vimal","Mountain View"),
(4,"Reliance","Cupertino"),
(5,"Pidilite","Menlo Park");
insert into parts(pid,pname,color) values (1,"Book","Black"),
(2,"Pen","Silver"),
(3,"Pencil","White"),
(4,"Charger","Yellow"),
(5,"Mobile","Grey");
insert into catalog(sid,pid,cost) values
(1,1,10),
(1,2,10),
(1,3,30),
(1,4,10),
(1,5,10),
(2,1,10),
(2,2,20),
(3,3,30),
(4,3,40);
 
SELECT DISTINCT P.pname FROM parts P, catalog C WHERE P.pid = C.pid;
select S.sname from suppliers S,catalog C,parts P where C.sid=S.sid and P.pid=C.pid group by P.pid;



