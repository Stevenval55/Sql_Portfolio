select top 5 * from Cyber_security;

create table new_cybersecurity(
Country varchar (max)null, 
Region varchar (max)null,
CEI float null,
GCI float null,
NCSI float null,
DDL float null);

insert new_cybersecurity
select * from Cyber_security;

with CTE_duplicate as(
select *,Row_Number() over(partition by country,Region,CEI,GCI,NCSI,DDL order by country)as Row_num
from new_cybersecurity)
select * from CTE_duplicate
where Row_num > 1;

select * from new_cybersecurity where CEI=' ';

update new_cybersecurity
set CEI=null
where CEI='';

update new_cybersecurity
set GCI=null
where GCI='';

update new_cybersecurity
set NCSI=null
where NCSI='';

update new_cybersecurity
set DDL=null
where DDL='';

select country,region,
Round(coalesce (CEI, avg(CEI) over()), 3) as CEI,
Round (coalesce (GCI, avg(GCI) over ()), 2)as GCI,
Round (coalesce (NCSI, avg(NCSI) over ()),2)  as NCSI,
Round (coalesce (DDL, avg(DDL) over ()),2) as DDL
from new_cybersecurity;

create table new_cybersecurity_2(
Country varchar (max)null, 
Region varchar (max)null,
CEI float null,
GCI float null,
NCSI float null,
DDL float null);

insert new_cybersecurity_2
select country,region,
Round(coalesce (CEI, avg(CEI) over()), 3) as CEI,
Round (coalesce (GCI, avg(GCI) over ()), 2)as GCI,
Round (coalesce (NCSI, avg(NCSI) over ()),2)  as NCSI,
Round (coalesce (DDL, avg(DDL) over ()),2) as DDL
from new_cybersecurity;

select region,
Round (AVG(CEI),3) as CEI,
Round (AVG(GCI),2) as GCI,
Round (AVG(NCSI),2) as NCSI,
Round (AVG(DDL),2) as DDL
from new_cybersecurity_2
group by Region
order by 1;

select country,CEI,GCI,NCSI,DDL
from new_cybersecurity_2
where region= 'Africa';

select country,CEI,GCI,NCSI,DDL
from new_cybersecurity_2
where region= 'Asia-Pasific';

select country,CEI,GCI,NCSI,DDL
from new_cybersecurity_2
where region= 'Europe';

select country,CEI,GCI,NCSI,DDL
from new_cybersecurity_2
where region= 'North America';

select country,CEI,GCI,NCSI,DDL
from new_cybersecurity_2
where region= 'South America';