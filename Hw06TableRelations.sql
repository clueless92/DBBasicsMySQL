-- Hw04 Table Relations

-- Pr01 One-To-One Relationship
CREATE TABLE persons(
	person_id INT PRIMARY KEY,
	first_name VARCHAR(50),
	salary DECIMAL,
	passport_id INT -- UNIQUE
);

CREATE TABLE passports(
	passport INT PRIMARY KEY,
	passport_number VARCHAR(8)
);

ALTER TABLE persons
	ADD CONSTRAINT fk_persons_passports 
	FOREIGN KEY(passport_id)
	REFERENCES passports(passport);
	
INSERT INTO passports(passport, passport_number) VALUES
	(101, "N34FG21B"),
	(102, "K65LO4R7"),
	(103, "ZE657QP2");
	
INSERT INTO persons(person_id, first_name, salary, passport_id) VALUES
	(1, "Roberto", 43300.00, 102),
	(2, "Tom", 56100.00, 103),
	(3, "Yana", 60200.00, 101);
	
-- Pr02 One-To-Many Relationship
CREATE TABLE manufacturers(
	manufacturer_id INT PRIMARY KEY,
	name VARCHAR(50),
	established_on DATE
);

CREATE TABLE models(
	model_id INT PRIMARY KEY,
	name VARCHAR(50),
	manufacturer_id INT,
	CONSTRAINT fk_models_manufacturers
	FOREIGN KEY (manufacturer_id)
	REFERENCES manufacturers(manufacturer_id)
);

INSERT INTO manufacturers(manufacturer_id, name, established_on) VALUES
	(1, "BMW", "1916-03-07"),
	(2, "Tesla", "2003-01-01"),
	(3, "Lada", "1966-05-01");

INSERT INTO models(model_id, name, manufacturer_id) VALUES
	(101, "X1", 1),
	(102, "i6", 1),
	(103, "Model S", 2),
	(104, "Model X", 2),
	(105, "Model 3", 2),
	(106, "Nova", 3);

-- Pr03 Many-To-Many Relationship
CREATE TABLE students(
	student_id INT PRIMARY KEY,
	name VARCHAR(50)
);

INSERT INTO students(student_id, name) VALUES
	(1, "Mila"),
	(2, "Toni"),
	(3, "Ron");
	
CREATE TABLE exams(
	exam_id INT PRIMARY KEY,
	name VARCHAR(50)
);

INSERT INTO exams(exam_id, name) VALUES
	(101, "Spring MVC"),
	(102, "Neo4j"),
	(103, "Oracle 11g");
	
CREATE TABLE students_exams(
	student_id INT,
	exam_id INT,
	CONSTRAINT pk_students_exams PRIMARY KEY(student_id, exam_id),
	CONSTRAINT fk_students FOREIGN KEY(student_id) REFERENCES students(student_id),
	CONSTRAINT fk_exams FOREIGN KEY(exam_id) REFERENCES exams(exam_id)
);

-- Pr04 Self-Referencing
CREATE TABLE teachers(
	teacher_id INT PRIMARY KEY,
	name VARCHAR(50),
	manager_id INT
);

INSERT INTO teachers(teacher_id, name, manager_id) VALUES
	(101, "John", NULL),
	(102, "Maya", 106),
	(103, "Silvia", 106),
	(104, "Ted", 105),
	(105, "Mark", 101),
	(106, "Greta", 101);

ALTER TABLE teachers
 ADD CONSTRAINT fk_manager_teacher FOREIGN KEY(manager_id) REFERENCES teachers(teacher_id);

-- Pr05 Online Store Database
CREATE DATABASE online_store;

USE online_store;

CREATE TABLE orders(
	order_id INT PRIMARY KEY,
	customer_id INT
);

CREATE TABLE customers(
	customer_id INT PRIMARY KEY,
	name VARCHAR(50),
	birthday DATE,
	city_id INT
);

CREATE TABLE cities(
	city_id INT PRIMARY KEY,
	name VARCHAR(50)
);

CREATE TABLE order_items(
	order_id INT,
	item_id INT,
	PRIMARY KEY(order_id, item_id)
);

CREATE TABLE items(
	item_id INT PRIMARY KEY,
	name VARCHAR(50),
	item_type_id INT
);

CREATE TABLE item_types(
	item_type_id INT PRIMARY KEY,
	name VARCHAR(50)
);

ALTER TABLE orders
	ADD CONSTRAINT fk_orders_customers
	FOREIGN KEY(customer_id)
	REFERENCES customers(customer_id);
	
