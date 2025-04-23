select top 5 * from clean_bike_buyers;

-- sum of income based on education

select Education, sum(income) as Total_Income from clean_bike_buyers
group by Education
order by Education;

-- sum of income based on Region

select Region, sum(income) as Total_Income from clean_bike_buyers
group by Region
order by Region;

-- sum of income based on Occupation

select Occupation, sum(income) as Total_Income from clean_bike_buyers
group by Occupation
order by Occupation;

-- bike purchased based on commute 

select "Commute Distance", COUNT("Commute Distance") as distance_count,sum(Income) as total_income 
from clean_bike_buyers
where "Purchased Bike"='Yes'
group by "Commute Distance"
order by 3 desc;

-- bike purchased based on Region

select Region,COUNT(Region) as Region_count, sum(income) as Total_Income from clean_bike_buyers
where "Purchased Bike"='Yes' 
group by Region
order by 3 desc;

-- bike purchased based on Occupation

select Occupation,COUNT(Occupation) as Occupation_count, sum(income) as Total_Income from clean_bike_buyers
where "Purchased Bike"='Yes'
group by Occupation
order by 3 desc;

-- bike purchased based on Education

select Education,COUNT(Education) as Education_count, sum(income) as Total_Income from clean_bike_buyers
where "Purchased Bike"='Yes'
group by Education
order by 3 desc;

--exploring the age in the data

select age, count(age) as count_age from clean_bike_buyers
group by age
order by 1;

-- Creating a CTE for Age Range
-- bike purchased based on Age Range

with cte_age_range as
(select case
when age<=29 then 'young'
when age > 29 and age <= 49 then 'middle age'
when age >49 then 'old'
else null
end as age_range, income, [Purchased Bike]
from clean_bike_buyers)
select age_range, sum(Income) as Total_income from cte_age_range
where [Purchased Bike]='Yes'
group by age_range
order by 2 desc;

-- bike purchased based on Marital Status

select [Marital Status],count([Marital Status]) as count_married_status ,sum(Income) as Total_Income from clean_bike_buyers
where [Purchased Bike]= 'Yes'
group by [Marital Status]
order by 3 desc;

-- bike purchased based on Gender

select Gender,count(Gender) as count_gender ,sum(Income) as Total_Income from clean_bike_buyers
where [Purchased Bike]= 'Yes'
group by Gender
order by 3 desc;

-- Creating a CTE for Family Range
-- bike purchased based on Family Range

with cte_family_range as
(select case
when Children<=2 then 'Small Family'
when Children =3 then 'Medium Family'
when Children>3 then 'Large Family'
else null
end as family_range, income, [Purchased Bike]
from clean_bike_buyers)
select family_range, sum(Income) as Total_income from cte_family_range
where [Purchased Bike]='Yes'
group by family_range
order by 2 desc;

--bike purchased based on Marital Status and People who owned a Home

select [Marital Status], sum(Income)as Total_income from clean_bike_buyers
where [Home Owner]= 'Yes' and [Purchased Bike]= 'Yes'
group by [Marital Status];

--bike not  purchased based on Marital Status and People who owned a Home

select [Marital Status], sum(Income)as Total_income from clean_bike_buyers
where [Home Owner]= 'Yes' and [Purchased Bike]= 'No'
group by [Marital Status];

-- bike not purchased based on commute

select "Commute Distance", COUNT("Commute Distance") as distance_count,sum(Income) as total_income 
from clean_bike_buyers
where "Purchased Bike"='No'
group by "Commute Distance"
order by 3 desc;

-- bike not purchased based on Region

select Region,COUNT(Region) as Region_count, sum(income) as Total_Income from clean_bike_buyers
where "Purchased Bike"='No' 
group by Region
order by 3 desc;

-- bike not purchased based on Occupation

select Occupation,COUNT(Occupation) as Occupation_count, sum(income) as Total_Income from clean_bike_buyers
where "Purchased Bike"='No'
group by Occupation
order by 3 desc;

-- bike not purchased based on Education


select Education,COUNT(Education) as Education_count, sum(income) as Total_Income from clean_bike_buyers
where "Purchased Bike"='No'
group by Education
order by 3 desc;

-- Creating a CTE for Age Range
-- bike not purchased based on Age Range

with cte_age_range2 as
(select case
when age<=29 then 'young'
when age > 29 and age <= 49 then 'middle age'
when age >49 then 'old'
else null
end as age_range, income, [Purchased Bike]
from clean_bike_buyers)
select age_range, sum(Income) as Total_income from cte_age_range2
where [Purchased Bike]='No'
group by age_range
order by 2 desc;

-- bike not purchased based on Marital Status

select [Marital Status],count([Marital Status]) as count_married_status ,sum(Income) as Total_Income from clean_bike_buyers
where [Purchased Bike]= 'No'
group by [Marital Status]
order by 3 desc;

-- bike not purchased based on Gender

select Gender,count(Gender) as count_gender ,sum(Income) as Total_Income from clean_bike_buyers
where [Purchased Bike]= 'No'
group by Gender
order by 3 desc;

-- Creating a CTE for Family Range
-- bike not purchased based on Family Range

with cte_family_range2 as
(select case
when Children<=2 then 'Small Family'
when Children =3 then 'Medium Family'
when Children>3 then 'Large Family'
else null
end as family_range, income, [Purchased Bike]
from clean_bike_buyers)
select family_range, sum(Income) as Total_income from cte_family_range2
where [Purchased Bike]='No'
group by family_range
order by 2 desc;

--bike not purchased based on Marital Status and People who owned a Home

select [Marital Status], sum(Income)as Total_income from clean_bike_buyers
where [Home Owner]= 'Yes' and [Purchased Bike]= 'No'
group by [Marital Status];
