alter database [Sanitation & Water Global Indexes]
set recovery full
go

use [Sanitation & Water Global Indexes]
go

-- Explore
-- Clean
-- Manipulate
-- Analyse

--EXPLORE

	SELECT top 10 *
	from BSMDWS;

	select top 10 *
	from BSMSS;

	select top 10 *
	from HWS;

	select top 10 *
	from OD;

	exec sp_help '[Sanitation & Water Global Indexes]..bsmdws';
	exec sp_help '[Sanitation & Water Global Indexes]..bsmss';
	exec sp_help '[Sanitation & Water Global Indexes]..hws';
	exec sp_help '[Sanitation & Water Global Indexes]..OD';


	--Count of Rows
	select count (*) as Number_Of_Rows
	from BSMDWS;

	select count (*) as Number_Of_Rows
	from BSMSS;

	select count (*) as Number_Of_Rows
	from HWS;

	select count (*) as Number_of_Rows
	from OD;


	-- Count of Columns

	select COUNT(*) as Number_of_Columns
	from INFORMATION_SCHEMA.COLUMNS
	where table_name = 'BSMDWS';

	select COUNT(*) as Number_of_Columns
	from INFORMATION_SCHEMA.COLUMNS
	where table_name = 'BSMSS';

	select COUNT(*) as Number_of_Columns
	from INFORMATION_SCHEMA.COLUMNS
	where table_name = 'HWS';

	select COUNT(*) as Number_of_Columns
	from INFORMATION_SCHEMA.COLUMNS
	where table_name = 'OD';


