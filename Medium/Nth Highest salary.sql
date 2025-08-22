-- Question 50
-- Write a SQL query to get the nth highest salary from the Employee table.
-- +----+--------+
-- | Id | Salary |
-- +----+--------+
-- | 1  | 100    |
-- | 2  | 200    |
-- | 3  | 300    |
-- +----+--------+
-- For example, given the above Employee table, the nth highest salary where n = 2 is 200. If there is no nth highest salary, then the query should return null.
-- +------------------------+
-- | getNthHighestSalary(2) |
-- +------------------------+
-- | 200                    |
-- +------------------------+
-- Solution 


create function getNthHighestSalary(x INT)
returns INT
begin

    declare result int;

        select distinct Salary
        into result
        from Employee
        order by Salary desc
        limit x - 1 , 1;

    return result;

end;
