-- Question 80
-- Table: Logs
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | log_id        | int     |
-- +---------------+---------+
-- id is the primary key for this table.
-- Each row of this table contains the ID in a log Table.
-- Since some IDs have been removed from Logs. Write an SQL query to find the start and end number of continuous ranges in table Logs.
-- Order the result table by start_id.
-- The query result format is in the following example:
-- Logs table:
-- +------------+
-- | log_id     |
-- +------------+
-- | 1          |
-- | 2          |
-- | 3          |
-- | 7          |
-- | 8          |
-- | 10         |
-- +------------+
-- Result table:
-- +------------+--------------+
-- | start_id   | end_id       |
-- +------------+--------------+
-- | 1          | 3            |
-- | 7          | 8            |
-- | 10         | 10           |
-- +------------+--------------+
-- The result table should contain all ranges in table Logs.
-- From 1 to 3 is contained in the table.
-- From 4 to 6 is missing in the table
-- From 7 to 8 is contained in the table.
-- Number 9 is missing in the table.
-- Number 10 is contained in the table.
-- Solution


with cte as 
 (
    select log_id , 
        lead(log_id , 1) over(order by log_id) as next_id
        lag(log_id , 1) over(order by log_id) as prev_id
    from Logs
 ),
 starts as (
    select log_id as start_id   
    from cte
    where prev_id is null or log_id - prev_id > 1
 ),
 ends as (
     select log_id as end_id   
    from cte
    where next_id is null or next_id - log_id > 1
 )
 select start_id , end_id
 from starts s
 join ends e on s.start_id <= e.end_id
 order by s.start_id