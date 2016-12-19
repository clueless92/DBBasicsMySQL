-- Hw02

-- Pr01
CREATE DATABASE minions

-- Pr02
CREATE TABLE minions(
id INT NOT NULL,
name VARCHAR(50),
age INT,
PRIMARY KEY(id)
);
CREATE TABLE towns(
id INT NOT NULL,
name VARCHAR(50),
PRIMARY KEY(id)
);

-- Pr03
ALTER TABLE minions ADD town_id INT NOT NULL;
ALTER TABLE minions ADD
 CONSTRAINT fk_minions_towns
  FOREIGN KEY (town_id)
   REFERENCES towns(id);
   
-- Pr04
INSERT INTO towns VALUES
(1, "Sofia"),
(2, "Plovdiv"),
(3, "Varna");
INSERT INTO minions VALUES
(1, "Kevin", 22, 1),
(2, "Bob", 15, 3),
(3, "Steward", NULL, 2);

-- Pr05
TRUNCATE TABLE minions

-- Pr06
DROP TABLE minions, towns;

-- Pr07
CREATE TABLE people(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	name VARCHAR(200) NOT NULL,
	picture MEDIUMBLOB,
	height FLOAT,
	weight FLOAT,
	gender ENUM("m", "f") NOT NULL,
	birthdate DATE NOT NULL,
	biography TEXT,
	PRIMARY KEY(id)
);

INSERT INTO people (name, gender, birthdate) VALUES
("Pesho", "m", "1970-04-20"),
("Slav", "m", "1992-04-20"),
("Peshoslav", "m", "2000-12-20"),
("Slivka", "f", "2000-10-10"),
("Pichka", "f", "2000-10-10");

-- Pr08
CREATE TABLE users(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
	username VARCHAR(30) NOT NULL,
	`password` VARCHAR(26) NOT NULL,
	profile_picture BLOB,
	last_login_time DATETIME,
	is_deleted ENUM("true", "false"),
	PRIMARY KEY(id)
);

INSERT INTO users (username, `password`) VALUES
("Pesho", "111"),
("Slav", "222"),
("Peshoslav", "333"),
("Slivka", "444"),
("Pichka", "555");

-- Pr09 ??? last row not working
  ALTER TABLE users
 MODIFY `id` INT NOT NULL,
   DROP PRIMARY KEY,
	 ADD PRIMARY KEY (`id`, `username`);
	 
-- Pr10
  ALTER TABLE users
 MODIFY COLUMN users.last_login_time DATETIME DEFAULT NOW();
 
-- Pr11
  ALTER TABLE users
   DROP PRIMARY KEY,
	 ADD PRIMARY KEY (`id`),
	 ADD UNIQUE (`username`);

-- Pr12
CREATE DATABASE movies;

CREATE TABLE directors(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	director_name VARCHAR(50) NOT NULL,
	notes TEXT
);

INSERT INTO directors (director_name) VALUES
("Pesho"),
("Slav"),
("Peshoslav"),
("Slivka"),
("Pichka");

CREATE TABLE genres(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	genre_name VARCHAR(50) NOT NULL,
	notes TEXT
);

INSERT INTO genres(genre_name) VALUES
("Horror"),
("Comedy"),
("Action"),
("Musical"),
("Drama");

CREATE TABLE categories(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	category_name VARCHAR(50) NOT NULL,
	notes TEXT
);

INSERT INTO categories(category_name) VALUES
("AAA"),
("BBB"),
("CCC"),
("DDD"),
("EEE");

CREATE TABLE movies(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(50) NOT NULL,
	director_id INT UNSIGNED NOT NULL,
	copyright_year YEAR,
	`length` TIME,
	genre_id INT UNSIGNED NOT NULL,
	category_id INT UNSIGNED NOT NULL,
	rating FLOAT,
	notes TEXT
);

