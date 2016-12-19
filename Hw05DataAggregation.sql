-- 1
SELECT COUNT(*) AS count FROM wizzard_deposits

-- 2
SELECT MAX(magic_wand_size) AS longest_magic_wand FROM wizzard_deposits

-- 3
SELECT deposit_group,MAX(magic_wand_size) AS longest_magic_wand FROM wizzard_deposits
	GROUP BY deposit_grouP
	
-- 4
SELECT deposit_group FROM 
(SELECT deposit_group, AVG(magic_wand_size) AS average FROM wizzard_deposits) AS e
	GROUP BY deposit_group
	HAVING MIN(e.average)
	
-- 5
SELECT deposit_group,SUM(deposit_amount) AS total_sum FROM wizzard_deposits
	GROUP BY deposit_group
	
-- 6
SELECT deposit_group,SUM(deposit_amount) AS total_sum FROM wizzard_deposits
	WHERE magic_wand_creator = 'Ollivander family'
	GROUP BY deposit_group
	
-- 7
SELECT deposit_group,SUM(deposit_amount) AS total_sum FROM wizzard_deposits
	WHERE magic_wand_creator = 'Ollivander family'
	 GROUP BY deposit_group	
	 HAVING SUM(deposit_amount) < 150000
	 ORDER BY total_sum DESC
	 
-- 8
SELECT deposit_group,magic_wand_creator,MIN(deposit_charge) AS min_deposit_charge FROM wizzard_deposits
	GROUP BY deposit_group,magic_wand_creator
	ORDER BY magic_wand_creator,deposit_group
	
-- 9
SELECT 
	CASE 
		WHEN age BETWEEN 0 AND 10 THEN '[0-10]'
		WHEN age BETWEEN 11 AND 20 THEN '[11-20]'
		WHEN age BETWEEN 21 AND 30 THEN '[21-30]'
		WHEN age BETWEEN 31 AND 40 THEN '[31-40]'
		WHEN age BETWEEN 41 AND 50 THEN '[41-50]'
		WHEN age BETWEEN 51 AND 60 THEN '[51-60]'
		WHEN age > 60 THEN '[61+]'
		END AS age_group, COUNT(*) AS wizard_count
		
	FROM wizzard_deposits
		GROUP BY age_group
		
-- 10
SELECT LEFT(first_name,1) AS first_letter FROM wizzard_deposits
	WHERE deposit_group = 'Troll Chest'
	GROUP BY LEFT(first_name,1)
	ORDER BY first_letter
	
-- 11
SELECT deposit_group,is_deposit_expired, AVG(deposit_interest) AS average_interest FROM wizzard_deposits
	WHERE deposit_start_date > CAST('1985-01-01' AS DATE) 
	GROUP BY deposit_group,is_deposit_expired
	ORDER BY deposit_group DESC,is_deposit_expired
	
-- 12
CREATE TABLE rich_poor_wizard AS
	SELECT w1.first_name AS 'Host Wizard',
			 w1.deposit_amount AS 'Host Wizard Deposit',
			 w2.first_name AS 'Guest Wizard',
			 w2.deposit_amount AS 'Guest Wizard Deposit',
			 w1.deposit_amount - w2.deposit_amount AS 'Difference'			 
	 FROM wizzard_deposits AS w1
	 JOIN wizzard_deposits AS w2
	 	ON w1.id = w2.id - 1;

SELECT SUM(Difference) AS sum_difference FROM rich_poor_wizard;
DROP TABLE rich_poor_wizard;

-- 13
SELECT department_id,MIN(salary) AS minimum_salary FROM employees
	WHERE department_id IN (2,5,7)
	AND hire_date > CAST('2000-01-01' AS DATE) 
	GROUP BY department_id
	
-- 14
CREATE TABLE new_table AS	
SELECT * FROM employees
	WHERE salary > 30000;

DELETE FROM new_table
	WHERE manager_id = 42;
	
UPDATE new_table SET salary = salary + 5000
	WHERE department_id =1;
	
SELECT department_id, AVG(salary) AS average_salary FROM new_table
	GROUP BY department_id;
	
-- 15
SELECT department_id, MAX(salary) AS max_salary FROM employees
	GROUP BY department_id
	HAVING MAX(salary) < 30000 OR MAX(salary) > 70000
	
-- 16
SELECT COUNT(*) AS count FROM employees
	WHERE manager_id IS NULL
	
-- 17

SELECT e.department_id, MAX(e.salary) AS third_max_salary
  FROM employees AS e
  JOIN
		(SELECT e.department_id, MAX(e.salary) AS second_max_salary
		  FROM employees AS e
		  JOIN
				(SELECT e.department_id, MAX(e.salary) max_salary 
				  FROM employees AS e
				  GROUP BY e.department_id) AS maxSalary
			 ON e.department_id = maxSalary.department_id
			AND e.salary < maxSalary.max_salary
		 GROUP BY e.department_id) AS secondMaxSalary
	 ON e.department_id = secondMaxSalary.department_id
	AND e.salary < secondMaxSalary.second_max_salary
 GROUP BY e.department_id
	
-- 18
SELECT basic.first_name,
		 basic.last_name,
		 basic.department_id 
  FROM employees AS basic
	INNER JOIN (SELECT department_id,AVG(salary) AS average_salary 
					FROM employees
					GROUP BY department_id) AS temp
			  ON basic.department_id = temp.department_id
WHERE basic.salary > temp.average_salary
ORDER BY department_id
LIMIT 10