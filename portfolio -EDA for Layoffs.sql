select * from layoffs_sg3;

-- check total laid off by industry

select industry, sum(total_laid_off)as total_laid_off
from layoffs_sg3
where industry != 'null'
group by industry
order by total_laid_off desc;

-- total laid off by year

select year("date") as "Year", sum(total_laid_off)as total_laid_off
from layoffs_sg3
where year("date")  is not null
group by year("date")
order by total_laid_off desc;

-- total laid off by month in the year 2022

select substring(CONVERT(varchar, "date",20),6,2) as "month", sum(total_laid_off)as total_laid_off
from layoffs_sg3
where year("date")= 2022
group by substring(CONVERT(varchar, "date",20),6,2)
order by 1;

select month("date") as "month", sum(total_laid_off)as total_laid_off
from layoffs_sg3
where year("date")= 2022
group by month("date") 
order by 1;

-- companies with the highest laid off yearly

with CTE_highest_yearly as
	(select company , year("date") as "year", sum(total_laid_off)as total_laid_off, 
	DENSE_RANK() over(  PARTITION BY year("date") ORDER BY sum(total_laid_off) DESC ) as "rank"
	from layoffs_sg3
	group by company,year("date"))
select * from CTE_highest_yearly
where "rank"=1 and "year" is not null;

-- top 10 companies with the highest laid off yearly

with CTE_highest_10_yearly as
	(select company , year("date") as "year", sum(total_laid_off)as total_laid_off, 
	DENSE_RANK() over(  PARTITION BY year("date") ORDER BY sum(total_laid_off) DESC ) as "rank"
	from layoffs_sg3
	group by company,year("date"))
select * from CTE_highest_10_yearly
where "rank"<11 and "year" is not null;

-- top 10 companies with the highest laid off 2020

with CTE_highest_10_2020 as
(select company , year("date") as "year", sum(total_laid_off)as total_laid_off, 
	DENSE_RANK() over(  PARTITION BY year("date") ORDER BY sum(total_laid_off) DESC ) as "rank"
	from layoffs_sg3
	group by company,year("date"))
select * from CTE_highest_10_2020
where "rank"<11 and "year" = 2020;

-- top 10 companies with the highest laid off 2021

with CTE_highest_10_2021 as
(select company , year("date") as "year", sum(total_laid_off)as total_laid_off, 
	DENSE_RANK() over(  PARTITION BY year("date") ORDER BY sum(total_laid_off) DESC ) as "rank"
	from layoffs_sg3
	group by company,year("date"))
select * from CTE_highest_10_2021
where "rank"<11 and "year" = 2021;

-- top 10 companies with the highest laid off 2022

with CTE_highest_10_2022 as
(select company , year("date") as "year", sum(total_laid_off)as total_laid_off, 
	DENSE_RANK() over(  PARTITION BY year("date") ORDER BY sum(total_laid_off) DESC ) as "rank"
	from layoffs_sg3
	group by company,year("date"))
select * from CTE_highest_10_2022
where "rank"<11 and "year" = 2022;

-- top 10 companies with the highest laid off 2023

with CTE_highest_10_2023 as
(select company , year("date") as "year", sum(total_laid_off)as total_laid_off, 
	DENSE_RANK() over(  PARTITION BY year("date") ORDER BY sum(total_laid_off) DESC ) as "rank"
	from layoffs_sg3
	group by company,year("date"))
select * from CTE_highest_10_2023
where "rank"<11 and "year" = 2023;

-- country with the highest laid off from 2020-2023

select country, sum(total_laid_off)as total_laid_off
from layoffs_sg3
group by country
order by total_laid_off desc;

--country with the highest laid off from 2020

select country, sum(total_laid_off)as total_laid_off
from layoffs_sg3
where year("date")= 2020
group by country
order by total_laid_off desc;

--country with the highest laid off from 2021

select country, sum(total_laid_off)as total_laid_off
from layoffs_sg3
where year("date")= 2021
group by country
order by total_laid_off desc;

--country with the highest laid off from 2022

select country, sum(total_laid_off)as total_laid_off
from layoffs_sg3
where year("date")= 2022
group by country
order by total_laid_off desc;

--country with the highest laid off from 2023

select country, sum(total_laid_off)as total_laid_off
from layoffs_sg3
where year("date")= 2023 and total_laid_off is not null
group by country
order by total_laid_off desc;