-- Data Cleaning
select top 5 * 
from world_layoffs.dbo.layoffs;

-- Remove duplicates
-- consistency in the data 
-- Null Value or missing values
use world_layoffs;
create table layoffs_sg2
(company varchar(max)null, "location" varchar(max)null, industry varchar(max)null,total_laid_off varchar(max)null, percentage_laid_off varchar(max)null,
"date" varchar(max)null,stage varchar(max)null,
country varchar(max)null, funds_raised_millions varchar(max)null)
insert layoffs_sg2
select* from world_layoffs.dbo.layoffs;

--1 remove duplicates
-- lets check for duplicates
select company,"location",total_laid_off,percentage_laid_off,"date",stage,country,funds_raised_millions,
ROW_NUMBER() over(partition by company,"location",total_laid_off,percentage_laid_off,"date",stage,country,funds_raised_millions order by company) as row_num
from layoffs_sg2;
 WITH Cte_duplicate AS (
    SELECT company, 
           location, 
           total_laid_off, 
           percentage_laid_off, 
           "date", 
           stage, 
           country, 
           funds_raised_millions,
           ROW_NUMBER() OVER (
               PARTITION BY company, location, total_laid_off, percentage_laid_off, 
                            "date", stage, country, funds_raised_millions 
               ORDER BY company
           ) AS row_num
    FROM layoffs_sg2
)
select* from Cte_duplicate 
where row_num > 1;

select company,"location",total_laid_off,percentage_laid_off,"date",stage,country,funds_raised_millions,
ROW_NUMBER() over(partition by company,"location",total_laid_off,percentage_laid_off,"date",stage,country,funds_raised_millions order by company) as row_num
from layoffs_sg2
where company= 'casper';

create table layoffs_sg3
(company varchar(max)null, "location" varchar(max)null, industry varchar(max)null,total_laid_off varchar(max)null, percentage_laid_off varchar(max)null,
"date" varchar(max)null,stage varchar(max)null,
country varchar(max)null, funds_raised_millions varchar(max)null, row_num int)
select* from layoffs_sg3;
insert into layoffs_sg3
  SELECT *,
        ROW_NUMBER() OVER (
               PARTITION BY company, location, total_laid_off, percentage_laid_off, 
                            "date", stage, country, funds_raised_millions 
               ORDER BY company
           ) AS row_num
		   from layoffs_sg2;

-- we have identify our duplicate so we are going to delete the duplicates

delete 
from layoffs_sg3
where row_num >1;

-- 2 remove Inconsistency

update layoffs_sg3
set company= trim(company);

select company from layoffs_sg3
order by company;

select distinct location from layoffs_sg3
order by 1;

update layoffs_sg3
set location= TRIM (location);

-- if we look at industry it looks like we have some null and empty rows, let's take a look at these

select distinct industry from layoffs_sg3
order by 1;

update layoffs_sg3
set industry = trim(industry);

-- I also noticed the Crypto has multiple different variations. We need to standardize that - let's say all to Crypto

update layoffs_sg3
set industry= 'Crypto'
where industry like 'crypto%';

select distinct industry from layoffs_sg3;

select distinct country from layoffs_sg3;

-- everything looks good except apparently we have some "United States" and some "United States." with a period at the end. Let's standardize this.

update layoffs_sg3
set country= 'United States'
where country like 'United States%';

-- Let's also fix the date columns:
-- we can use TRY_CONVERT to update this field

update layoffs_sg3
set "date"= TRY_CONVERT(datetime2, "date",120 );

SELECT TRY_CONVERT(datetime2, "date" )
 as "date" from layoffs_sg3;

select  * from layoffs_sg3;

-- now we can convert the data type properly in the table

ALTER TABLE layoffs_sg3
ALTER COLUMN [date] DATE;

--3. Look at Null Values

update layoffs_sg3
set industry= Null
where industry=' ';

select company,location,industry from layoffs_sg3
where industry is null;

select t1.company,t1.location,t2.industry from layoffs_sg3 t1
join layoffs_sg3 t2 on t1.company=t2.company and t1.location=t2.location
where t1.industry is null and t2.industry is not null;

update t1
SET t1.industry = t2.industry
FROM layoffs_sg3 t1
JOIN layoffs_sg3 t2 
    ON t1.company = t2.company
WHERE t1.industry IS NULL 
  AND t2.industry IS NOT NULL;

select company,location,industry from layoffs_sg3
where company= 'Carvana';

select * from layoffs_sg3;

-- 4. remove any columns and rows we need to

select * from layoffs_sg3
where percentage_laid_off = 'null' AND total_laid_off = 'null';

delete from layoffs_sg3
where percentage_laid_off = 'null' AND total_laid_off = 'null';

alter table layoffs_sg3
drop column row_num;

update layoffs_sg3
set percentage_laid_off = null 
where percentage_laid_off = 'null' ;

update layoffs_sg3
set total_laid_off = null
where total_laid_off = 'null' ;

alter table layoffs_sg3
alter column percentage_laid_off float

alter table layoffs_sg3
alter column total_laid_off int
