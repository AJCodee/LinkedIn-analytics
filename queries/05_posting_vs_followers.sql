/*
====================================================
 Project: LinkedIn Analytics (SQL)
 File: 05_posting_vs_followers.sql
 Author: Alex Hedges
 Description:
   Relationship between posting and follower growth
   for LinkedIn content during November 2025.

 Outputs:
	- One row per day/date for the month of November.
  	- Calculated how many posts per day.
  	- Performance metrics: impressions, likes, comments, shares and followers gained.
  	- Sorted by followers_gained and seperated into impression buckets.
====================================================
*/

-- Follower count

WITH daily_followers AS (
    SELECT
        report_date::date AS report_date,
        followers_gained
    FROM core_followers_daily
),

-- Posting aggregation

daily_posting AS (
    SELECT
        post_date,
        COUNT(post_id) AS posts_per_day,
        SUM(impressions) AS total_impressions,
        (SUM(likes) + SUM(comments) + SUM(shares)) AS total_engagement
    FROM core_posts
    WHERE topic IS NOT NULL   
    GROUP BY post_date
)

-- Final select statement 

SELECT
    f.report_date,
    COALESCE(p.posts_per_day, 0) AS posts_per_day,
    COALESCE(p.total_impressions, 0) AS total_impressions,
    COALESCE(p.total_engagement, 0) AS total_engagement,
    f.followers_gained,

  -- KPIs:
  -- impression_ranges:
  --   Seperation of posts in impression buckets. 
  --   Used to evaluate if higher impressions led to more followers.

    CASE
  	    WHEN p.total_impressions BETWEEN 1 AND 10000 THEN 'low impressions'
  	    WHEN p.total_impressions BETWEEN 10001 AND 30000 THEN 'medium impressions'
  	    WHEN p.total_impressions BETWEEN 30001 AND 160000 THEN 'high impressions'
  	    ELSE 'No post'
    END AS impression_ranges 
FROM daily_followers f
LEFT JOIN daily_posting p
  ON p.post_date = f.report_date
ORDER BY f.followers_gained desc nulls last; -- NULLS LAST put null values last (Instead of at the top)