INSERT INTO movies(title, director_id, genre_id, category_id) VALUES
("AAA", 1, 5, 1),
("BBB", 2, 4, 2),
("CCC", 3, 3, 3),
("DDD", 2, 4, 2),
("EEE", 1, 5, 1);


-- Pr13
CREATE DATABASE car_rental;

CREATE TABLE `categories` (
	id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	category VARCHAR(50) NOT NULL,
	daily_rate FLOAT,
	weekly_rate DOUBLE,
	monthly_rate DOUBLE,
	weekend_rate DOUBLE
);

INSERT INTO `categories`(category) VALUES
("AAA"),
("BBB"),
("CCC");

CREATE TABLE cars (
	id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	plate_number INT UNIQUE,
	make VARCHAR(50),
	model VARCHAR(50),
	car_year YEAR,
	category_id INT UNSIGNED NOT NULL,
	doors BIT,
	picture BLOB,
	`condition` VARCHAR(50),
	available ENUM("Yes", "No")
);

INSERT INTO cars(category_id) VALUES
(1),
(2),
(3);

CREATE TABLE employees (
	id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	title VARCHAR(50),
	notes TEXT
);

INSERT INTO employees(first_name, last_name) VALUES
("AAA", "BBB"),
("CCC", "DDD"),
("EEE", "FFF");

CREATE TABLE customers (
	customers.id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	driver_licence_number INT,
	full_name VARCHAR(50) NOT NULL,
	address VARCHAR(50),
	city VARCHAR(30),
	zip_code VARCHAR(4),
	notes TEXT
);

INSERT INTO customers(full_name) VALUES
("AAA BBB"),
("CCC DDD"),
("EEE FFF");

CREATE TABLE rental_orders (
	id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	employee_id INT UNSIGNED NOT NULL,
	customer_id INT UNSIGNED NOT NULL,
	car_id INT UNSIGNED NOT NULL,
	car_condition VARCHAR(50),
	tank_level VARCHAR(20),
	kilometrage_start INT UNSIGNED,
	kilometrage_end INT UNSIGNED,
	total_kilometrage INT UNSIGNED,
	start_date DATE,
	end_date DATE,
	total_days INT UNSIGNED,
	rate_applied DOUBLE,
	tax_rate DOUBLE,
	order_status ENUM("True", "False"),
	notes TEXT
);

INSERT INTO rental_orders(employee_id, customer_id, car_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

-- Pr14
CREATE DATABASE hotel;

CREATE TABLE `employees`(
	id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	title VARCHAR(50),
	notes TEXT
);

INSERT INTO `employees`(first_name, last_name) VALUES
("AAA", "BBB"),
("CCC", "DDD"),
("EEE", "FFF");

CREATE TABLE `customers`(
	account_number INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	phone_number VARCHAR(10),
	emergency_name VARCHAR(50),
	emergency_number VARCHAR(10),
	notes TEXT
);

INSERT INTO `customers`(first_name, last_name) VALUES
("AAA", "BBB"),
("CCC", "DDD"),
("EEE", "FFF");

CREATE TABLE room_status(
	room_status ENUM("taken", "free"),
	notes TEXT
);

INSERT INTO room_status(room_status) VALUES
("taken"),
("taken"),
("free");

CREATE TABLE room_types(
	room_type ENUM("single", "double", "thriple", "apartment"),
	notes TEXT
);

INSERT INTO room_types(room_type) VALUES
("single"),
("apartment"),
("thriple");

CREATE TABLE bed_types(
	bed_type ENUM("single", "double"),
	notes TEXT
);

INSERT INTO bed_types(bed_type) VALUES
("single"),
("double"),
("double");

CREATE TABLE rooms(
	room_number INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	room_type ENUM("single", "double", "thriple", "apartment"),
	bed_type ENUM("single", "double"),
	rate DOUBLE,
	room_status ENUM("taken", "free"),
	notes TEXT
);

INSERT INTO rooms(rate) VALUES
(1.1),
(1.2),
(1.3);

CREATE TABLE payments(
	id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	employee_id INT UNSIGNED NOT NULL UNIQUE,
	payment_date DATE,
	account_number INT UNSIGNED NOT NULL UNIQUE,
	first_date_occupied DATE,
	last_date_occupied DATE,
	total_days INT,
	amount_charged DECIMAL,
	tax_rate DOUBLE,
	tax_amount DECIMAL,
	payment_total DECIMAL,
	notes TEXT
);

INSERT INTO payments(employee_id, account_number) VALUES
(1, 1),
(2, 2),
(3, 3);

CREATE TABLE occupancies(
	id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	employee_id INT UNSIGNED NOT NULL UNIQUE,
	date_occupied DATE,
	account_number INT UNSIGNED NOT NULL UNIQUE,
	room_number INT UNSIGNED NOT NULL UNIQUE,
	rate_applied DOUBLE,
	phone_charge DOUBLE,
	notes TEXT
);

INSERT INTO occupancies(employee_id, account_number, room_number) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

-- Pr15
CREATE DATABASE softuni;

CREATE TABLE towns(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50)
);

