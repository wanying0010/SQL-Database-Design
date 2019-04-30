
CREATE TABLE customers(
customer_ID DECIMAL(10) NOT NULL,
membership_ID DECIMAL(15) NOT NULL,
customer_first VARCHAR(30),
customer_last VARCHAR(40),
customer_email VARCHAR(80),
stree_address VARCHAR(200),
city VARCHAR(50),
state VARCHAR(10),
zip_code DECIMAL(20),
phone_number DECIMAL(20),
PRIMARY KEY (customer_ID),
POREIGN KEY (membership_ID) REFERENCES memberships);

INSERT INTO customers VALUES
(1,2,'Amy','Lee','amyLee@gmail.com','63 Buicker Streest','Boston','MA',02216,6174582093);
INSERT INTO customers VALUES
(2,1,'Andrew','Williams','williams@gmail.com','25 New London Streer','Newark','DE',19711,3025746890);

ALTER TABLE customers
ADD status VARCHAR(25);

UPDATE customers 
SET status = 'Renewal' WHERE customer_id = 1;
UPDATE customers 
SET status = 'Active' WHERE customer_id = 2;
UPDATE customers 
SET status = 'Active' WHERE customer_id = 3;
UPDATE customers 
SET status = 'Active' WHERE customer_id = 4;
UPDATE customers 
SET status = 'Active' WHERE customer_id = 5;

CREATE TABLE rental(
movie_id DECIMAL(10) NOT NULL,
customer_ID DECIMAL(10) NOT NULL,
mailing_date DATE,
return_date DATE,
PRIMARY KEY(MOVIE_ID, CUSTOMER_ID),
FOREIGN KEY(MOVIE_ID) REFERENCES movies,
FOREIGN KEY(CUSTOMER_ID) REFERENCES customers);

INSERT INTO rental VALUES(10,1,CAST('03-MAR-2017' AS DATE),NULL);
INSERT INTO rental VALUES(11,1,CAST('28-MAR-2017' AS DATE),CAST('15-APR-2017' AS DATE));

ALTER TABLE rental
ADD queue_id DECIMAL(10);

UPDATE rental 
SET queue_id = 1 WHERE movie_id = 10;
UPDATE rental 
SET queue_id = 1 WHERE movie_id = 11;
UPDATE rental 
SET queue_id = 1 WHERE movie_id = 13;
UPDATE rental 
SET queue_id = 2 WHERE movie_id = 12;
UPDATE rental 
SET queue_id = 1 WHERE movie_id = 2;
UPDATE rental 
SET queue_id = 2 WHERE movie_id = 3;
UPDATE rental 
SET queue_id = 3 WHERE movie_id = 6;

ALTER TABLE rental
ADD ready_to_mail VARCHAR(10);

INSERT INTO rental VALUES(1,4,NULL,NULL,4,NULL);
                                                              
CREATE TABLE movies(
movie_id DECIMAL(10) NOT NULL,
genre_id DECIMAL(10) NOT NULL,
title VARCHAR(200),
production_year DECIMAL(15),
languages VARCHAR(50),
PRIMARY KEY(MOVIE_ID),
FOREIGN KEY(GENRE_ID) REFERENCES genre);

INSERT INTO movies VALUES(1,4,'American Graffiti',1973,'English');
INSERT INTO movies VALUES(2,2,'Star Wars Episode IV: A New Hope',1977,'English');
INSERT INTO movies VALUES(3,2,'Star Wars Episode V: The Empire Strikes Back',1980,'English');
INSERT INTO movies VALUES(4,2,'Star Wars Episode VI: Return of the Jedi',1983,'English');
INSERT INTO movies VALUES(5,2,'Star Wars Episode II: Attack of the Clones',2002,'English');
INSERT INTO movies VALUES(6,7,'A Matter of Faith',2014,'English');
INSERT INTO movies VALUES(7,4,'Amazing Love',2012,'English');
INSERT INTO movies VALUES(8,4,'The Appointment',1991,'English');
INSERT INTO movies VALUES(9,1,'Furious 7',2015,'English');
INSERT INTO movies VALUES(10,3,'Zootopia',2016,'English');
INSERT INTO movies VALUES(11,1,'X-Men Origins: Wolverine',2009,'English');
INSERT INTO movies VALUES(14,7,'Star Trek Into Darkness',2013,'English');
INSERT INTO movies VALUES(15,7,'Dredd',2012,'English');
                                              
