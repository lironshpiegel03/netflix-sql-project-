-----------------------------project one final liron shpiegel ----------------------
--------General description of the project The table on the subject of programs that are on ----
--------Netflix only in the following countries: Israel, United States, and India.------
--------I took the table from Kegel and divided it into 8 tables---------
----------So Tables 1-7 show some information and Table 8 which shows all the information------

 --table 1 (type_info)-----
 ---The function of this table is to give an
------identifier to the type (film / TV show)-----
create table type_info
(
type_ varchar(20),
type_id int Primary key 
);

insert into type_info (type_,type_id)
values('Movie',1)
insert into type_info (type_,type_id)
values('TV show' ,2)
go
---table tow  (country_info)-----
-----The function of this table is to give an ID to the selected country---
create table country_info 
(
country varchar(30),
country_id int identity (1,1) primary key
);
insert into country_info (country)
values('israel');
insert into country_info (country)
values('united states ');
insert into country_info (country)
values('India');
go
---table three(general_info)------
-----Gives general information about the show on Netflix--
create table  general_info 
(
show_id int identity (100,1),
title varchar(100) not null,
type_id int ,
country_id int,
primary key(show_id,title),
FOREIGN KEY (type_id) REFERENCES type_info(type_id),
FOREIGN KEY (country_id) REFERENCES country_info(country_id)   
);
INSERT INTO general_info (title, country_id,type_id)
SELECT nt.title, ci.country_id ,ti.type_id
FROM country_info AS ci 
JOIN [dbo].[netflix_titles] AS nt ON 
ci.country = nt.country
join [dbo].[type_info] as ti 
on ti.type_=nt.type
WHERE ci.country IN ('india', 'mexico', 'united states');
go 
---table Four(listed_in_info)-----
---His role is to identify according to which category it is---
create table listed_in_info
(
listed_id int identity (1,1) primary key,
listed_in varchar(100)
);
insert into listed_in_info(listed_in)
select nt.listed_in 
from [dbo].[netflix_titles] AS nt 
WHERE nt.country IN ('india', 'israel', 'united states')
AND (nt.listed_in LIKE 'horror%'OR nt.listed_in LIKE '%drama%' )
group by listed_in;
go
---table five (about_t_show)
----Gives briefer information about the item, movie name, ID, director's ID, director's name, 
---and what type it belongs to---
CREATE TABLE about_t_show (
   show_id INT,
   title VARCHAR(100) NOT NULL,
   director VARCHAR(200)  not null ,
   dirctor_id  int identity(1,1) primary key,
   cast varchar(900),
   listed_id INT,
   FOREIGN KEY (listed_id) REFERENCES listed_in_info(listed_id)
);

INSERT INTO about_t_show (show_id, title, director, cast, listed_id)
SELECT gn.show_id, gn.title, nt.director, nt.cast, 
       (
	   SELECT listed_id FROM listed_in_info 
	   WHERE listed_in = nt.listed_in
	   )  AS listed_id
FROM general_info AS gn
JOIN [dbo].[netflix_titles] AS nt 
      ON gn.title = nt.title
WHERE nt.country IN ('india', 'israel', 'united states')
AND (nt.listed_in LIKE '%horror%' OR nt.listed_in LIKE '%drama%');
go 
---table six (movie)-----
---Shows the information only of the movies----
create table movie 
(
show_id int ,
title varchar (100),
director varchar (200),
cast varchar(900),
description varchar(900),
duration varchar(30),
country varchar(15),
relase_year varchar(5),
type varchar(15),
listed_id int,
FOREIGN KEY (show_id, title) REFERENCES general_info(show_id, title),
FOREIGN KEY (listed_id) REFERENCES listed_in_info (listed_id) 
);
INSERT INTO movie (show_id, title, director, cast, description, listed_id, duration, relase_year, type,country)
SELECT gn.show_id, gn.title,nt.director, nt.cast, nt.description, lii.listed_id, nt.duration,
nt.release_year, nt.type,nt.country
FROM general_info AS gn
JOIN [dbo].[netflix_titles] AS nt ON gn.title = nt.title
JOIN listed_in_info AS lii ON nt.listed_in = lii.listed_in
WHERE nt.country IN ('india', 'israel', 'united states')
AND (nt.listed_in LIKE '%horror%' OR nt.listed_in LIKE '%drama%')
AND nt.type = 'Movie'
go 
----table seven (tv_show)----
--Shows the information only of the TV shows---
CREATE TABLE tv_show 
(
    show_id INT,
    title VARCHAR(100),
    director varchar(200),
    cast VARCHAR(900),
    description VARCHAR(900),
    duration VARCHAR(30),
    country VARCHAR(15),
    release_year VARCHAR(5),
    type VARCHAR(15),
    listed_id INT,
    FOREIGN KEY (show_id, title) REFERENCES general_info(show_id, title),
    FOREIGN KEY (listed_id) REFERENCES listed_in_info(listed_id)
);
INSERT INTO tv_show (show_id, title,  director, cast
, description, listed_id, duration, release_year, type,country)
SELECT gn.show_id, gn.title, nt.director, nt.cast, nt.description, 
lii.listed_id, nt.duration, nt.release_year, nt.type,nt.country
FROM general_info AS gn
JOIN [dbo].[netflix_titles] AS nt ON gn.title = nt.title
JOIN listed_in_info AS lii ON nt.listed_in = lii.listed_in
WHERE nt.country IN ('india', 'israel', 'united states')
AND (nt.listed_in LIKE '%horror%' OR nt.listed_in LIKE '%drama%')
AND nt.type = 'tv show'
go
---table eight(all_info)----
-----Shows all the information about what's on Netflix----
CREATE TABLE all_info  
(
    show_id INT,
    title VARCHAR(100),
    director varchar(200),
    cast VARCHAR(900),
    description VARCHAR(900),
    duration VARCHAR(30),
    country VARCHAR(15),
    release_year VARCHAR(5),
    type VARCHAR(15),
    listed_in varchar (400),
    FOREIGN KEY (show_id, title) REFERENCES general_info(show_id, title),
);
INSERT INTO all_info (show_id, title,  director, cast, description
, listed_in, duration, release_year, type,country)
SELECT gn.show_id, gn.title, nt.director, nt.cast, nt.description, 
nt.listed_in, nt.duration, nt.release_year, nt.type,nt.country
FROM general_info AS gn
JOIN [dbo].[netflix_titles] AS nt ON gn.title = nt.title
WHERE nt.country IN ('india', 'israel', 'united states')
AND (nt.listed_in LIKE '%horror%' OR nt.listed_in LIKE '%drama%')
