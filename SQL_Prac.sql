Q#1:
/* Query all columns for all American cities in the CITY table with populations larger than 100000.
 The CountryCode for America is USA. 
*/

select* from CITY as c where c.POPULATION >100000 and c.COUNTRYCODE = 'USA';

Q#2: 
/*
Query the NAME field for all American cities in the CITY table with populations larger than 120000.
The CountryCode for America is USA. */

Select name from city as c where c.countrycode ='USA' and c.population>120000;

/*
Q#3:
Query all columns (attributes) for every row in the CITY table. */
Select* from city;

/*
Q#4:
Query all columns for a city in CITY with the ID 1661.
*/

Select * from city c where c.id =1661;

/*
Q#5:
Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN. 
*/

Select* from city where countrycode ='JPN';

/*
Q#6:
Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN. 
*/

select name from city where countrycode='JPN';

/*
Q#7:
Query a list of CITY and STATE from the STATION table. 
*/
select city, state from station;

/*
Q#8:
Query a list of CITY names from STATION for cities that have an even ID number.
 Print the results in any order, but exclude duplicates from the answer.
 */

 select distinct city from station where id%2=0;

/*
Find the difference between the total number of CITY entries in the table
 and the number of distinct CITY entries in the table. */

 Select ( Select count(city) from station)  - (Select count(distinct city)  from station) ;

 /*Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION.
  Your result cannot contain duplicates. */

  SELECT city 
FROM station 
WHERE city LIKE 'a%' 
   OR city LIKE 'e%' 
   OR city LIKE 'i%' 
   OR city LIKE 'o%' 
   OR city LIKE 'u%';

   /* Query the list of CITY names ending with
    vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates. */

     SELECT DISTINCT city 
FROM station 
WHERE city LIKE '%a' 
   OR city LIKE '%e' 
   OR city LIKE '%i' 
   OR city LIKE '%o' 
   OR city LIKE '%u';

   -- OR
   select distinct city from station where RIGHT(city, 1) 
   IN('a','e','i','o','u');
/*
   Query the list of CITY names from STATION which have vowels 
   (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.*/

   SELECT DISTINCT city 
FROM station 
where LEFT(city, 1) IN('a', 'e', 'i', 'o', 'u') AND
RIGHT(city, 1) IN('a', 'e', 'i', 'o', 'u');

/*
Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates. */

Select DISTINCT CITY FROM STATION
WHERE LEFT(CITY,1) NOT IN ('a', 'e', 'i', 'o', 'u');

/*
Query the list of CITY names from STATION that do not END with vowels. Your result cannot contain duplicates. */

Select DISTINCT CITY FROM STATION
WHERE RIGHT(CITY,1) NOT IN ('a', 'e', 'i', 'o', 'u');

/* Query the list of CITY names from STATION that either do not start with vowels
 or do not end with vowels. Your result cannot contain duplicates. */

Select DISTINCT CITY FROM STATION
WHERE
RIGHT(CITY,1) NOT IN ('a', 'e', 'i', 'o', 'u')
OR
LEFT(CITY,1) NOT IN ('a', 'e', 'i', 'o', 'u');
