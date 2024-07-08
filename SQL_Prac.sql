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

