--Data type valudation and null value correction
SELECT * FROM data_time_series
WHERE Latitude IS NULL
OR Longitude IS NULL
OR Date IS NULL
OR Confirmed IS NULL
OR Deaths IS NULL
OR Recovered IS NULL;

update data_time_series
set `Longitude`=0
WHERE `Longitude` is null;

update data_time_series
set `Latitude`=0
WHERE `Latitude` is null;

--- 1. DESCRIPTIVE STATISTICS ---

/* check how many rows */
SELECT count(`Date`) as no_of_rows from data_time_series;

/* how many month */ 
SELECT   YEAR(Date) AS "year",COUNT(DISTINCT MONTH(Date)) AS "NB of Months" FROM data_time_series
GROUP BY YEAR(Date);

/*start_date - end_date*/
select min(DATE) as "start date" , max (DATE) as "end date" from   data_time_series;

/* how many rows in each month */
select year( date) as "year",month(date) as "month",count(*) as "no of days" from data_time_series
group by (year(date)),month(date) ;

/*min: confirmed, deaths, recovered per month*/
select year(date) as 'year',month(date) as 'month',
min(`Confirmed`)as `Confirmed cases`,
min(`Deaths`)as `Confirmed deaths`,
min(`Recovered`) as `Confirmed Recovereries` 
from data_time_series
group by (year(date)),month(date);


--max: confirmed, deaths, recovered per month
select year(date) as 'year',month(date) as 'month',
max(`Confirmed`)as `Confirmed cases`,
max(`Deaths`)as `Confirmed deaths`,
max(`Recovered`) as `Confirmed Recovereries` 
from data_time_series
group by (year(date)),month(date);

-- The total case: confirmed, deaths, recovered per month
select year(date) as 'year',month(date) as 'month',
sum(`Confirmed`)as `Confirmed cases`,
sum(`Deaths`)as `Confirmed deaths`,
sum(`Recovered`) as `Confirmed Recovereries` from data_time_series
group by (year(date)),month(date);

/********* 1.1. The central tendency: a distribution is an 
estimate of the “center” of a distribution of values: 
-- MEAN
-- MODE
-- MEDIAN
*********/

---------- MEAN ----------
select year(date) as 'year',month(date) as 'month',
round(AVG(`Confirmed`),0)as `average cases`,
round(AVG(`Deaths`),0)as `average deaths`,
round(AVG(`Recovered`),0) as `average Recovereries` from data_time_series
group by (year(date)),month(date);

/********* 1.2. The dispersion: refers to the spread of the values around the central tendency:
-- RANGE = max value - min value
-- VARIANCE
-- STANDART DEVIATION
*********/

-- How spread out? 
--- confirmed case
select 
	sum(confirmed) AS total_confirmed, 
	round(avg(confirmed), 0) AS average_confirmed,
	round(VARIANCE(confirmed),0) AS variance_confirmed,
	round(STDDEV_POP(confirmed),0) AS std_confirmed
from data_time_series;

--- deaths case
select 
	sum(confirmed) AS total_confirmed, 
	round(avg(confirmed), 0) AS average_confirmed,
	round(VARIANCE(confirmed),0) AS variance_confirmed,
	round(STDDEV_POP(confirmed),0) AS std_confirmed
from data_time_series;
--- recovered case
select 
	sum(confirmed) AS total_confirmed, 
	round(avg(confirmed), 0) AS average_confirmed,
	round(VARIANCE(confirmed),0) AS variance_confirmed,
	round(STDDEV_POP(confirmed),0) AS std_confirmed
from data_time_series;


select  * from data_time_series
order by Confirmed DESC
limit 5

--TOP 5

/* What are the top data ? */
--Data Interpretion: 

--TOP 10 of the Confirmed case: the most Confirmed case are from India in April and May 2021

SELECT *
FROM data_time_series
where `Country`="India"
ORDER BY Confirmed DESC
limit 10;

--TOP 10 of the Deaths case: the most deaths case are from India. It causes the largest number of confirmed case.
SELECT *
FROM data_time_series
where `Country`="India"
ORDER BY `Deaths` DESC
limit 10;

--TOP 10 of the recovered case: is similar to Deaths case
SELECT *
FROM data_time_series
where `Country`="India"
ORDER BY `Recovered` DESC
limit 10;

--- 3.CORRELATION AND RANKS

/* check the correlation between confirmed, deaths and recoverd case*/
/* we can see that there is high correlation between confirmed, deaths and recoverd case,
 which make sense.*/
-- confirmed-deaths: 0.7917
SELECT ((Avg(Confirmed * Deaths) - (Avg(Confirmed) * Avg(Deaths))) / (STDDEV_POP(Confirmed) * STDDEV_POP(Deaths))) AS 'Cor_cf_dt'
FROM data_time_series;

--confirmed - recovered: 0.68807

SELECT ((Avg(Confirmed * Recovered) - (Avg(Confirmed) * Avg(Recovered))) / (STDDEV_POP(Confirmed) * STDDEV_POP(Recovered))) AS 'Cor_cf_rc'
FROM data_time_series;

--deaths - recovered: 0.60565

SELECT ((Avg(deaths * Recovered) - (Avg(deaths) * Avg(Recovered))) / (STDDEV_POP(deaths) * STDDEV_POP(Recovered))) AS 'Cor_dt_rc'
FROM data_time_series;

--- 4.LINEAR MODELS
/***************** Linear Models ****************/
/* Linear Model such as regression are useful for estimating values for business.
Such as: We just want to estimate how much revenue we get after run a marketing campaign with xx cost.*/

--- The result of Linear Regression: y=mx+b => y = 0.0136x + 9.9926. It means that when confirmed case increases 100 case, there will increase 1 deadth.

/*********** Computing Slope (Deaths on y-axis and confirmed case in x-asis) *********/
/* Result: 0.01360387 */
select (count(Confirmed)*sum(Confirmed*Deaths) - sum(Confirmed)* sum(Deaths))/(count(Confirmed)*sum(Confirmed*Confirmed) - sum(Confirmed)* sum(Confirmed))
from data_time_series;

/*********** Computing Intercept (deaths on y-axis and confirmed case in x-asis) *********/ 
--Intercept = avg(y) - slope*avg(x)
/* Result: 9.992565367 */
SELECT AVG(Deaths) - ((count(Confirmed)*sum(Confirmed*Deaths) - sum(Confirmed)* sum(Deaths))/(count(Confirmed)*sum(Confirmed*Confirmed) - sum(Confirmed)* sum(Confirmed)))*AVG(Confirmed)
FROM data_time_series;