-- DATA CLEANING

	--Check for Duplicates

	select [GHO (DISPLAY)],[YEAR (DISPLAY)], [REGION (DISPLAY)], [COUNTRY (DISPLAY)], [RESIDENCEAREATYPE (DISPLAY)], [Display Value], Numeric
	from BSMDWS
	group by [YEAR (DISPLAY)], [REGION (DISPLAY)], [COUNTRY (DISPLAY)],
	[RESIDENCEAREATYPE (DISPLAY)], [Display Value], Numeric, [GHO (DISPLAY)]
	having count (*) >1
	order by [COUNTRY (DISPLAY)];


	select [GHO (DISPLAY)],[YEAR (DISPLAY)], [REGION (DISPLAY)], [COUNTRY (DISPLAY)], [RESIDENCEAREATYPE (DISPLAY)], [Display Value], Numeric
	from BSMSS
	group by [YEAR (DISPLAY)], [REGION (DISPLAY)], [COUNTRY (DISPLAY)],
	[RESIDENCEAREATYPE (DISPLAY)], [Display Value], Numeric, [GHO (DISPLAY)]
	having count (*) >1
	order by [COUNTRY (DISPLAY)];

	select [GHO (DISPLAY)],[YEAR (DISPLAY)], [REGION (DISPLAY)], [COUNTRY (DISPLAY)], [RESIDENCEAREATYPE (DISPLAY)], [Display Value], Numeric
	from HWS
	group by [YEAR (DISPLAY)], [REGION (DISPLAY)], [COUNTRY (DISPLAY)],
	[RESIDENCEAREATYPE (DISPLAY)], [Display Value], Numeric, [GHO (DISPLAY)]
	having count (*) >1
	order by [COUNTRY (DISPLAY)];

	select [GHO (DISPLAY)],[YEAR (DISPLAY)], [REGION (DISPLAY)], [COUNTRY (DISPLAY)], [RESIDENCEAREATYPE (DISPLAY)], [Display Value], Numeric
	from OD
	group by [YEAR (DISPLAY)], [REGION (DISPLAY)], [COUNTRY (DISPLAY)],
	[RESIDENCEAREATYPE (DISPLAY)], [Display Value], Numeric, [GHO (DISPLAY)]
	having count (*) >1
	order by [COUNTRY (DISPLAY)];


	-- Drop Columns not in Use for this Project (BSMDWS table)

	alter table BSMDWS
	drop column [GHO (CODE)], [GHO (URL)], [PUBLISHSTATE (DISPLAY)], [PUBLISHSTATE (URL)],[YEAR (CODE)],
	[YEAR (URL)], [REGION (CODE)], [REGION (URL)], [COUNTRY (CODE)], [COUNTRY (URL)], [RESIDENCEAREATYPE (CODE)], [RESIDENCEAREATYPE (URL)],
	[LOW], [HIGH], STDERR, STDDEV, COMMENTS;

	-- Drop Columns not in Use for this Project (BSMSS table)

	alter table BSMSS
	drop column [GHO (CODE)], [GHO (URL)], [PUBLISHSTATE (DISPLAY)], [PUBLISHSTATE (URL)],[YEAR (CODE)],
	[YEAR (URL)], [REGION (CODE)], [REGION (URL)], [COUNTRY (CODE)], [COUNTRY (URL)], [RESIDENCEAREATYPE (CODE)], [RESIDENCEAREATYPE (URL)],
	[LOW], [HIGH], STDERR, STDDEV, COMMENTS;


	-- Drop Columns not in Use for this Project (HWS table)

	alter table HWS
	drop column [GHO (CODE)], [GHO (URL)], [PUBLISHSTATE (DISPLAY)], [PUBLISHSTATE (URL)],[YEAR (CODE)],
	[YEAR (URL)], [REGION (CODE)], [REGION (URL)], [COUNTRY (CODE)], [COUNTRY (URL)], [RESIDENCEAREATYPE (CODE)], [RESIDENCEAREATYPE (URL)],
	[LOW], [HIGH], STDERR, STDDEV, COMMENTS;

	-- Drop Columns not in Use for this Project (OD table)

	alter table OD
	drop column [GHO (CODE)], [GHO (URL)], [PUBLISHSTATE (DISPLAY)], [PUBLISHSTATE (URL)],[YEAR (CODE)],
	[YEAR (URL)], [REGION (CODE)], [REGION (URL)], [COUNTRY (CODE)], [COUNTRY (URL)], [RESIDENCEAREATYPE (CODE)], [RESIDENCEAREATYPE (URL)],
	[LOW], [HIGH], STDERR, STDDEV, COMMENTS;


	-- Check for Null Values in the BSMDWS Table

	select
	SUM (case when [GHO (DISPLAY)] is null then 1 else 0 end) as GHO_DISPLAY,
	SUM (case when [PUBLISHSTATE (CODE)] is null then 1 else 0 end) AS PUBLISH_STATE,
	SUM	(case when [YEAR (DISPLAY)] is null then 1 else 0 end) AS YEAR,
	SUM	(case when [REGION (DISPLAY)] is null then 1 else 0 end) AS REGION,
	sum (case when [COUNTRY (DISPLAY)] is null then 1 else 0 end) AS COUNTRY,
	SUM	(case when [RESIDENCEAREATYPE (DISPLAY)] is null then 1 else 0 end) AS RESIDENCE,
	SUM	(case when [Display Value] is null then 1 else 0 end) AS DISPLAY_VALUE,
	SUM	(case when Numeric is null then 1 else 0 end) AS NUMERIC
	from BSMDWS;

	-- Check for Null Values in the BSMSS Table

	select
	SUM (case when [GHO (DISPLAY)] is null then 1 else 0 end) as GHO_DISPLAY,
	SUM (case when [PUBLISHSTATE (CODE)] is null then 1 else 0 end) AS PUBLISH_STATE,
	SUM	(case when [YEAR (DISPLAY)] is null then 1 else 0 end) AS YEAR,
	SUM	(case when [REGION (DISPLAY)] is null then 1 else 0 end) AS REGION,
	sum (case when [COUNTRY (DISPLAY)] is null then 1 else 0 end) AS COUNTRY,
	SUM	(case when [RESIDENCEAREATYPE (DISPLAY)] is null then 1 else 0 end) AS RESIDENCE,
	SUM	(case when [Display Value] is null then 1 else 0 end) AS DISPLAY_VALUE,
	SUM	(case when Numeric is null then 1 else 0 end) AS NUMERIC
	from BSMSS;

	-- Check for Null Values in the HWS Table

	select
	SUM (case when [GHO (DISPLAY)] is null then 1 else 0 end) as GHO_DISPLAY,
	SUM (case when [PUBLISHSTATE (CODE)] is null then 1 else 0 end) AS PUBLISH_STATE,
	SUM	(case when [YEAR (DISPLAY)] is null then 1 else 0 end) AS YEAR,
	SUM	(case when [REGION (DISPLAY)] is null then 1 else 0 end) AS REGION,
	sum (case when [COUNTRY (DISPLAY)] is null then 1 else 0 end) AS COUNTRY,
	SUM	(case when [RESIDENCEAREATYPE (DISPLAY)] is null then 1 else 0 end) AS RESIDENCE,
	SUM	(case when [Display Value] is null then 1 else 0 end) AS DISPLAY_VALUE,
	SUM	(case when Numeric is null then 1 else 0 end) AS NUMERIC
	from HWS;

	-- Check for Null Values in the OD Table

	select
	SUM (case when [GHO (DISPLAY)] is null then 1 else 0 end) as GHO_DISPLAY,
	SUM (case when [PUBLISHSTATE (CODE)] is null then 1 else 0 end) AS PUBLISH_STATE,
	SUM	(case when [YEAR (DISPLAY)] is null then 1 else 0 end) AS YEAR,
	SUM	(case when [REGION (DISPLAY)] is null then 1 else 0 end) AS REGION,
	sum (case when [COUNTRY (DISPLAY)] is null then 1 else 0 end) AS COUNTRY,
	SUM	(case when [RESIDENCEAREATYPE (DISPLAY)] is null then 1 else 0 end) AS RESIDENCE,
	SUM	(case when [Display Value] is null then 1 else 0 end) AS DISPLAY_VALUE,
	SUM	(case when Numeric is null then 1 else 0 end) AS NUMERIC
	from OD;