CREATE TABLE genre(
genre_id DECIMAL(10) NOT NULL,
genre_name VARCHAR(60),
PRIMARY KEY(GENRE_ID));

INSERT INTO genre VALUES(1,'Action');
INSERT INTO genre VALUES(2,'Adventure');
INSERT INTO genre VALUES(3,'Comedy');
INSERT INTO genre VALUES(4,'Drama');
INSERT INTO genre VALUES(5,'Horror');
INSERT INTO genre VALUES(6,'War');
INSERT INTO genre VALUES(7,'Science');
INSERT INTO genre VALUES(8,'Musicals');
INSERT INTO genre VALUES(9,'Historical');
INSERT INTO genre VALUES(10,'Fantasy');

CREATE TABLE memberships(
membership_ID DECIMAL(15) NOT NULL,
membership_type VARCHAR(50),
price DECIMAL(15),
PRIMARY KEY (membership_ID));

INSERT INTO memberships VALUES(1,'2-at-a-time program',11.99);
INSERT INTO memberships VALUES(2,'3-at-a-time program',17.99);

CREATE TABLE directors(
director_ID DECIMAL(10) NOT NULL,
director_last VARCHAR(30),
director_first VARCHAR(30),
company VARCHAR(30),
PRIMARY KEY(DIRECTOR_ID));

INSERT INTO directors VALUES(1,'Lucas','George','Lucasfilm');
INSERT INTO directors VALUES(2,'Christiano','Rich','Christiano Film Group');
INSERT INTO directors VALUES(3,'Cohen','Rob',NULL);
INSERT INTO directors VALUES(4,'Howard','Byron','Walt Disney');
INSERT INTO directors VALUES(5,'Hood','Gavin',NULL);

CREATE TABLE movie_directors(
movie_id DECIMAL(10) NOT NULL,
director_ID DECIMAL(10) NOT NULL,
PRIMARY KEY(MOVIE_ID, DIRECTOR_ID),
FOREIGN KEY(MOVIE_ID) REFERENCES movies,
FOREIGN KEY(DIRECTOR_ID) REFERENCES directors);

INSERT INTO movie_directors VALUES(1,1);
INSERT INTO movie_directors VALUES(2,1);
INSERT INTO movie_directors VALUES(3,1);
INSERT INTO movie_directors VALUES(4,1);
INSERT INTO movie_directors VALUES(5,1);
INSERT INTO movie_directors VALUES(6,2);
INSERT INTO movie_directors VALUES(7,2);
INSERT INTO movie_directors VALUES(8,2);
INSERT INTO movie_directors VALUES(9,3);
INSERT INTO movie_directors VALUES(10,4);
INSERT INTO movie_directors VALUES(11,5);

CREATE TABLE dvds(
dvd_id DECIMAL(15) NOT NULL,
movie_id DECIMAL(10) NOT NULL,
status VARCHAR(20),
PRIMARY KEY(DVD_ID),
FOREIGN KEY(MOVIE_ID) REFERENCES movies);

INSERT INTO dvds VALUES(71,7,'out of stock');
            
CREATE OR REPLACE PROCEDURE ADD_RENTAL(
movie_id_arg IN DECIMAL,
customer_id_arg IN DECIMAL,
mailing_date_arg IN DATE,
return_date_arg IN DATE)
IS 
BEGIN
INSERT INTO RENTAL
(movie_id,customer_ID, mailing_date,return_date)
VALUES(movie_id_arg,customer_id_arg,mailing_date_arg,return_date_arg);
END;

BEGIN
  ADD_RENTAL(12,3,CAST('15-FEB-2017' AS DATE),CAST('20-FEB-2017' AS DATE));
  END;
  /
  
  BEGIN
  ADD_RENTAL(13,3,CAST('15-FEB-2017' AS DATE),CAST('03-MAR-2017' AS DATE));
  END;
  /
  
SELECT * FROM RENTAL;

SELECT title FROM movies 
WHERE movie_id IN
(SELECT movie_id FROM rental 
WHERE customer_id = 4
AND movie_id IN
(SELECT movie_id FROM movie_directors
WHERE director_ID IN
(SELECT director_ID FROM directors
WHERE director_last = 'Lucas'
AND director_first = 'George')
OR director_ID IN
(SELECT director_ID FROM directors
WHERE director_last = 'Christiano'
AND director_first = 'Rich')
));

 CREATE OR REPLACE PROCEDURE NEXT_MOVIE_TO_MAIL (READY_TO_MAIL IN VARCHAR)
