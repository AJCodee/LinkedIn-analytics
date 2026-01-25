
-- CORE TABLES
-- Source: staging tables
-- Purpose: cleaned, analytics-ready LinkedIn data

-- Core_posts

TRUNCATE TABLE core_posts;

INSERT INTO core_posts (
    post_id, post_date, post_type, topic,
    impressions, likes, comments, shares
)
SELECT
    post_id,
    post_date,
    NULLIF(LOWER(TRIM(post_type)), '') AS post_type,
    NULLIF(TRIM(topic), '') AS topic,
    COALESCE(impressions, 0) AS impressions,
    COALESCE(likes, 0)       AS likes,
    COALESCE(comments, 0)    AS comments,
    COALESCE(shares, 0)      AS shares
FROM stg_posts
WHERE post_id IS NOT NULL
  AND post_date IS NOT NULL;

-- Core_followers_gained

TRUNCATE TABLE core_followers_daily;

INSERT INTO core_followers_daily (
    report_date, followers_gained
)
SELECT
    report_date,
    COALESCE(followers_gained, 0)
FROM stg_followers_daily
WHERE date IS NOT NULL;