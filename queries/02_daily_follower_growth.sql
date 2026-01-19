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

WITH daily_base AS (
	SELECT
    	report_date,
    	TRIM(to_char(report_date, 'Day')) AS day_of_week,
    	followers_gained
  	FROM core_followers_daily
),

-- Follower aggregation

most_follower_days AS (
	SELECT 
		MIN(followers_gained) AS lowest_day,
		MAX(followers_gained) AS highest_day
	FROM daily_base
),

-- Follower avg aggregation

daily_average AS (
	SELECT 
		AVG(followers_gained) AS avg_followers
	FROM daily_base
)

-- Final followers per day overview with KPIs

SELECT
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

	CASE
		WHEN d.followers_gained = m.highest_day THEN 'Highest day'
		WHEN d.followers_gained = m.lowest_day THEN 'Lowest day'
		ELSE NULL 
	END AS highlight,
	CASE
		WHEN d.followers_gained IS NULL THEN 'No data'
		WHEN d.followers_gained > a.avg_followers THEN 'Above average'
		WHEN d.followers_gained < a.avg_followers THEN 'Below average'
	END AS ach_day
FROM daily_base d
CROSS JOIN most_follower_days m
CROSS JOIN daily_average a
ORDER BY d.report_date 