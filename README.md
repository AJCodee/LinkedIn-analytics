# LinkedIn Content Performance Analysis

## Overview

This project analyses one month of LinkedIn post data (November) to identify
content and timing patterns that drive engagement and follower growth. The analysis
is completed entirely in SQL using PostgreSQL.

## Dataset

- One month of LinkedIn post-level data (November)
- Daily follower growth metrics
- Data has been sourced from LinkedIn analytics exports (CSV)

## Tables

### core_posts

Post-level performance metrics:

- post_id
- posted_at
- post_type
- topic
- impressions
- likes
- comments
- shares

### core_followers_daily

Daily follower growth metrics:

- report_date
- followers_gained

## Tools used

- PostgreSQL
- DBeaver
- VS Code
- Git/Github

## Project Structure

/outputs

- 01_monthly_overview.csv
- 02_daily_follower_growth.csv
- 03_topic_performance.csv
- 04_top_post_per_topic.csv
- 05_posting_vs_followers.csv
- insights.md

/queries

- 01_monthly_overview.sql
- 02_daily_follower_growth.sql
- 03_topic_performance.sql
- 04_top_post_per_topic.sql
- 05_posting_vs_followers.sql

/setup

- core_tables.sql
- load_core.sql
- staging_tables.sql

## Key Questions & Insights

Key Questions

- Monthly overview: what was overall performance in November?
- Daily follower growth: which days gained the most followers (Highest / Lowest)?
- Topic performance: which topics performed best by reach and engagement rate?
- Top post per topic: what was the best post in each topic?
- Posting vs followers: does posting activity relate to follower growth?

Insights

- See outputs/insights.md for findings and summary.