-- DATA MANIPULATION

	--updating Null Values in the BSMDWS table to 0

	update BSMDWS
	set [Display Value] = 0
	where [Display Value] is null;

	update BSMDWS
	set Numeric = 0
	where Numeric is null;


	-- Calculate Central Tendency

	-- MEAN, MIN, MAX, Standard Deviation (BSMDWS)
	select  [COUNTRY (DISPLAY)] ,AVG([Display Value]) as Average_Display_Value, MIN([Display Value]) as Minimim_Display_Value, MAX([Display Value]) as Maximum_Display_Value,
	AVG(Numeric) as Average_Numeric,MIN(Numeric) as Minimum_Numeric, MAX(Numeric) AS Maximum_Numeric, STDEV([Display Value]) as Display_Value_StandardDeviation,
	STDEV(Numeric) as Numeric_StandardDeviation
	from BSMDWS
	group by [COUNTRY (DISPLAY)]
	order by Average_Display_Value;

	-- MEAN, MIN, MAX, Standard Deviation (BSMSS)
	select  [COUNTRY (DISPLAY)] ,AVG([Display Value]) as Average_Display_Value, MIN([Display Value]) as Minimim_Display_Value, MAX([Display Value]) as Maximum_Display_Value,
	AVG(Numeric) as Average_Numeric,MIN(Numeric) as Minimum_Numeric, MAX(Numeric) AS Maximum_Numeric, STDEV([Display Value]) as Display_Value_StandardDeviation,
	STDEV(Numeric) as Numeric_StandardDeviation
	from BSMSS
	group by [COUNTRY (DISPLAY)]
	order by Average_Display_Value;

	-- MEAN, MIN, MAX, Standard Deviation (HWS)
	select  [COUNTRY (DISPLAY)] ,AVG([Display Value]) as Average_Display_Value, MIN([Display Value]) as Minimim_Display_Value, MAX([Display Value]) as Maximum_Display_Value,
	AVG(Numeric) as Average_Numeric,MIN(Numeric) as Minimum_Numeric, MAX(Numeric) AS Maximum_Numeric, STDEV([Display Value]) as Display_Value_StandardDeviation,
	STDEV(Numeric) as Numeric_StandardDeviation
	from HWS
	group by [COUNTRY (DISPLAY)]
	order by Average_Display_Value;

	-- MEAN, MIN, MAX, standard Deviation (OD)
	select  [COUNTRY (DISPLAY)] ,AVG([Display Value]) as Average_Display_Value, MIN([Display Value]) as Minimim_Display_Value, MAX([Display Value]) as Maximum_Display_Value,
	AVG(Numeric) as Average_Numeric,MIN(Numeric) as Minimum_Numeric, MAX(Numeric) AS Maximum_Numeric, STDEV([Display Value]) as Display_Value_StandardDeviation,
	STDEV(Numeric) as Numeric_StandardDeviation
	from OD
	group by [COUNTRY (DISPLAY)]
	order by Average_Display_Value desc;


