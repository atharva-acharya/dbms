use student;

create table flight(
flno int, 
ffrom varchar(20), 
fto varchar(20),
distance int,
departs time,
arrives time, 
price int,
primary key(flno));

create table aircraft(
aid int,
aname varchar(20),
crusingrange int,
primary key(aid) 
);

create table employee(
eid int,
ename varchar(20),
salary int 
);

alter table employee
add primary key(eid);

create table certified(
eid int,
aid int,
primary key(eid,aid),
foreign key(eid) references employee(eid), 
foreign key(aid) references aircraft(aid) 
);

INSERT INTO flight (flno,ffrom,fto,distance,departs,arrives,price) VALUES 
            (1,'Bangalore','Mangalore',360,'10:45:00','12:00:00',10000),
            (2,'Bangalore','Delhi',5000,'12:15:00','04:30:00',25000),
            (3,'Bangalore','Mumbai',3500,'02:15:00','05:25:00',30000),
            (4,'Delhi','Mumbai',4500,'10:15:00','12:05:00',35000),
            (5,'Delhi','Frankfurt',18000,'07:15:00','05:30:00',90000),
            (6,'Bangalore','Frankfurt',19500,'10:00:00','07:45:00',95000),
            (7,'Bangalore','Frankfurt',17000,'12:00:00','06:30:00',99000);

INSERT INTO aircraft (aid,aname,crusingrange) values 
        (123,'Airbus',1000),
        (302,'Boeing',5000),
        (306,'Jet01',5000),
        (378,'Airbus380',8000),
        (456,'Aircraft',500),
        (789,'Aircraft02',800),
        (951,'Aircraft03',1000);
 
 INSERT INTO employee (eid,ename,salary) VALUES
        (1,'Ajay',30000),
        (2,'Ajith',85000),
        (3,'Arnab',50000),
        (4,'Harry',45000),
        (5,'Ron',90000),
        (6,'Josh',75000),
        (7,'Ram',100000);

INSERT INTO certified (eid,aid) VALUES
        (1,123),(2,123),(1,302),
        (5,302),(7,302),(1,306),
        (2,306),(1,378),(2,378),
        (4,378),(6,456),(3,456),
        (5,789),(6,789),(3,951),
        (1,951),(1,789);

SELECT DISTINCT a.aname
FROM aircraft a,certified c,employee e
WHERE a.aid=c.aid
AND c.eid=e.eid
AND NOT EXISTS
		(SELECT *
		FROM employee e1
		WHERE e1.eid=e.eid
		AND e1.salary<80000);
        
SELECT c.eid,MAX(crusingrange)
     FROM certified c,aircraft a
     WHERE c.aid=a.aid
     GROUP BY c.eid
     HAVING COUNT(*)>3;
     
 SELECT DISTINCT e.ename
     FROM employee e
     WHERE e.salary<(SELECT MIN(f.price)
						FROM flight f
						WHERE f.ffrom='Bangalore'
						AND f.fto='Frankfurt');     

 SELECT a.aid,a.aname,AVG(e.salary)
     FROM aircraft a,certified c,employee e
     WHERE a.aid=c.aid
     AND c.eid=e.eid
     AND a.crusingrange>1000
     GROUP BY a.aid,a.aname;

SELECT distinct e.ename
	FROM employee e,aircraft a,certified c
     WHERE e.eid=c.eid
     AND c.aid=a.aid
     AND a.aname='Boeing';

 SELECT a.aid
     FROM aircraft a
     WHERE a.crusingrange>
     (SELECT MIN(f.distance)
     FROM flight f
     WHERE f.ffrom='Bangalore'
	AND f.fto='Delhi');

 SELECT E.ename, E.salary
FROM employee E
WHERE E.eid NOT IN ( SELECT DISTINCT C.eid
 FROM certified C )
AND E.salary > ( SELECT AVG (E1.salary)
 FROM employee E1
 WHERE E1.eid IN
 ( SELECT DISTINCT C1.eid
 FROM certified C1 ) ) 


