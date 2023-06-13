-- Create table IMPORTSDATA1
create table IMPORTSDATA1(Food_Type_Number int, 
Food_Type varchar(200), 
Food_Group varchar(200), 
Year date, 
ImportQuantity_In_1000MetricTons Number, 
Annual_Growth_in_ImportQuantity Number, 
Import_Value_in_Milliondollars number, 
Annual_Growth_In_ImportValue Number);


-- 1. Top 5 import source countries for United States
select Countries, totalexpenditurespentfrom1999to2017 as Expenditure from import_Countries 
where rownum <=5 order by totalexpenditurespentfrom1999to2017 desc;

-- 2.	Year with highest import Quantity between 1999 to 2017.
select * from (select year,sum(importquantity_in_1000metrictons) ImportQuantity from usimports_dataset 
group by year order by ImportQuantity desc) where rownum=1; 

-- 3.	Year with highest import Value between 1999 to 2017
select * from (select year,sum(Import_Value_In_MillionDollars) ImportValue from usimports_dataset 
group by year order by ImportValue asc) where rownum=1; 

-- 4.	Records with Annual growth percent in import values is less than ‘0’
select  *  from usimports_dataset where Annual_growth_in_importvalue < '0';