CREATE TABLE addresses(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	address_text VARCHAR(50) NOT NULL,
	town_id INT UNSIGNED NOT NULL,
	FOREIGN KEY (town_id) REFERENCES towns(id)
);

CREATE TABLE departments(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL
);

CREATE TABLE employees(
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
	middle_name VARCHAR(50),
	last_name VARCHAR(50) NOT NULL,
	job_title VARCHAR(50) NOT NULL,
	department_id INT UNSIGNED NOT NULL,
	hire_date DATE NOT NULL,
	salary DECIMAL NOT NULL,
	address_id INT UNSIGNED,
	FOREIGN KEY (department_id) REFERENCES departments(id),
   FOREIGN KEY (address_id) REFERENCES addresses(id)
);

-- Pr17
INSERT INTO `towns`(name) VALUES
("Sofia"),
("Plovdiv"),
("Varna"),
("Burgas");

INSERT INTO `departments`(name) VALUES
("Engineering"),
("Sales"),
("Marketing"),
("Software Development"),
("Quality Assurance");

INSERT INTO `employees`
(first_name, middle_name, last_name, job_title, department_id, hire_date, salary) VALUES
("Ivan", "Ivanov", "Ivanov", ".NET Developer", 4, "2013-02-01", "3500.00"),
("Petar", "Petrov", "Petrov", "Senior Engineer", 1, "2004-03-02", "4000.00"),
("Maria", "Petrova", "Ivanova", "Intern", 5, "2016-08-28", "525.25"),
("Georgi", "Teziev", "Ivanov", "CEO", 2, "2007-12-09", "3000.00"),
("Peter", "Pan", "Pan", "Intern", 3, "2016-08-28", "599.88");

-- Pr18
SELECT * FROM towns;

SELECT * FROM departments;

SELECT * FROM employees;

-- Pr19
SELECT * FROM towns
 ORDER BY towns.name ASC;

SELECT * FROM departments
 ORDER BY departments.name ASC;

SELECT * FROM employees
 ORDER BY employees.salary DESC;
 
-- Pr20
SELECT t.name
  FROM towns AS t
 ORDER BY t.name ASC;

SELECT d.name
  FROM departments AS d
 ORDER BY d.name ASC;

SELECT e.first_name, e.last_name, e.job_title, e.salary
  FROM employees AS e
 ORDER BY e.salary DESC;
 
-- Pr21
UPDATE employees AS e
   SET e.salary = e.salary * 1.10; 

SELECT e.salary
  FROM employees AS e;
  
-- Pr22
UPDATE payments AS p
   SET p.tax_rate = p.tax_rate * 0.97; 

SELECT p.tax_rate
  FROM payments AS p;
  
-- Pr23
TRUNCATE `occupancies`;