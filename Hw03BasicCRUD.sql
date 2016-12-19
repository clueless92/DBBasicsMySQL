-- Hw03

-- Pr02
SELECT departments.department_id, departments.name, departments.manager_id
  FROM departments

-- Pr03
SELECT name
  FROM departments

-- Pr04
SELECT employees.first_name, employees.last_name, employees.salary
  FROM employees

-- Pr05
SELECT employees.first_name, employees.middle_name, employees.last_name
  FROM employees

-- Pr06
SELECT CONCAT(employees.first_name, '.', employees.last_name, '@softuni.bg')
    AS `full_email_address`
  FROM employees
  
-- Pr07
SELECT DISTINCT employees.salary
  FROM employees
  
-- Pr08
SELECT *
  FROM employees 
 WHERE employees.job_title = "Sales Representative"
 
-- Pr09
SELECT employees.first_name, employees.last_name, employees.job_title
  FROM employees 
 WHERE employees.salary >= 20000 AND employees.salary <= 30000
 
-- Pr10
SELECT CONCAT(employees.first_name, ' ', employees.middle_name, ' ', employees.last_name)
    AS `full_name`
  FROM employees
 WHERE employees.salary = 25000
    OR employees.salary = 14000
    OR employees.salary = 12500
	OR employees.salary = 23600
	
-- Pr11
SELECT e.first_name, e.last_name, e.salary
  FROM employees AS e
 WHERE e.salary > 50000
 ORDER BY e.salary DESC;
 
-- Pr12
SELECT e.first_name, e.last_name, e.salary
  FROM employees AS e
 WHERE e.salary > 50000
 ORDER BY e.salary DESC;

-- Pr13
SELECT e.first_name, e.last_name
  FROM employees as e
 ORDER BY e.salary DESC
 LIMIT 5;
 
-- Pr14
SELECT e.first_name, e.last_name
  FROM employees AS e
 WHERE e.department_id != 4;
 
-- Pr15
SELECT *
  FROM employees AS e
 ORDER BY e.salary DESC,
 		  e.first_name ASC,
 		  e.last_name DESC,
 		  e.middle_name ASC;
		  
-- Pr16
CREATE VIEW v_employees_salaries AS
SELECT e.first_name, e.last_name, e.salary
  FROM employees AS e;
  
-- Pr17
CREATE VIEW v_employees_job_titles(`full_name`, `job_title`) AS
SELECT CONCAT(
			e.first_name,
			' ', 
			CASE
				WHEN e.middle_name IS NULL THEN ""
			 	ELSE e.middle_name
			END,
			' ',
			e.last_name) AS `full_name`,
	   e.job_title
  FROM employees AS e;
  
-- Pr18
SELECT DISTINCT e.job_title
  FROM employees AS e;
  
-- Pr19
SELECT *
  FROM projects AS p
 ORDER BY p.start_date ASC,
 		  p.name
 LIMIT 10;
 
-- Pr20
SELECT e.first_name, e.last_name, e.hire_date
  FROM employees AS e
 ORDER BY e.hire_date DESC
 LIMIT 7;
 
-- Pr21
UPDATE employees AS e
   SET e.salary = e.salary * 1.12
 WHERE e.department_id = 1
 	 OR e.department_id = 2
 	 OR e.department_id = 4
 	 OR e.department_id = 11;
 	 
SELECT e.salary
  FROM employees AS e;
  
DROP DATABASE soft_uni;
-- NOTE: reload DATABASE soft_uni FROM softuni.bg

-- Pr22
SELECT p.peak_name
  FROM peaks AS p
 ORDER BY p.peak_name ASC;
 
-- Pr23
SELECT c.country_name, c.population
  FROM countries AS c
 WHERE c.continent_code = "EU"
 ORDER BY c.population DESC
 LIMIT 30;
 
-- Pr24
SELECT c.country_name,
		 c.country_code,
		 (CASE
  			WHEN c.currency_code = "EUR" THEN "Euro"
		  	ELSE "Not Euro"
  		 END) AS `currency`
  FROM countries AS c
 ORDER BY c.country_name ASC;
 
-- Pr25
SELECT c.name
  FROM characters AS c
 ORDER BY c.name ASC;