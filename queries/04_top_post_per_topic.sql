

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
top_post_per_topic AS (
	SELECT 
		*,
		row_number() OVER(PARTITION BY topic ORDER BY impressions DESC) AS rn
	FROM total_engagement 
)
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