ALTER TABLE customers
	ADD CONSTRAINT fk_customers_cities
	FOREIGN KEY(city_id)
	REFERENCES cities(city_id);
	
ALTER TABLE order_items
	ADD CONSTRAINT fk_order_items_orders
	FOREIGN KEY(order_id)
	REFERENCES orders(order_id),
	ADD CONSTRAINT fk_order_items_items
	FOREIGN KEY(item_id)
	REFERENCES items(item_id);
	
ALTER TABLE items
	ADD CONSTRAINT fk_items_item_types
	FOREIGN KEY(item_type_id)
	REFERENCES item_types(item_type_id);
	
-- Pr06 University Database

CREATE DATABASE university;

USE university;

CREATE TABLE majors(
	major_id INT PRIMARY KEY,
	name VARCHAR(50)
);

CREATE TABLE students(
	student_id INT PRIMARY KEY,
	student_number VARCHAR(12),
	student_name VARCHAR(50),
	major_id INT,
	CONSTRAINT fk_students_majors
	FOREIGN KEY(major_id)
	REFERENCES majors(major_id)
);

CREATE TABLE payments(
	payment_id INT PRIMARY KEY,
	payment_date DATE,
	paymnet_amount DECIMAL(8, 2),
	student_id INT,
	CONSTRAINT fk_payments_students
	FOREIGN KEY(student_id)
	REFERENCES students(student_id)
);

CREATE TABLE subjects(
	subject_id INT PRIMARY KEY,
	subject_name VARCHAR(50)
);

CREATE TABLE agenda(
	student_id INT,
	subject_id INT,
	CONSTRAINT pk_agenda
	PRIMARY KEY(student_id, subject_id),
	CONSTRAINT fk_agenda_sudents
	FOREIGN KEY(student_id)
	REFERENCES students(student_id),
	CONSTRAINT fk_agenda_subjects
	FOREIGN KEY(subject_id)
	REFERENCES subjects(subject_id)
);

-- Pr09 Employee Address
SELECT e.employee_id, e.job_title, a.address_id, a.address_text
  FROM employees AS e
 INNER JOIN addresses AS a
    ON e.address_id = a.address_id
 LIMIT 5;
 
 -- Pr10 Employee Departments
SELECT e.employee_id, e.first_name, e.salary, d.name
  FROM employees AS e
 INNER JOIN departments AS d
    ON e.department_id = d.department_id
 WHERE e.salary > 15000
 ORDER BY e.department_id ASC
 LIMIT 5;
 
 -- Pr11 Employees Without Project
SELECT e.employee_id, e.first_name
  FROM employees AS e
  LEFT JOIN employees_projects AS ep
    ON e.employee_id = ep.employee_id
 WHERE ep.project_id IS NULL
 ORDER BY e.employee_id ASC
 LIMIT 3;
 
 -- Pr12 Employees with Project
SELECT e.employee_id, e.first_name, p.name
  FROM employees AS e
 INNER JOIN employees_projects AS ep
    ON e.employee_id = ep.employee_id
 INNER JOIN projects AS p
    ON ep.project_id = p.project_id
 WHERE p.start_date > "2002-08-13"
   AND p.end_date IS NULL
 ORDER BY e.employee_id ASC
 LIMIT 5;
 
 -- Pr13 Employee 24
SELECT e.employee_id, e.first_name, p.name
  FROM employees AS e
 INNER JOIN employees_projects AS ep
    ON e.employee_id = ep.employee_id
 LEFT JOIN projects AS p
    ON ep.project_id = p.project_id
   AND p.start_date < "2005-01-01"
 WHERE e.employee_id = 24
--  AND p.start_date < "2005-01-01" -- WRONG!

-- Pr14 Employee Manager
SELECT e.employee_id, e.first_name, e.manager_id, m.first_name
  FROM employees AS e
 INNER JOIN employees AS m
    ON e.manager_id = m.employee_id
 WHERE e.manager_id = 3
    OR e.manager_id = 7
 ORDER BY e.employee_id ASC;
 
-- Pr15 Highest Peak in Bulgaria
SELECT c.country_code, m.mountain_range, p.peak_name, p.elevation
  FROM countries AS c
 INNER JOIN mountains_countries AS mc
    ON c.country_code = mc.country_code
   AND c.country_code = "BG"
 INNER JOIN mountains AS m
    ON mc.mountain_id = m.id
 INNER JOIN peaks AS p
    ON m.id = p.mountain_id
 WHERE p.elevation > 2835
 ORDER BY p.elevation DESC;
 
 -- Pr16 Count Mountain Ranges
