 create database student;
 use student;
 
 CREATE TABLE student(
	snum INT,
	sname VARCHAR(10),
	major VARCHAR(2),
	level VARCHAR(2),
	age int,primary key(snum));
    
     CREATE TABLE faculty(
	fid INT,fname VARCHAR(20),
	deptid INT,
	PRIMARY KEY(fid));
    
    CREATE TABLE class(
	cname VARCHAR(20),
	metts_at VARCHAR(10),
	room VARCHAR(10),
	fid INT,
	PRIMARY KEY(cname),
	FOREIGN KEY(fid) REFERENCES faculty(fid));
    
    CREATE TABLE enrolled(
	snum INT,
	cname VARCHAR(20),
	PRIMARY KEY(snum,cname),
	FOREIGN KEY(snum) REFERENCES student(snum),
	FOREIGN KEY(cname) REFERENCES class(cname));
    
    desc student;
    
    INSERT INTO student (snum,sname,major,level,age) VALUES
     (1,'jhon','CS','Sr',19),
     (2,'smith','CS','Jr',20),
     (3,'jacob','CV','Sr',20),
     (4,'tom','CS','Jr',20),
     (5,'sid','CS','Jr',20),
     (6,'harry','CS','Sr',21);
     
     select * from enrolled;
     
     INSERT INTO faculty (fid,fname, deptid) VALUES
    (11,'Harshith',1000),
    (12,'Mohan',1000),
    (13,'Kumar',1001),
    (14,'Shobha',1002),
    (15,'Shan',1000);
    
    INSERT INTO class (cname,metts_at,room,fid) VALUES
     ('class1','noon','room1',14),
     ('class10','morning','room128',14),
     ('class2','morning','room2',12),
     ('class3','morning','room3',11),
     ('class4','evening','room4',14),
     ('class5','night','room3',15),
     ('class6','morning','room2',14),
     ('class7','morning','room3',14);
     
     INSERT INTO enrolled (snum,cname) VALUES
     (1,'class1'),
     (2,'class1'),
     (3,'class3'),
     (4,'class3'),
     (5,'class3'),
     (5,'class4');
     
     INSERT INTO enrolled (snum,cname) VALUES
     (3,'class1'),
     (3,'class5');
     INSERT INTO enrolled (snum,cname) VALUES
     (3,'class2');
     
     SELECT DISTINCT s.sname
	FROM student s,class c,faculty f,enrolled e
	WHERE  s.snum=e.snum      AND
	       e.cname=c.cname    AND
       	   s.level='jr'       AND
	       f.fname='Harshith' AND
	       f.fid=c.fid;
     
     SELECT DISTINCT cname
	FROM class
	WHERE room='room128'
	OR
	cname IN (SELECT e.cname 
              FROM enrolled e 
              GROUP BY e.cname 
              HAVING COUNT(*)>=5);
 
 SELECT DISTINCT s.sname
	FROM student s
	WHERE s.snum IN (SELECT e1.snum
				FROM enrolled e1,enrolled e2,class c1,class c2
				WHERE e1.snum=e2.snum   AND
				e1.cname<>e2.cname      AND
		  	        e1.cname=c1.cname       AND
			        e2.cname=c2.cname       AND
			        c1.metts_at=c2.metts_at  );
                    
 SELECT f.fname,f.fid
			FROM faculty f
	     	WHERE f.fid in ( SELECT fid FROM class
			GROUP BY fid HAVING COUNT(*)=(SELECT COUNT(DISTINCT room) FROM class) );                   

select distinct f.fname
from faculty f
where 5>(select count(e.snum)
		 from class c,enrolled e
         where c.cname=e.cname
         and c.fid=f.fid);
         
 select distinct s.sname
 from student s
 where s.snum not in(select e.snum from enrolled e);
 
 select s.age,s.level
 from student s 
 group by s.age,s.level
 having s.level in (select s1.level 
			  from student s1
              group by s1.level,s1.age
              having count(*)>=all (select count(*)
									from student s2
                                    where s1.age=s2.age
                                    group by s2.level,s2.age));