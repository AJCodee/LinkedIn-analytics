/*
====================================================
 Project: LinkedIn Analytics (SQL)
 File: 04_top_post_per_topic.sql
 Author: Alex Hedges
 Description:
   Best performing post per topic,
   for LinkedIn content during November 2025.

 Outputs:
	- One row per topic (excluding NULL topics).
  	- The highest-impression post for each topic (post_id + post_date).
  	- Performance metrics for the winning post: impressions, likes, comments, shares.
  	- Sorted by impressions (desc) to show the overall top-performing topic first.
====================================================
*/

-- Assumptions:
-- 1. Dataset contains LinkedIn post data from November 2025 only.
-- 2. Each post_id represents one unique post in core_posts.
-- 3. "Best performing" is defined as the post with the highest impressions per topic.
-- 4. Posts with NULL topic are excluded from topic comparisons.

-- Base post-level data

WITH total_engagement AS (
	SELECT
		topic,
		post_id,
		post_date,
		impressions,
		likes,
		comments,
		shares
	FROM core_posts
	WHERE topic IS NOT NULL
),

-- Rank posts within each topic based on impressions

top_post_per_topic AS (
	SELECT 
		*,
		row_number() OVER(PARTITION BY topic ORDER BY impressions DESC) AS rn
	FROM total_engagement 
)

-- Final output: top post per topic

SELECT 
	topic,
	post_id,
	post_date,
	impressions,
	likes,
	comments,
	shares
FROM top_post_per_topic 
WHERE rn = 1
ORDER BY impressions DESC