select top 5 * from bike_buyers;
use world_layoffs;
create table c_bike_buyers(
[ID] [float] NULL,
	[Marital Status] [nvarchar](255) NULL,
	[Gender] [nvarchar](255) NULL,
	[Income] [money] NULL,
	[Children] [float] NULL,
	[Education] [nvarchar](255) NULL,
	[Occupation] [nvarchar](255) NULL,
	[Home Owner] [nvarchar](255) NULL,
	[Cars] [float] NULL,
	[Commute Distance] [nvarchar](255) NULL,
	[Region] [nvarchar](255) NULL,
	[Age] [float] NULL,
	[Purchased Bike] [nvarchar](255) NULL
) ON [PRIMARY]
GO
insert c_bike_buyers 
select  * from bike_buyers

select top 5 * from c_bike_buyers
with cte_bike as(select *, ROW_NUMBER() 
over(partition by ID,"Marital Status",Gender, income,Children,Education,Occupation,"Home Owner",Cars,"Commute Distance",Region,age,"Purchased Bike" order by ID)
as row_num
from c_bike_buyers) 
select * from cte_bike
where row_num >1

--remove duplicate

create table clean_bike_buyers(
[ID] [float] NULL,
	[Marital Status] [nvarchar](255) NULL,
	[Gender] [nvarchar](255) NULL,
	[Income] [money] NULL,
	[Children] [float] NULL,
	[Education] [nvarchar](255) NULL,
	[Occupation] [nvarchar](255) NULL,
	[Home Owner] [nvarchar](255) NULL,
	[Cars] [float] NULL,
	[Commute Distance] [nvarchar](255) NULL,
	[Region] [nvarchar](255) NULL,
	[Age] [float] NULL,
	[Purchased Bike] [nvarchar](255) NULL,
	[row_num] [int] null
) ON [PRIMARY]
GO
insert clean_bike_buyers
select *, ROW_NUMBER() 
over(partition by ID,"Marital Status",Gender, income,Children,Education,Occupation,"Home Owner",Cars,"Commute Distance",Region,age,"Purchased Bike" order by ID)
as row_num
from c_bike_buyers;

delete 
from clean_bike_buyers
where row_num > 1;

select top 5 * from clean_bike_buyers;

update clean_bike_buyers
set "Marital Status" = 'Married'
where "Marital Status" = 'M';

update clean_bike_buyers
set [Marital Status]= 'Single'
where [Marital Status]='S';

update clean_bike_buyers
set Gender= 'Male'
where Gender='M';

update clean_bike_buyers
set Gender= 'Female'
where Gender='F';

alter table clean_bike_buyers
drop column row_num