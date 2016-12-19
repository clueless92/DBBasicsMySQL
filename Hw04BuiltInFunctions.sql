-- Hw04

-- Pr01. Find Names of All Employees by First Name
SELECT e.first_name, e.last_name
  FROM employees AS e
 WHERE LEFT(e.first_name, 2) = "sa";
 
-- Pr02. Find Names of All employees by Last Name
SELECT e.first_name, e.last_name
  FROM employees AS e
 WHERE e.last_name LIKE "%ei%";
 
-- Pr03. Find First Names of All Employees
SELECT e.first_name
  FROM employees AS e
 WHERE YEAR(e.hire_date) >= 1995
   AND YEAR(e.hire_date) <= 2005
	AND (e.department_id = 3
	 OR e.department_id = 10);
	 
-- Pr04.	Find All Employees Except Engineers
SELECT e.first_name, e.last_name
  FROM employees AS e
 WHERE e.job_title NOT LIKE "%engineer%";
 
-- Pr05.	Find Towns with Name Length
SELECT t.name
  FROM towns AS t
 WHERE LENGTH(t.name) = 5
    OR LENGTH(t.name) = 6
 ORDER BY t.name ASC;
 
-- Pr06. Find Towns Starting With
SELECT t.town_id, t.name
  FROM towns AS t
 WHERE LEFT(t.name, 1) = "M"
    OR LEFT(t.name, 1) = "K"
    OR LEFT(t.name, 1) = "B"
    OR LEFT(t.name, 1) = "E"
 ORDER BY t.name ASC;
 
-- Pr07.	Find Towns Not Starting With
SELECT t.town_id, t.name
  FROM towns AS t
 WHERE LEFT(t.name, 1) != "R"
   AND LEFT(t.name, 1) != "B"
   AND LEFT(t.name, 1) != "D"
 ORDER BY t.name ASC;

-- Pr08. Create View Employees Hired After 2000 Year
CREATE VIEW v_employees_hired_after_2000 AS 
SELECT e.first_name, e.last_name
  FROM employees AS e
 WHERE YEAR(e.hire_date) > 2000;
 
 -- Pr09. Length of Last Name
SELECT e.first_name, e.last_name
  FROM employees AS e
 WHERE LENGTH(e.last_name) = 5;
 
-- Pr10.	Countries Holding ‘A’ 3 or More Times
SELECT c.country_name, c.iso_code
  FROM countries AS c
 WHERE c.country_name LIKE "%A%A%A%"
 ORDER BY c.iso_code ASC;
 
-- Pr11. Mix of Peak and River Names
SELECT p.peak_name,
		 r.river_name,
		 LOWER(CONCAT(LEFT(p.peak_name, CHAR_LENGTH(p.peak_name) - 1), r.river_name)) AS `mix`
  FROM rivers AS r, peaks AS p
 WHERE RIGHT(p.peak_name, 1) = LEFT(r.river_name, 1)
 ORDER BY `mix` ASC;
 
-- Pr12. Games from 2011 and 2012 year
SELECT g.name AS `game`, DATE_FORMAT(DATE(g.`start`), "%Y-%m-%d") AS `start`
  FROM games AS g
 WHERE YEAR(g.`start`) = 2011
    OR YEAR(g.`start`) = 2012
 ORDER BY g.`start`,
			 g.name
 LIMIT 50;

-- Pr13. User Email Providers
SELECT u.user_name AS `Username`,
		 SUBSTR(u.email, POSITION('@' IN u.email) + 1, LENGTH(u.email)) AS `Email Provider`
  FROM users AS u
 ORDER BY `Email Provider` ASC,
			 `Username` ASC;
			 
-- Pr14. Get Users with IPAdress Like Pattern
SELECT u.user_name AS `Username`,
		 u.ip_address AS `IP Address`
  FROM users AS u
 WHERE u.ip_address LIKE "___.1%.%.___"
 ORDER BY u.user_name;
 
 -- Pr15. Show All Games with Duration and Part of the Day
SELECT g.name AS `Game`,
		 CASE 
		 	WHEN HOUR(g.`start`) >= 0 AND HOUR(g.`start`) < 12 THEN "Morning"
			WHEN HOUR(g.`start`) >= 12 AND HOUR(g.`start`) < 18 THEN "Afternoon"
			WHEN HOUR(g.`start`) >= 18 AND HOUR(g.`start`) < 24 THEN "Evening"
		 END AS `Part of the Day`,
		 CASE
		 	WHEN g.duration <= 3 THEN "Extra Short"
		 	WHEN g.duration >= 4 AND g.duration <=6 THEN "Short"
		 	WHEN g.duration > 6 THEN "Long"
		 	ELSE "Extra Long"
		 END AS `Duragtion`
  FROM games AS g
 ORDER BY g.name,
          `Duragtion`,
			 `Part of the Day`;
			 
-- Pr16. Orders Table
SELECT o.product_name,
		 o.order_date,
		 DATE_ADD(o.order_date, INTERVAL 3 DAY) AS `payment_due_date`,
		 DATE_ADD(o.order_date, INTERVAL 1 MONTH) AS `delivery_due_date`
  FROM orders AS o;
  
-- Pr17. People Table
CREATE TABLE people(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50),
	birthdate DATETIME
);

INSERT INTO people(name, birthdate) VALUES
("Victor", "2000-12-07 00:00:00"),
("Steven", "1992-09-10 00:00:00"),
("Stephen", "1910-09-19 00:00:00"),
("John", "2010-01-06 00:00:00");

SELECT p.name,
		 -TIMESTAMPDIFF(YEAR, NOW(), p.birthdate) AS `age_in_years`,
		 -TIMESTAMPDIFF(MONTH, NOW(), p.birthdate) AS `age_in_months`,
		 -TIMESTAMPDIFF(DAY, NOW(), p.birthdate) AS `age_in_days`,
		 -TIMESTAMPDIFF(MINUTE, NOW(), p.birthdate) AS `age_in_minutes`
  FROM people as p