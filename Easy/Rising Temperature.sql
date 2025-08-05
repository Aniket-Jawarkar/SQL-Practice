-- Question 12
-- Given a Weather table, write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.

-- +---------+------------------+------------------+
-- | Id(INT) | RecordDate(DATE) | Temperature(INT) |
-- +---------+------------------+------------------+
-- |       1 |       2015-01-01 |               10 |    null       |               null
-- |       2 |       2015-01-02 |               25 |    2015-01-01 |               10
-- |       3 |       2015-01-03 |               20 |    2015-01-02 |               25
-- |       4 |       2015-01-04 |               30 |    2015-01-03 |               20
-- +---------+------------------+------------------+
-- For example, return the following Ids for the above Weather table:

-- +----+
-- | Id |
-- +----+   
-- |  2 |
-- |  4 |
-- +----+

-- Solution

    
    select W1.Id
    from Weather W1
    left join Weather W2 on W1.RecordDate = date_add(W2.RecordDate , interval 1 day)
    WHERE W1.Temperature > W2.Temperature;