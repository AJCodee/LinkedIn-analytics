/*
====================================================
 Project: LinkedIn Analytics (SQL)
 File: 01_monthly_overview.sql
 Author: Alex Hedges
 Description:
   Produces a single-row monthly performance overview
   for LinkedIn content during November 2025.

 Outputs:
   - Post volume and engagement totals
   - Follower growth totals
   - Engagement and growth efficiency KPIs
====================================================
*/

-- Assumptions:
-- 1. Dataset contains posts from November 2025 only
-- 2. core_posts contains one row per LinkedIn post
-- 3. core_followers_daily contains daily follower deltas
-- 4. post_date and report_date are DATE types
-- 5. This query is intended as a baseline overview,
--    not a month-over-month comparison

-- Monthly post-level aggregation

WITH posts_month AS (
SELECT
	COUNT(*) AS total_posts,
	SUM(impressions) AS total_impressions,
	SUM(likes) AS total_likes,
	SUM(comments) AS total_comments,
	SUM(shares) AS total_shares
FROM core_posts
WHERE post_date >= '2025-11-01' AND post_date < '2025-12-01'
),

-- Monthly follower growth aggregation

followers_month AS (
SELECT 
	SUM(followers_gained) AS total_followers
FROM core_followers_daily
WHERE report_date >= '2025-11-01' AND report_date < '2025-12-01'
)

-- Final monthly overview with KPIs

SELECT
	p.total_posts,
	p.total_impressions,
	p.total_likes,
	p.total_comments,
	p.total_shares,
	f.total_followers,

	-- KPIs:
	-- likes_per_post:
	--   Measures average engagement per post.
	--   Used to evaluate content quality independent of volume.
	--
	-- followers_per_post:
	--   Measures growth efficiency.
	--   Indicates how effectively posts convert activity into followers.

	CASE 
		WHEN p.total_posts = 0 THEN NULL
		ELSE p.total_likes / p.total_posts
	END AS likes_per_post,
	CASE
		WHEN p.total_posts = 0 THEN NULL
		ELSE f.total_followers / p.total_posts
	END AS followers_per_post
FROM posts_month p
CROSS JOIN followers_month f;