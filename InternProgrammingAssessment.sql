-- Write a query that returns all posts posted in the past 24 hours

SELECT *
FROM Posts
WHERE time_posted > (current_timestamp - interval '24 hours');

-- Write a query that returns all posts grouped by topic

SELECT topic, COUNT(*)
FROM Posts
GROUP BY topic;

-- Write a query that returns all anonymous posts posted in the last week, sorted by most recent to least recent

SELECT *
FROM Posts
WHERE is_anonymous = TRUE AND date_posted > (current_date - interval '1 week')
ORDER BY time_posted DESC;

-- Write a query to return all posts that have the word “Love” in the title

SELECT *
FROM Posts
WHERE title ILIKE '%Love%';
