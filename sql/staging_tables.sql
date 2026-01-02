DROP TABLE IF EXISTS stg_posts;
CREATE TABLE stg_posts (
    post_id         TEXT,
    post_date       TEXT,         
    post_time       TEXT,         
    post_type       TEXT,         
    topic           TEXT,         
    impressions     TEXT,
    likes           TEXT,
    comments        TEXT,
    shares          TEXT
);

DROP TABLE IF EXISTS stg_followers;
CREATE TABLE stg_followers (
    report_date     TEXT,         
    followers_count TEXT
);