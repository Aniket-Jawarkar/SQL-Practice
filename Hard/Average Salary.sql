-- Question 108
-- Given two tables as below, write a query to display the comparison result (higher/lower/same) of the 
-- average salary of employees in a department to the company's average salary.
-- Table: salary
-- | id | employee_id | amount | pay_date   |
-- |----|-------------|--------|------------|
-- | 1  | 1           | 9000   | 2017-03-31 |
-- | 2  | 2           | 6000   | 2017-03-31 |
-- | 3  | 3           | 10000  | 2017-03-31 |
-- | 4  | 1           | 7000   | 2017-02-28 |
-- | 5  | 2           | 6000   | 2017-02-28 |
-- | 6  | 3           | 8000   | 2017-02-28 |
-- The employee_id column refers to the employee_id in the following table employee.
-- | employee_id | department_id |
-- |-------------|---------------|
-- | 1           | 1             |
-- | 2           | 2             |
-- | 3           | 2             |
-- So for the sample data above, the result is:
-- | pay_month | department_id | comparison  |
-- |-----------|---------------|-------------|
-- | 2017-03   | 1             | higher      |
-- | 2017-03   | 2             | lower       |
-- | 2017-02   | 1             | same        |
-- | 2017-02   | 2             | same        |
-- Explanation
-- In March, the company's average salary is (9000+6000+10000)/3 = 8333.33...
-- The average salary for department '1' is 9000, which is the salary of employee_id '1' since there is only one employee in this department. So the comparison result is 'higher' since 9000 > 8333.33 obviously.
-- The average salary of department '2' is (6000 + 10000)/2 = 8000, which is the average of employee_id '2' and '3'. So the comparison result is 'lower' since 8000 < 8333.33.
-- With he same formula for the average salary comparison in February, the result is 'same' since both the department '1' and '2' have the same average salary with the company, which is 7000.
-- Solution


WITH S AS (
    SELECT 
        s.pay_date,
        s.amount,
        e.department_id,
        e.employee_id
    FROM Salary s
    JOIN Employee e 
      ON s.employee_id = e.employee_id
),
T AS (
    SELECT
        DATE_FORMAT(pay_date, '%Y-%m') AS pay_month,
        department_id,
        AVG(amount) OVER (PARTITION BY pay_date, department_id) AS department_avg,
        AVG(amount) OVER (PARTITION BY pay_date) AS company_avg
    FROM S
)
SELECT
    pay_month,
    department_id,
    CASE
        WHEN AVG(department_avg) > AVG(company_avg) THEN 'higher'
        WHEN AVG(department_avg) < AVG(company_avg) THEN 'lower'
        ELSE 'same'
    END AS comparison
FROM T
GROUP BY pay_month, department_id
ORDER BY pay_month, department_id;