SELECT c.country_code, COUNT(*) AS mountain_ranges
  FROM countries AS c
 INNER JOIN mountains_countries AS mc
    ON c.country_code = mc.country_code
-- INNER JOIN mountains as m
--     ON m.id = mc.mountain_id
 WHERE c.country_code IN ("BG", "US", "RU")
 GROUP BY c.country_code;
 
 -- DONE TO HERE!!! AUTHORS SOLUTIONS BELOW!!!
 
  -- 17. countries with or without rivers
SELECT c.country_name, r.river_name
  FROM countries AS c
  LEFT JOIN countries_rivers AS cr
    ON c.country_code = cr.country_code
  LEFT JOIN rivers as r
    ON r.id = cr.river_id
 WHERE c.continent_code = 'AF'
 ORDER BY c.country_name
 LIMIT 5
 
  -- 18. Continents and Currencies

CREATE TABLE currency_usage AS
SELECT cur.continent_code, MAX(cur.currency_usage) AS max_currency_usage
  FROM
(SELECT co.continent_code, cu.currency_code, COUNT(*) AS currency_usage
  FROM countries AS co
 INNER JOIN currencies AS cu
    ON co.currency_code = cu.currency_code
 GROUP BY co.continent_code, cu.currency_code) AS cur
 GROUP BY cur.continent_code
HAVING MAX(cur.currency_usage) > 1;
 
 SELECT cur.* 
   FROM  
 (SELECT co.continent_code, cu.currency_code, COUNT(*) AS currency_usage
  FROM countries AS co
 INNER JOIN currencies AS cu
    ON co.currency_code = cu.currency_code
 GROUP BY co.continent_code, cu.currency_code) AS cur
 INNER JOIN currency_usage cu
    ON cu.continent_code = cur.continent_code
   AND cu.max_currency_usage = cur.currency_usage
 ORDER BY continent_code;

DROP TABLE currency_usage;

 -- 19. Count of countries without mountains
 SELECT COUNT(*)
  FROM countries AS c
  LEFT JOIN mountains_countries AS mc
    ON c.country_code = mc.country_code
 WHERE mc.mountain_id IS NULL

 -- 20. Highest Peak and Longest River by Country
SELECT
  c.country_name,
  MAX(p.elevation) AS highest_peak_elevation,
  MAX(r.Length) AS longest_river_length
FROM
  countries c
  LEFT JOIN mountains_countries mc ON c.country_code = mc.country_code
  LEFT JOIN mountains m ON m.id = mc.mountain_id
  LEFT JOIN peaks p ON p.mountain_id = m.id
  LEFT JOIN countries_rivers cr ON cr.country_code = c.country_code
  LEFT JOIN rivers r ON r.id = cr.river_id
GROUP BY c.country_name
ORDER BY highest_peak_elevation DESC, longest_river_length DESC, c.country_name ASC
LIMIT 5

-- 21. Highest Peak Name and elevation by Country
SELECT * FROM(
SELECT
  c.country_name AS country,
  p.peak_name AS highest_peak_name,
  p.elevation AS highest_peak_elevation,
  m.mountain_range AS mountain
FROM
  countries c
  LEFT JOIN mountains_countries mc ON c.country_code = mc.country_code
  LEFT JOIN mountains m ON m.id = mc.mountain_id
  LEFT JOIN peaks p ON p.mountain_id = m.id
WHERE p.elevation =
  (SELECT MAX(p.elevation)
   FROM mountains_countries mc
     LEFT JOIN mountains m ON m.id = mc.mountain_id
     LEFT JOIN peaks p ON p.mountain_id = m.id
   WHERE c.country_code = mc.country_code)
UNION
SELECT
  c.country_name AS country,
  '(no highest peak)' AS highest_peak_name,
  0 AS highest_peak_elevation,
  '(no mountain)' AS mountain
FROM
  countries c
  LEFT JOIN mountains_countries mc ON c.country_code = mc.country_code
  LEFT JOIN mountains m ON m.id = mc.mountain_id
  LEFT JOIN peaks p ON p.mountain_id = m.id
WHERE 
  (SELECT MAX(p.elevation)
   FROM mountains_countries mc
     LEFT JOIN mountains m ON m.id = mc.mountain_id
     LEFT JOIN peaks p ON p.mountain_id = m.id
   WHERE c.country_code = mc.country_code) IS NULL
   ) AS c
ORDER BY country, highest_peak_name
LIMIT 5