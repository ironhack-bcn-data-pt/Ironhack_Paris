USE employees_mod;

--  a breakdown between the male and female employees working in the company each year, starting from 1990.
SELECT year(hire_date) AS working_year, gender, count(emp_no)
FROM t_employees
GROUP BY gender, working_year
HAVING working_year > 1990
ORDER BY working_year;

-- Compare the number of male managers to the number of female managers from different departments 
-- for each year, starting from 1990.
SELECT year(e.hire_date) AS working_year, d.dept_name, e.gender, count(e.emp_no)
FROM t_dept_manager m
JOIN t_employees e
ON e.emp_no = m.emp_no
JOIN t_departments d
ON d.dept_no = m.dept_no
GROUP BY working_year, d.dept_name, e.gender
HAVING working_year > 1990
ORDER BY working_year, d.dept_name;

-- Compare the average salary of female versus male employees in the entire company until year 2002, 
-- and add a filter allowing you to see that per each department.
SELECT year(e.hire_date) AS working_year, d.dept_name, e.gender, avg(s.salary) as avg_sal
FROM t_employees e
JOIN t_salaries s
ON e.emp_no = s.emp_no
JOIN t_dept_emp de
ON de.emp_no = e.emp_no
JOIN t_departments d
ON d.dept_no = de.dept_no
GROUP BY working_year, d.dept_name, e.gender
HAVING working_year <= 2002
ORDER BY working_year, d.dept_name, e.gender;

-- Create an SQL stored procedure that will allow you to obtain 
-- the average male and female salary per department within a certain salary range. 
-- Let this range be defined by two values the user can insert when calling the procedure. 
DELIMITER $$
DROP PROCEDURE avg_sal$$

CREATE PROCEDURE avg_sal(IN a INT, IN b INT)
BEGIN
SELECT d.dept_name, e.gender, ROUND(AVG(s.salary), 1) AS avg_sal
FROM t_employees e
JOIN t_salaries s
ON s.emp_no = e.emp_no
JOIN t_dept_emp de
ON de.emp_no = e.emp_no
JOIN t_departments d
ON d.dept_no = de.dept_no
WHERE s.salary BETWEEN a AND b
GROUP BY d.dept_name, e.gender;
END$$
DELIMITER ;

# Calling the procedure to check if it works
CALL avg_sal(40000, 50000);