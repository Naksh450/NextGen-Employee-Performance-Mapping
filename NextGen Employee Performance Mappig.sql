-- 1. Create a database named employee, then import data_science_team.csv proj_table.csv and emp_record_table.csv into the employee database from the given resources.--

CREATE DATABASE IF NOT EXISTS TITANIC ;
USE TITANIC;
SELECT * FROM emp_record_table;
SELECT * FROM data_science_team;
SELECT * FROM proj_table;

-- 2. Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, and make a list of employees and details of their department. --

use titanic3;
select emp_id,concat(first_name," ",last_name)as Employees,Dept
from emp_record_table;

/* 3.	Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
●	less than two
●	greater than four 
●	between two and four*/
 
Create database if not exists titanic2;
use titanic2;
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER,DEPT, EMP_RATING
FROM emp_record_table
WHERE EMP_RATING > 4;
WHERE EMP_RATING <2;
WHERE EMP_RATING> BETWEEN 2 AND 4;

-- 4. Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME. --

use titanic2;
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME
FROM emp_record_table
WHERE DEPT = 'Finance';

-- 5. Write a query to list down all the employees from the healthcare and finance departments using union. Take data from the employee record table. --

use titanic2;
SELECT EMP_ID, CONCAT(FIRST_NAME," ", LAST_NAME) AS EMPLOYEES ,DEPT
FROM emp_record_table
WHERE DEPT = "Healthcare";
SELECT EMP_ID,CONCAT(FIRST_NAME," ", LAST_NAME) AS EMPLOYEES ,DEPT
FROM emp_record_table
WHERE DEPT = "Finance";

--6. Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. Also include the respective employee rating along with the max emp rating for the department. --

CREATE DATABASE TITANIC3;
USE TITANIC3;
SELECT DEPT
FROM emp_record_table
GROUP BY DEPT
HAVING MAX(EMP_RATING)=5

-- 7. Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table. --

use titanic3;
SELECT role,
       MIN(salary) AS min_salary,
       MAX(salary) AS max_salary
FROM emp_record_table
GROUP BY role;

-- 8.	Write a query to assign ranks to each employee based on their experience. Take data from the employee record table. --

use titanic3;
SELECT EMP_ID, CONCAT(FIRST_NAME," ", LAST_NAME) AS EMPLOYEES ,EXP,Rank() over (order by exp desc) as experience_rank
from emp_record_table;

-- 9.	Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table. --

use titanic3;
SELECT EMP_ID, CONCAT(FIRST_NAME," ", LAST_NAME) AS EMPLOYEES ,country,salary
from emp_record_table
group by emp_id,employees,country,salary
having max(salary)>6000;

-- 10.	Write a nested query to find employees with experience of more than ten years. Take data from the employee record table. --

use titanic3;
SELECT EMP_ID, CONCAT(FIRST_NAME, " ", LAST_NAME) AS EMPLOYEES, EXP
FROM emp_record_table
WHERE EXP > 10;

-- 11.	Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table. --

use titanic3;
DELIMITER //
CREATE PROCEDURE GetExp_Emp()
BEGIN
    SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP
    FROM emp_record_table
    WHERE EXP > 3;
END //
DELIMITER ;

call GetExp_Emp()

-- 12.	Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan. --

use titanic3;
select * from emp_record_table where first_name="Eric";

-- 13.	Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating). --

use titanic3;
SELECT Emp_id,concat( FIRST_NAME," ", LAST_NAME) as Employees, SALARY, EMP_RATING,
       5/100 *emp_rating*salary AS Bonus
FROM emp_record_table;

-- 14.	Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table. --

use titanic3;
  SELECT CONTINENT, COUNTRY, AVG(SALARY) AS AVG_SALARY
FROM emp_record_table
GROUP BY CONTINENT, COUNTRY;

/* 15.	Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science team matches the organization’s set standard.

The standard being:
For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
For an employee with the experience of 12 to 16 years assign 'MANAGER' .                                 */

use titanic3;
DELIMITER //

CREATE FUNCTION GetRole(exp INT) RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
    DECLARE role VARCHAR(50);
    
    IF exp <= 2 THEN
        RETURN 'JUNIOR DATA SCIENTIST';
    ELSEIF exp <= 5 THEN
        RETURN 'ASSOCIATE DATA SCIENTIST';
    ELSEIF exp <= 10 THEN
        RETURN 'SENIOR DATA SCIENTIST';
    ELSEIF exp <= 12 THEN
        RETURN 'LEAD DATA SCIENTIST';
    ELSEIF exp <= 16 THEN
        RETURN 'MANAGER';
    END IF;
    
    RETURN role;
END //

DELIMITER ;

DELIMITER //

ALTER FUNCTION GetRole(exp INT) RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
    DECLARE role VARCHAR(50);

    IF exp <= 2 THEN
        RETURN 'JUNIOR DATA SCIENTIST';
    ELSEIF exp <= 5 THEN
        RETURN 'ASSOCIATE DATA SCIENTIST';
    ELSEIF exp <= 8 THEN
        RETURN 'SENIOR DATA SCIENTIST';
    ELSEIF exp <= 12 THEN
        RETURN 'LEAD DATA SCIENTIST';
    ELSEIF exp <= 16 THEN
        RETURN 'MANAGER';
    ELSE
        RETURN 'UNKNOWN';
    END IF;

    RETURN role;
END;

DELIMITER ;

SELECT emp_id, first_name, last_name, exp, GetRole(exp) AS job_profile
FROM emp_record_table
ORDER BY exp;







