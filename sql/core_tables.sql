
-- Core Tables created

-- core_posts

DROP TABLE IF EXISTS core_posts;
CREATE TABLE core_posts (
    post_id         TEXT PRIMARY KEY,
    posted_at       TIMESTAMP NOT NULL,
    post_type       TEXT NOT NULL,
    topic           TEXT,
    impressions     INTEGER NOT NULL CHECK (impressions >= 0),
    likes           INTEGER NOT NULL CHECK (likes >= 0),
    comments        INTEGER NOT NULL CHECK (comments >= 0),
    shares          INTEGER NOT NULL CHECK (shares >= 0)
);

-- core_followers

DROP TABLE IF EXISTS core_followers;
CREATE TABLE core_followers (
    report_date     DATE PRIMARY KEY,
    followers_count INTEGER NOT NULL CHECK (followers_count >= 0)
);

CREATE INDEX IF NOT EXISTS idx_core_posts_posted_at ON core_posts (posted_at);
CREATE INDEX IF NOT EXISTS idx_core_posts_topic ON core_posts (topic);
CREATE INDEX IF NOT EXISTS idx_core_posts_type ON core_posts (post_type);