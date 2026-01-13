/*
====================================================
 Project: LinkedIn Analytics (SQL)
 File: 02_daily_follower_growth.sql
 Author: Alex Hedges
 Description:
   Tracking daily follower growth 
   for LinkedIn content during November 2025.

 Outputs:
   - Followers gained per day
   - Above and below average metrics
   - Best performing day and worst performing day
====================================================
*/

-- Assumptions:
-- 1. Dataset contains daily followers gained from November 2025 only
-- 2. Each date appears once in core_followers_daily
-- 3. Missing dates imply zero follower growth

-- Follower count on each day

with daily_base as (
	select
    	report_date,
    	trim(to_char(report_date, 'Day')) as day_of_week,
    	followers_gained
  	from core_followers_daily
),

-- Follower aggregation

most_follower_days as (
	select 
		min(followers_gained) as lowest_day,
		max(followers_gained) as highest_day
	from daily_base
),

-- Follower avg aggregation

daily_average as (
	select 
		avg(followers_gained) as avg_followers
	from daily_base
)

-- Final followers per day overview with KPIs

select
	d.report_date,
	d.day_of_week,
	d.followers_gained,

    -- KPIs:
    -- highlight:
    --  Measures highest day and lowest day for followers gained.
    --  
    -- avg_each_day:
    --  Compares each day against the average.
    --  Indicates how often followers gained was above average.

	case
		when d.followers_gained = m.highest_day then 'Highest day'
		when d.followers_gained = m.lowest_day then 'Lowest day'
		else null 
	end as highlight,
	case
		when d.followers_gained is null then 'No data'
		when d.followers_gained > a.avg_followers then 'Above average'
		when d.followers_gained < a.avg_followers then 'Below average'
	end	as avg_each_day
from daily_base d
cross join most_follower_days m
cross join daily_average a
order by d.report_date 