-- DATA ANALYSIS

	-- % of population with access to safely managed drinking water by Country

	select [COUNTRY (DISPLAY)], CONCAT(CAST(100.0 * SUM(case when [GHO (DISPLAY)] = 'Population using safely managed drinking-water services (%)' then 1 else 0 end)/ COUNT(*) as float), '%') as Population_withAccessTo_Safely_Managed_Drinking_Water_Service
	from BSMDWS
	group by [COUNTRY (DISPLAY)]
	order by Population_withAccessTo_Safely_Managed_Drinking_Water_Service desc;


	-- % 0f Population using at least basic drinking-water services by Country

	select [COUNTRY (DISPLAY)], CONCAT(CAST(100.0 * SUM(case when [GHO (DISPLAY)] = 'Population using at least basic drinking-water services (%)' then 1 else 0 end)/ COUNT(*) as float), '%') as Population_using@Least_Basic_Drinking_Water_Service
	from BSMDWS
	group by [COUNTRY (DISPLAY)]
	order by Population_using@Least_Basic_Drinking_Water_Service;

	--Population Using Safely Managed Sanitation Services


	select [COUNTRY (DISPLAY)], CONCAT(SUM(CASE when [GHO (DISPLAY)] = 'Population using safely managed sanitation services (%)' then 1 else 0 end)* 100/ CAST(COUNT(*) as float), '%') as Population_using_Safely_Managed_Sanitation_Service
	from BSMSS
	group by [COUNTRY (DISPLAY)]
	order by Population_using_Safely_Managed_Sanitation_Service desc;

	--% of Population using at least basic sanitation services

	select [COUNTRY (DISPLAY)], CONCAT(CAST(100.0 * SUM(case when [GHO (DISPLAY)] = 'Population using at least basic sanitation services (%)' then 1 else 0 end)/ COUNT(*) as float), '%') as Population_Using@Least_Basic_Sanitation_Services
	from BSMSS
	group by [COUNTRY (DISPLAY)]
	order by Population_Using@Least_Basic_Sanitation_Services desc;

	-- Count of population with basic Hand-washing facilities at Home by Country

	select [COUNTRY (DISPLAY)], COUNT(*) as Population_Covered_by_Survey
	from HWS
	group by [COUNTRY (DISPLAY)]
	order by Population_Covered_by_Survey;

	-- Count of Population practising Open defication by Country

	select [COUNTRY (DISPLAY)], COUNT(*) as Population_Size_Covered_by_Survey
	from OD
	group by [COUNTRY (DISPLAY)]
	order by Population_Size_Covered_by_Survey;
	---------------------------------------------------------------------------------

	-- Count of Urban Population Using Safely Managed Drinking Water Service
	select [COUNTRY (DISPLAY)] as Country, SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'urban' then 1 else 0 end) as Number_of_Urban_Residence
	from BSMDWS
	where [GHO (DISPLAY)] = 'Population using safely managed drinking-water services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Number_of_Urban_Residence desc;

	-- Count of Rural Population Using Safely Managed Drinking Water Service
	select [COUNTRY (DISPLAY)] as Country, SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Rural' then 1 else 0 end) as Number_of_Rural_Residence
	from BSMDWS
	where [GHO (DISPLAY)] = 'Population using safely managed drinking-water services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Number_of_Rural_Residence desc;
	
	-- Count of Total Population Using Safely Managed Drinking Water Service
	select [COUNTRY (DISPLAY)] as Country, SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Total' then 1 else 0 end) as Number_of_Total_Residence
	from BSMDWS
	where [GHO (DISPLAY)] = 'Population using safely managed drinking-water services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Number_of_Total_Residence desc;

	------------------------------------------------------------------------------------------------

	-- % of Urban population using Safely Managed Drinking Water Service

	select [COUNTRY (DISPLAY)] as Country, CONCAT(CAST(100.0 * SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Urban' then 1 else 0 end)/ COUNT(*) as float), '%') as Percentage_of_Safely_Managed_Sanitation_Service
	from BSMDWS
	where [GHO (DISPLAY)] = 'Population using safely managed drinking-water services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Percentage_of_Safely_Managed_Sanitation_Service desc;

	-- % of Rural population using Safely Managed Drinking Water Service

	select [COUNTRY (DISPLAY)] as Country, CONCAT(CAST(100.0 * SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Rural' then 1 else 0 end)/ COUNT(*) as float), '%') as Percentage_of_Safely_Managed_Sanitation_Service
	from BSMDWS
	where [GHO (DISPLAY)] = 'Population using safely managed drinking-water services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Percentage_of_Safely_Managed_Sanitation_Service desc;

	-- % of Total population using Safely Managed Drinking Water Service

	select [COUNTRY (DISPLAY)] as Country, CONCAT(CAST(100.0 * SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Total' then 1 else 0 end)/ COUNT(*) as float), '%') as Percentage_of_Safely_Managed_Sanitation_Service
	from BSMDWS
	where [GHO (DISPLAY)] = 'Population using safely managed drinking-water services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Percentage_of_Safely_Managed_Sanitation_Service desc;
	-------------------------------------------------------------------------------------------------

	-- Count of Urban Residence using at least basic Drinking Water service

	select [COUNTRY (DISPLAY)] as Country, SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'urban' then 1 else 0 end) as Number_of_Urban_Residence
	from BSMDWS
	where [GHO (DISPLAY)] = 'Population using at least basic drinking-water services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Number_of_Urban_Residence desc;

	-- Count of Rural Population using Using at least basic Drinking Water service
	select [COUNTRY (DISPLAY)] as Country, SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Rural' then 1 else 0 end) as Number_of_Rural_Residence
	from BSMDWS
	where [GHO (DISPLAY)] = 'Population using at least basic drinking-water services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Number_of_Rural_Residence desc;
	
	-- Count of Total Population Using at least Drinking Water service
	select [COUNTRY (DISPLAY)] as Country, SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Total' then 1 else 0 end) as Number_of_Total_Residence
	from BSMDWS
	where [GHO (DISPLAY)] = 'Population using at least basic drinking-water services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Number_of_Total_Residence desc;

	-------------------------------------------------------------------------------------------------

	-- % of Urban population using at least Basic Drinking Water service

	select [COUNTRY (DISPLAY)] as Country, CONCAT(CAST(100.0 * SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Urban' then 1 else 0 end)/ COUNT(*) as float), '%') as Percentage_of_Safely_Managed_Sanitation_Service
	from BSMDWS
	where [GHO (DISPLAY)] = 'Population using at least basic drinking-water services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Percentage_of_Safely_Managed_Sanitation_Service desc;

	-- % of Rural population using at least Basic Drinking Water service

	select [COUNTRY (DISPLAY)] as Country, CONCAT(CAST(100.0 * SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Rural' then 1 else 0 end)/ COUNT(*) as float), '%') as Percentage_of_Safely_Managed_Sanitation_Service
	from BSMDWS
	where [GHO (DISPLAY)] = 'Population using at least basic drinking-water services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Percentage_of_Safely_Managed_Sanitation_Service desc;

	-- % of Total population using at least Basic Drinking Water service

	select [COUNTRY (DISPLAY)] as Country, CONCAT(CAST(100.0 * SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Total' then 1 else 0 end)/ COUNT(*) as float), '%') as Percentage_of_Safely_Managed_Sanitation_Service
	from BSMDWS
	where [GHO (DISPLAY)] = 'Population using at least basic drinking-water services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Percentage_of_Safely_Managed_Sanitation_Service desc;


	-------------------------------------------------------------------------------------------------

	-- Count of Urban Population Using Safely Managed Sanitation Services
	select [COUNTRY (DISPLAY)] as Country, SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'urban' then 1 else 0 end) as Number_of_Urban_Residence
	from BSMSS
	where [GHO (DISPLAY)] = 'Population using safely managed sanitation services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Number_of_Urban_Residence desc;

	-- Count of Rural Population Using Safely Managed Sanitation Services 
	select [COUNTRY (DISPLAY)] as Country, SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Rural' then 1 else 0 end) as Number_of_Rural_Residence
	from BSMSS
	where [GHO (DISPLAY)] = 'Population using safely managed sanitation services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Number_of_Rural_Residence desc;
	
	-- Count of Total Population Using Safely Managed Sanitation Services 
	select [COUNTRY (DISPLAY)] as Country, SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Total' then 1 else 0 end) as Number_of_Total_Residence
	from BSMSS
	where [GHO (DISPLAY)] = 'Population using safely managed sanitation services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Number_of_Total_Residence desc;

	------------------------------------------------------------------------------------------------

	-- % of Urban population using Safely Managed Sanitation Service

	select [COUNTRY (DISPLAY)] as Country, CONCAT(CAST(100.0 * SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Urban' then 1 else 0 end)/ COUNT(*) as float), '%') as Percentage_of_Safely_Managed_Sanitation_Service
	from BSMSS
	where [GHO (DISPLAY)] = 'Population using safely managed sanitation services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Percentage_of_Safely_Managed_Sanitation_Service desc;

	-- % of Rural population using Safely Managed Sanitation Service

	select [COUNTRY (DISPLAY)] as Country, CONCAT(CAST(100.0 * SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Rural' then 1 else 0 end)/ COUNT(*) as float), '%') as Percentage_of_Safely_Managed_Sanitation_Service
	from BSMSS
	where [GHO (DISPLAY)] = 'Population using safely managed sanitation services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Percentage_of_Safely_Managed_Sanitation_Service desc;

	-- % of Total population using Safely Managed Sanitation Service

	select [COUNTRY (DISPLAY)] as Country, CONCAT(CAST(100.0 * SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Total' then 1 else 0 end)/ COUNT(*) as float), '%') as Percentage_of_Safely_Managed_Sanitation_Service
	from BSMSS
	where [GHO (DISPLAY)] = 'Population using safely managed sanitation services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Percentage_of_Safely_Managed_Sanitation_Service desc;
	-------------------------------------------------------------------------------------------------

	-- Count of Urban Residence using at least basic sanitation services

	select [COUNTRY (DISPLAY)] as Country, SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'urban' then 1 else 0 end) as Number_of_Urban_Residence
	from BSMSS
	where [GHO (DISPLAY)] = 'Population using at least basic sanitation services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Number_of_Urban_Residence desc;

	-- Count of Rural Population using Using at least basic sanitation services
	select [COUNTRY (DISPLAY)] as Country, SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Rural' then 1 else 0 end) as Number_of_Rural_Residence
	from BSMSS
	where [GHO (DISPLAY)] = 'Population using at least basic sanitation services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Number_of_Rural_Residence desc;
	
	-- Count of Total Population Using at least basic sanitation services
	select [COUNTRY (DISPLAY)] as Country, SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Total' then 1 else 0 end) as Number_of_Total_Residence
	from BSMSS
	where [GHO (DISPLAY)] = 'Population using at least basic sanitation services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Number_of_Total_Residence desc;

	-------------------------------------------------------------------------------------------------

	-- % of Urban population using at least Basic Sanitation Services

	select [COUNTRY (DISPLAY)] as Country, CONCAT(CAST(100.0 * SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Urban' then 1 else 0 end)/ COUNT(*) as float), '%') as Percentage_of_Safely_Managed_Sanitation_Service
	from BSMSS
	where [GHO (DISPLAY)] = 'Population using at least basic sanitation services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Percentage_of_Safely_Managed_Sanitation_Service desc;

	-- % of Rural population using at least Basic Sanitation Services

	select [COUNTRY (DISPLAY)] as Country, CONCAT(CAST(100.0 * SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Rural' then 1 else 0 end)/ COUNT(*) as float), '%') as Percentage_of_Safely_Managed_Sanitation_Service
	from BSMSS
	where [GHO (DISPLAY)] = 'Population using at least basic sanitation services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Percentage_of_Safely_Managed_Sanitation_Service desc;

	-- % of Total population using at least Basic Sanitation Services

	select [COUNTRY (DISPLAY)] as Country, CONCAT(CAST(100.0 * SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Total' then 1 else 0 end)/ COUNT(*) as float), '%') as Percentage_of_Safely_Managed_Sanitation_Service
	from BSMSS
	where [GHO (DISPLAY)] = 'Population using at least basic sanitation services (%)'
	group by [COUNTRY (DISPLAY)]
	order by Percentage_of_Safely_Managed_Sanitation_Service desc;
	
	-------------------------------------------------------------------------------------------------

	-- Count of Urban Population with Basic Hand Washing Facilities at Home 
	select [COUNTRY (DISPLAY)], COUNT([RESIDENCEAREATYPE (DISPLAY)]) as Number_of_Residence
	from HWS
	where [RESIDENCEAREATYPE (DISPLAY)] = 'Urban'
	group by [COUNTRY (DISPLAY)]
	order by Number_of_Residence desc;

	-- Count of Rural Population with Basic Hand Washing Facilities at Home 
	select [COUNTRY (DISPLAY)], COUNT([RESIDENCEAREATYPE (DISPLAY)]) as Number_of_Residence
	from HWS
	where [RESIDENCEAREATYPE (DISPLAY)] = 'Rural'
	group by [COUNTRY (DISPLAY)]
	order by Number_of_Residence desc;


	-- Count of Total Population with Basic Hand Washing Facilities at Home 
	select [COUNTRY (DISPLAY)], COUNT([RESIDENCEAREATYPE (DISPLAY)]) as Number_of_Residence
	from HWS
	where [RESIDENCEAREATYPE (DISPLAY)] = 'Total'
	group by [COUNTRY (DISPLAY)]
	order by Number_of_Residence desc;


	-------------------------------------------------------------------------------------------------

	-- % of Urban Population who practise Open Defication in each country
	Select [COUNTRY (DISPLAY)] as Country, CONCAT(CAST(100.0 * SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Urban' then 1 else 0 end)/ COUNT(*) as float), '%') as Percentage_of_Open_Defication
	from HWS
	group by [COUNTRY (DISPLAY)]
	order by Percentage_of_Open_Defication desc;

	-- % of Rural Population who practise Open Defication in each country
	Select [COUNTRY (DISPLAY)] as Country, CONCAT(CAST(100.0 * SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Rural' then 1 else 0 end)/ COUNT(*) as float), '%') as Percentage_of_Open_Defication
	from HWS
	group by [COUNTRY (DISPLAY)]
	order by Percentage_of_Open_Defication desc;

	-- % of Rural Population who practise Open Defication in each country
	Select [COUNTRY (DISPLAY)] as Country, CONCAT(CAST(100.0 * SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Total' then 1 else 0 end)/ COUNT(*) as float), '%') as Percentage_of_Open_Defication
	from HWS
	group by [COUNTRY (DISPLAY)]
	order by Percentage_of_Open_Defication desc;

	-------------------------------------------------------------------------------------------------

	-- Count of Urban Population who Practise Open Defication in each country

	select [COUNTRY (DISPLAY)] as Country, COUNT([RESIDENCEAREATYPE (DISPLAY)]) as Number_of_Residence
	from OD
	where [RESIDENCEAREATYPE (DISPLAY)] = 'Urban'
	group by [COUNTRY (DISPLAY)]
	order by Number_of_Residence;

	-- Count of Rural Population who Practise Open Defication in each country
	select [COUNTRY (DISPLAY)] as Country, COUNT([RESIDENCEAREATYPE (DISPLAY)]) as Number_of_Residence
	from OD
	where [RESIDENCEAREATYPE (DISPLAY)] = 'Rural'
	group by [COUNTRY (DISPLAY)]
	order by Number_of_Residence;

	-- Count of Total Population who Practise Open Defication in each country

	select [COUNTRY (DISPLAY)] as Country, COUNT([RESIDENCEAREATYPE (DISPLAY)]) as Number_of_Residence
	from OD
	where [RESIDENCEAREATYPE (DISPLAY)] = 'Total'
	group by [COUNTRY (DISPLAY)]
	order by Number_of_Residence;

	--------------------------------------------------------------------------------------------------

	-- % of Urban Population who practise Open Defication in each country
	Select [COUNTRY (DISPLAY)] as Country, CONCAT(CAST(100.0 * SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Urban' then 1 else 0 end)/ COUNT(*) as float), '%') as Percentage_of_Open_Defication
	from OD
	group by [COUNTRY (DISPLAY)]
	order by Percentage_of_Open_Defication desc;

	-- % of Rural Population who practise Open Defication in each country
	Select [COUNTRY (DISPLAY)] as Country, CONCAT(CAST(100.0 * SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Rural' then 1 else 0 end)/ COUNT(*) as float), '%') as Percentage_of_Open_Defication
	from OD
	group by [COUNTRY (DISPLAY)]
	order by Percentage_of_Open_Defication desc;

	-- % of Total Population who practise Open Defication in each country
	Select [COUNTRY (DISPLAY)] as Country, CONCAT(CAST(100.0 * SUM(case when [RESIDENCEAREATYPE (DISPLAY)] = 'Total' then 1 else 0 end)/ COUNT(*) as float), '%') as Percentage_of_Open_Defication
	from OD
	group by [COUNTRY (DISPLAY)]
	order by Percentage_of_Open_Defication desc;
