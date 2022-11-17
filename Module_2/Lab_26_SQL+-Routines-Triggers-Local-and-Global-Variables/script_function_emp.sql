USE employees_mod;

-- 2/ Create a procedure that will provide the average salary of all employees.
-- check the salaries table first 
SELECT * FROM t_salaries;

DELIMITER $$ 
CREATE PROCEDURE avg_salary()
BEGIN 
SELECT avg(max_salary)
FROM (SELECT emp_no, max(salary) AS max_salary
      FROM t_salaries
      GROUP BY emp_no) AS avgSalary;
END $$
DELIMITER ;

CALL avg_salary();

-- 3/ Create a procedure called ‘emp_info’ that uses as parameters the first and the last name 
-- of an individual and returns their employee number.
SELECT * FROM t_employees;

DELIMITER $$ 
CREATE PROCEDURE emp_info_num(IN f_name VARCHAR(50), IN l_name VARCHAR(50), OUT e_num INT)
BEGIN 
# give the value to our declared output variable 
SELECT emp_no
INTO e_num
FROM t_employees
WHERE first_name = f_name and last_name=l_name;
END $$
DELIMITER ;

-- 4 call the procedure
# generate a session variable(which you could use before you close the file) @e_num
CALL emp_info_num('Saniya', 'Kalloufi', @e_num);
# show the value of the session variable 
SELECT @e_num;

-- 5/ Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, 
-- and returns the salary from the newest contract of that employee. 
-- Hint: In the BEGIN-END block of this program, you need to declare and 
-- use two variables – v_max_from_date that will be of the DATE type, 
-- and v_salary, that will be of the DECIMAL (10,2) type.
SELECT * FROM t_salaries;


-- same query as the function but in procedure way
DELIMITER $$ 
CREATE PROCEDURE emp_info_Salary(IN f_name VARCHAR(50), IN l_name VARCHAR(50), OUT max_sal FLOAT(10,2))
BEGIN 
# give the value to our declared output variable 
SELECT newest_sal
INTO max_sal
FROM (SELECT max(from_date), emp_no, max(salary) AS newest_sal
	FROM t_salaries
	GROUP BY emp_no) AS maxSalary
JOIN t_employees as e
ON e.emp_no = maxSalary.emp_no
WHERE e.first_name = f_name and e.last_name=l_name;
END $$
DELIMITER ;

CALL emp_info_salary('Saniya', 'Kalloufi', @max_sal);
SELECT @max_sal;

-- Function 
    
DELIMITER $$
CREATE FUNCTION emp_info(p_first_name varchar(255), p_last_name varchar(255)) RETURNS decimal(10,2)
DETERMINISTIC

BEGIN
	-- create variables
	DECLARE v_max_from_date date;
	DECLARE v_salary decimal(10,2);
    
	-- input values to variables v_max_from_date
	SELECT MAX(from_date)
	INTO v_max_from_date 
	FROM employees e
	JOIN salaries s 
	ON e.emp_no = s.emp_no
	WHERE e.first_name = p_first_name AND e.last_name = p_last_name;
    
    -- input values to variables v_salary
	SELECT s.salary
	INTO v_salary 
	FROM employees e
	JOIN salaries s 
	ON e.emp_no = s.emp_no
	WHERE e.first_name = p_first_name AND e.last_name = p_last_name AND s.from_date = v_max_from_date;
	
    RETURN v_salary;
END$$ 
DELIMITER ;

-- 6/ Create a trigger that checks if the hire date of an employee is higher than the current date. 
-- If true, set this date to be the current date. Format the output appropriately (YY-MM-DD)
DELIMITER $$
CREATE TRIGGER  Check_hire_date  BEFORE INSERT ON t_employees
FOR EACH ROW
BEGIN
IF NEW.hire_date > SYSDATE() THEN
SET NEW.hire_date = DATA_FORMAT(SYSDATE(), '%y-%m-%d');
END IF;
END$$
DELIMITER ; 

-- 7/ Create ‘i_hire_date’ and Drop the ‘i_hire_date’ index.
-- CREATE INDEX [index name] ON [table name]([column name]);
CREATE INDEX i_hire_date ON t_employees(hire_date);
-- DROP INDEX index_name ON table_name;
DROP INDEX i_hire_date ON t_employees; 

-- 8/ Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum. 
-- Then, create an index on the ‘salary’ column of that table, 
-- and check if it has sped up the search of the same SELECT statement.

CREATE TEMPORARY TABLE sal
SELECT * 
FROM (SELECT emp_no, max(salary) AS newest_sal, max(from_date), max(to_date)
	FROM t_salaries
	GROUP BY emp_no) AS maxSalary
WHERE newest_sal > 89000;

SELECT newest_sal FROM sal;
-- it takes 0.0014 sec

CREATE INDEX ind_salary ON sal(newest_sal);
SELECT newest_sal
FROM sal 
USE INDEX(ind_salary);
-- it takes 0.00021 sec, much faster

-- 9/ Use Case statement and obtain a result set containing :
-- the employee number, first name, and last name of all employees with a number higher than 109990. 
-- Create a fourth column in the query, indicating whether this employee is also a manager, 
-- according to the data provided in the dept_manager table, or a regular employee.

SELECT e.emp_no, e.first_name, e.last_name, 
CASE 
	WHEN d.dept_no IS NOT NULL THEN 'Manager'
    ELSE 'Regular Employee'
END AS title
FROM t_employees e
LEFT JOIN t_dept_manager d
ON d.emp_no = e.emp_no
WHERE e.emp_no>109990;

-- 10/ Extract a dataset containing the following information about the managers: 
-- employee number, first name, and last name. 
-- Add two columns at the end – 
-- one showing the difference between the maximum and minimum salary of that employee, 
-- and another one saying whether this salary raise was higher than $30,000 or NOT.

SELECT e.emp_no, e.first_name, e.last_name, s.diff AS raise,
CASE 
	WHEN s.diff > 30000 THEN 'Yes'
    ELSE 'No'
END AS Raise_More_than_30k
FROM (
SELECT emp_no, (max(salary)-min(salary)) AS diff
FROM t_salaries
GROUP BY emp_no
) AS s
JOIN t_employees e
ON e.emp_no = s.emp_no
JOIN t_dept_manager m
ON m.emp_no = e.emp_no;

-- Extract the employee number, first name, and last name of the first 100 employees, 
-- and add a fourth column, called “current_employee” saying “Is still employed” 
-- if the employee is still working in the company, or “Not an employee anymore” if they aren’t. 
-- Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve this exercise.
SELECT e.emp_no, e.first_name, e.last_name, 
CASE 
	WHEN d.to_date = '9999-01-01' THEN 'Is still employed'
    ELSE 'Not an employee anymore'
END AS emp_status
FROM t_employees e
JOIN t_dept_emp d
ON e.emp_no = d.emp_no
LIMIT 100;