AS BEGIN
   UPDATE RENTAL
   SET READY_TO_MAIL = 'YES'
   WHERE MOVIE_ID = 1 AND CUSTOMER_ID = 4;
   END;
   /

EXEC NEXT_MOVIE_TO_MAIL('YES');

SELECT * FROM RENTAL;

 SELECT title FROM movies
WHERE movie_ID IN
(SELECT movie_ID FROM rental
WHERE customer_ID = 4
AND queue_id = 1
OR customer_ID = 4
AND queue_id = 2
OR customer_ID = 4
AND queue_id = 3);

 CREATE OR REPLACE PROCEDURE ADD_MEMBERSHIP(
customer_ID_arg IN DECIMAL,
membership_ID_arg IN DECIMAL,
customer_first_arg IN VARCHAR,
customer_last_arg IN VARCHAR,
customer_email_arg IN VARCHAR,
stree_address_arg IN VARCHAR,
city_arg IN VARCHAR,
state_arg IN VARCHAR,
zip_code_arg in DECIMAL,
phone_number_arg in DECIMAL,
status_arg in VARCHAR)
IS
BEGIN
INSERT INTO CUSTOMERS
(customer_ID,membership_ID,customer_first,customer_last,customer_email,stree_address, city,state,zip_code,phone_number,status)
VALUES(customer_ID_arg,membership_ID_arg,customer_first_arg,customer_last_arg,
customer_email_arg,stree_address_arg,city_arg,state_arg,zip_code_arg,phone_number_arg,
status_arg);
END;

BEGIN
   	ADD_MEMBERSHIP
(6,1,'Peter','Lou','louAPPLE@gmail.com','POBOX 200 Main Street','Orlando','FL',29876,6176543219,'Active');
END;
/

BEGIN
  	 ADD_MEMBERSHIP
   	(7,2,'Melissa','Lee','LeeOreo@gmail.com','250 Main Street','Orlando','FL',29879,6175832465,'Active');
END;
/

SELECT customer_first,customer_last FROM customers
WHERE status = 'Active'
AND membership_id IN 
(SELECT membership_id FROM memberships
WHERE membership_type = '2-at-a-time program');
 
 CREATE OR REPLACE PROCEDURE ADD_DVDS(
dvd_id_arg IN DECIMAL,
movie_id_arg IN DECIMAL,
status_arg IN VARCHAR)
IS
BEGIN
INSERT INTO DVDS
(dvd_id,movie_id,status)
VALUES(dvd_id_arg,movie_id_arg,status_arg);
END;

BEGIN
  	ADD_DVDS
 	 (141,14,'In Stock');
 	 END;
 	 /

BEGIN
  	ADD_DVDS
  	(142,14,'In Stock');
  	END;
 	 /

BEGIN
  	ADD_DVDS
  	(143,14,'In Stock');
  	END;
  	/

BEGIN
  	ADD_DVDS
  	(151,15,'In Stock');
 	 END;
  	/

BEGIN
  	ADD_DVDS
  	(152,15,'In Stock');
  	END;
 	 /

SELECT * FROM DVDS;

SELECT title
FROM movies 
INNER JOIN rental on movies.movie_id = rental.movie_id
LEFT JOIN dvds on movies.movie_id = dvds.movie_id
WHERE (rental.return_date IS NULL)
OR (dvds.status = 'out of stock');
 
 CREATE OR REPLACE PROCEDURE GENRE_CHANGE (GENRE_ID IN DECIMAL)
AS BEGIN
   UPDATE MOVIES
   SET GENRE_ID = (SELECT GENRE_ID FROM genre WHERE genre_name = 'Fantasy')
   WHERE TITLE = 'X-Men Origins: Wolverine' OR TITLE = 'X-Men: Days of Future Past'';
END;
/

BEGIN
GENRE_CHANGE(3);
END;
/

BEGIN
GENRE_CHANGE(7);
END;
/

SELECT * FROM MOVIES;

SELECT Genre.genre_id, Genre.genre_name,
       COUNT(Movies.genre_id) AS nr_movies
FROM Genre
JOIN Movies ON Genre.genre_id = Movies.genre_id
GROUP BY Genre.genre_id, Genre.genre_name
ORDER BY nr_movies DESC;
 
CREATE INDEX D_NAMEINDEX ON DIRECTORS(director_last,director_first);

