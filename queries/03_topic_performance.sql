/*
====================================================
 Project: LinkedIn Analytics (SQL)
 File: 03_topic_performance.sql
 Author: Alex Hedges
 Description:
   Topic overview 
   for LinkedIn content during November 2025.

 Outputs:
   - Topic engagements calculated for November.
   - Engagement rate percentage.
   - Best performing topic.
====================================================
*/

-- Aggregations for engagement 

WITH overall_engagement AS (
	SELECT 
		topic,
		COUNT(*) AS total_posts,
		SUM(impressions) AS total_impressions,
		SUM(likes) AS total_likes,
		SUM(comments) AS total_comments,
		SUM(shares) AS total_shares,
		(SUM(likes) + SUM(comments) + SUM(shares)) AS total_engagement,
		ROUND( 
			((SUM(likes) + SUM(comments) + SUM(shares))::numeric
			/ NULLIF(SUM(impressions), 0)) * 100, 2 ) AS engagement_rate_pct
	FROM core_posts
	WHERE topic IS NOT NULL
	GROUP BY topic
)

-- Final Select statement 

SELECT
	topic,
	total_posts,
	total_impressions,
	total_likes,
	total_comments,
	total_shares,
	total_engagement,
	engagement_rate_pct,

	-- KPIs:
    -- impressions_share_pct:
    --  Each topics overall share of total impressions in percentage.

	ROUND(total_impressions * 100 / NULLIF( SUM(total_impressions) OVER (), 0 ), 2) AS impressions_share_pct
FROM overall_engagement
ORDER BY impressions_share_pct DESC