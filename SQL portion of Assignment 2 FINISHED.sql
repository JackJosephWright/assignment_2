
/*Download the "survey.csv" and "people.csv" files from github <github link>*/


create schema datacollection;
create user 'tester' identified by '1234';
grant all on *.* to 'tester';

use datacollection;
drop table if exists movieRanks ;


create table movieRanks(
nameid integer not null auto_increment,
parasite tinyint,
joker tinyint,
littleWomen tinyint,
tenet tinyint,
starWars tinyint,
batman tinyint,
primary key (nameid) 
);
/* make sure file path for survey.csv is correct*/

drop table if exists people;

create table people(
nameid integer not null auto_increment,
firstname varchar(100),
lastname varchar(100),
age tinyint,
primary key (nameid) 
);




LOAD DATA INFILE "C:/data/survey.csv" 
INTO TABLE movieRanks 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(nameid,@parasite,@joker,@littleWomen,@tenet,@starWars, @batman)
SET parasite = IF(@parasite = '', NULL, @parasite),
 joker = IF(@joker = '', NULL, @joker),
 littleWomen = IF(@littleWomen = '', NULL, @littleWomen),
 tenet = IF(@tenet = '', NULL, @tenet),
 starWars = IF(@starWars = '', NULL, @starWars),
 batman = IF(@batman = '', NULL, @batman);


LOAD DATA INFILE "C:/data/people.csv" 
INTO TABLE people 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(nameid,@firstname, @lastname, @age)
SET firstname = IF(@firstname = '', NULL, @firstname),
 lastname = IF(@lastname = '', NULL, @lastname),
 age = IF(@age = '', NULL, @age)
 ;



/*
I spent three or four hours trying to figure out how to insert the 
average rating of the movie into the null values, but I couldn't 
figure it out, so I will just use an average movie rating of 5 for now
*/

update movieRanks set parasite =5 where parasite is null;
update movieRanks set joker =5 where joker is null;
update movieRanks set littleWomen =5 where littleWomen is null;
update movieRanks set tenet =5 where tenet is null;
update movieRanks set starWars =5 where starWars is null;
update movieRanks set batman =5 where batman is null;
select * from movieRanks;

create table output as
select  firstname, parasite, joker, littleWomen, tenet, starWars, batman
from people
inner join movieRanks
on people.nameid=movieranks.nameid
group by people.nameid;






