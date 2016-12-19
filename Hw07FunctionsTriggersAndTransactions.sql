-- PART I: SoftUni Database Queries
USE soft_uni;

-- Problem 1. Employees with Salary Above 35000
DROP PROCEDURE usp_get_employees_salary_above_35000;
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000 ()
BEGIN
	SELECT first_name, last_name FROM Employees
	WHERE salary > 35000;
END$$
DELIMITER ;

CALL usp_get_employees_salary_above_35000

-- Problem 2. Employees with Salary Above Number
DROP PROCEDURE usp_get_employees_salary_above;
DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above (IN number DECIMAL(19, 4))
BEGIN
	SELECT first_name, last_name FROM employees
	WHERE salary >= number;
END$$
DELIMITER ;
CALL usp_get_employees_salary_above (10000.234);

-- Problem 3. Towns Starting With
DROP PROCEDURE usp_get_towns_starting_with;
DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with (IN prefix VARCHAR(255))
BEGIN
	SELECT Name FROM Towns
	WHERE Name LIKE CONCAT(prefix, '%');
END$$
DELIMITER ;

CALL usp_get_towns_starting_with ('sofia')

-- Problem 4. Employees from Town
DROP PROCEDURE usp_get_employees_from_town;
DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town (IN townName VARCHAR(255))
BEGIN
	SELECT first_name, last_name FROM employees
	JOIN addresses ON employees.address_id = addresses.address_id
	JOIN towns ON addresses.town_id = towns.town_id
	WHERE towns.name = townName;
END$$
DELIMITER ;

CALL usp_get_employees_from_town ('index')

-- Problem 5. Salary Level Function
DELIMITER $$
CREATE FUNCTION ufn_get_salary_level(salary DECIMAL(19,4))
RETURNS VARCHAR(10)
BEGIN
	DECLARE salaryLevel VARCHAR(10);
	IF salary < 30000
	THEN
		SET salaryLevel = 'Low';
	ELSEIF salary >= 30000 AND salary <= 50000
	THEN
		SET salaryLevel = 'Average';
	ELSE
		SET salaryLevel = 'High';
	END IF;
	RETURN salaryLevel;
END$$
DELIMITER ;

SELECT first_name, last_name, salary, ufn_get_salary_level(salary) FROM Employees
WHERE Salary > 50000;

-- Problem 6. Employees by Salary Level
DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level (IN salaryLevel VARCHAR(10))
BEGIN
	SELECT first_name, last_name FROM employees
	WHERE ufn_get_salary_level(salary) = salaryLevel;
END$$
DELIMITER ;

CALL usp_get_employees_by_salary_level ('low');
CALL usp_get_employees_by_salary_level ('average');
CALL usp_get_employees_by_salary_level ('high');

-- Problem 7. Define Function
DELIMITER $$
CREATE FUNCTION ufn_is_word_comprised (set_of_letters VARCHAR(255), word VARCHAR(255))
RETURNS BIT
BEGIN
   DECLARE counter INTEGER DEFAULT 0;
   DECLARE ch VARCHAR(255);
    SET counter = 1;
    WHILE counter < LENGTH(word)
    DO
        SET ch = SUBSTRING(word, counter, 1);
        IF LOCATE(ch, set_of_letters, 1) = 0
        THEN
            RETURN 0;
        END IF;
        
        SET counter = counter + 1;
    END WHILE;
    RETURN 1;
END$$
DELIMITER ;

SELECT Name, ufn_is_word_comprised('afiso', Name) FROM Towns

-- Problem 8. *Delete Employees and Departments
CREATE TRIGGER t_EmployeesDelete
on Employees
INSTEAD OF DELETE
AS
    UPDATE Employees SET ManagerID = NULL WHERE ManagerID IN (SELECT EmployeeID FROM deleted)
	UPDATE Departments SET ManagerID = NULL WHERE ManagerID IN (SELECT EmployeeID FROM deleted)
    DELETE FROM Employees WHERE EmployeeID in (SELECT EmployeeID FROM deleted)

DELETE FROM 
[SoftUni].[dbo].[EmployeesProjects]
WHERE EmployeeID IN (
          SELECT EmployeeID 
          FROM Employees
          WHERE DepartmentID IN (7, 8)
          )

ALTER TABLE Departments ALTER COLUMN ManagerID INT NULL

DELETE FROM Employees
 WHERE DepartmentID IN (7, 8)

DELETE FROM Departments
 WHERE DepartmentID IN (7, 8)

 SELECT * FROM Employees WHERE DepartmentID = 7 OR DepartmentID = 8
 SELECT * FROM Departments

-- PART II: Bank Database Queries
DROP DATABASE Bank;
CREATE DATABASE Bank;
USE Bank;

CREATE TABLE account_holders
(
id INT NOT NULL,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
ssn CHAR(10) NOT NULL,
CONSTRAINT pk_account_holders PRIMARY KEY (id)
);

CREATE TABLE accounts
(
id INT NOT NULL,
account_holder_id INT NOT NULL,
balance DECIMAL(19, 4) DEFAULT 0,
CONSTRAINT pk_accounts PRIMARY KEY (Id),
CONSTRAINT fk_accounts_account_holders FOREIGN KEY (account_holder_id) REFERENCES account_holders(id)
);

INSERT INTO account_holders (id, first_name, last_name, ssn) VALUES (1, 'Susan', 'Cane', '1234567890');
INSERT INTO account_holders (id, first_name, last_name, ssn) VALUES (2, 'Kim', 'Novac', '1234567890');
INSERT INTO account_holders (id, first_name, last_name, ssn) VALUES (3, 'Jimmy', 'Henderson', '1234567890');
INSERT INTO account_holders (id, first_name, last_name, ssn) VALUES (4, 'Steve', 'Stevenson', '1234567890');
INSERT INTO account_holders (id, first_name, last_name, ssn) VALUES (5, 'Bjorn', 'Sweden', '1234567890');
INSERT INTO account_holders (id, first_name, last_name, ssn) VALUES (6, 'Kiril', 'Petrov', '1234567890');
INSERT INTO account_holders (id, first_name, last_name, ssn) VALUES (7, 'Petar', 'Kirilov', '1234567890');
INSERT INTO account_holders (id, first_name, last_name, ssn) VALUES (8, 'Michka', 'Tsekova', '1234567890');
INSERT INTO account_holders (id, first_name, last_name, ssn) VALUES (9, 'Zlatina', 'Pateva', '1234567890');
INSERT INTO account_holders (id, first_name, last_name, ssn) VALUES (10, 'Monika', 'Miteva', '1234567890');
INSERT INTO account_holders (id, first_name, last_name, ssn) VALUES (11, 'Zlatko', 'Zlatyov', '1234567890');
INSERT INTO account_holders (id, first_name, last_name, ssn) VALUES (12, 'Petko', 'Petkov Junior', '1234567890');

INSERT INTO accounts (id, account_holder_id, balance) VALUES (1, 1, 123.12);
INSERT INTO accounts (id, account_holder_id, balance) VALUES (2, 3, 4354.23);
INSERT INTO accounts (id, account_holder_id, balance) VALUES (3, 12, 6546543.23);
INSERT INTO accounts (id, account_holder_id, balance) VALUES (4, 9, 15345.64);
INSERT INTO accounts (id, account_holder_id, balance) VALUES (5, 11, 36521.20);
INSERT INTO accounts (id, account_holder_id, balance) VALUES (6, 8, 5436.34);
INSERT INTO accounts (id, account_holder_id, balance) VALUES (7, 10, 565649.20);
INSERT INTO accounts (id, account_holder_id, balance) VALUES (8, 11, 999453.50);
INSERT INTO accounts (id, account_holder_id, balance) VALUES (9, 1, 5349758.23);
INSERT INTO accounts (id, account_holder_id, balance) VALUES (10, 2, 543.30);
INSERT INTO accounts (id, account_holder_id, balance) VALUES (11, 3, 10.20);
INSERT INTO accounts (id, account_holder_id, balance) VALUES (12, 7, 245656.23);
INSERT INTO accounts (id, account_holder_id, balance) VALUES (13, 5, 5435.32);
INSERT INTO accounts (id, account_holder_id, balance) VALUES (14, 4, 1.23);
INSERT INTO accounts (id, account_holder_id, balance) VALUES (15, 6, 0.19);
INSERT INTO accounts (id, account_holder_id, balance) VALUES (16, 2, 5345.34);
INSERT INTO accounts (id, account_holder_id, balance) VALUES (17, 11, 76653.20);
INSERT INTO accounts (id, account_holder_id, balance) VALUES (18, 1, 235469.89);

-- Problem 9. Find Full Name
DELIMITER $$
CREATE PROCEDURE usp_get_holders_full_name ()
BEGIN
	SELECT CONCAT(first_name, ' ', last_name) FROM account_holders;
END$$
DELIMITER ;

CALL usp_get_holders_full_name;

-- Problem 10. People with Balance Higher Than
DELIMITER $$
CREATE PROCEDURE usp_get_holders_with_balance_higher_than (balance DECIMAL(19, 4))
BEGIN
	SELECT first_name, last_name FROM account_holders
	JOIN accounts ON accounts.account_holder_id = account_holders.id
	GROUP BY first_name, last_name
	HAVING SUM(balance) > balance;
END$$
DELIMITER ;

CALL usp_get_holders_with_balance_higher_than(7000);

-- Problem 11. Future Value Function
DELIMITER $$
CREATE FUNCTION ufn_calculate_future_value(initial_sum DOUBLE, rate DOUBLE, years DOUBLE)
RETURNS DOUBLE
BEGIN
	RETURN initial_sum * pow(1 + rate, years);
END$$
DELIMITER ;

SELECT ufn_calculate_future_value(1000.0, 0.10, 5);
SELECT ufn_calculate_future_value(1000.0, 0.08, 5);
SELECT ufn_calculate_future_value(1000.0, 0.04, 2);
SELECT ufn_calculate_future_value(1000.21, 0.02, 1); 
SELECT ufn_calculate_future_value(1000.98, 0.05, 3);


-- Problem 12. Calculating Interest
DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account (account_id INT, rate FLOAT)
BEGIN
	SELECT 
		acc.Id,
		first_name,
		last_name,
		balance AS "Current Balance",
		ufn_calculate_future_value(balance, rate, 5) AS "Balance in 5 years"
	FROM accounts acc
	JOIN account_holders ah ON acc.account_holder_id = ah.id
	WHERE acc.id = account_id;
END$$
DELIMITER ;

CALL usp_calculate_future_value_for_account (1, 0.1);

-- Problem 13. Deposit and Withdraw Money Procedures
DELIMITER $$
CREATE PROCEDURE usp_withdraw_money (account_id INT, money_amount DECIMAL)
BEGIN
	START TRANSACTION;
	
	UPDATE accounts SET balance = Balance - money_amount
	WHERE Id = account_id;
	
	IF (SELECT COUNT(*) FROM accounts where id = account_id) <> 1
	THEN
		ROLLBACK;
	END IF;

	COMMIT;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE usp_deposit_money (account_id INT, money_amount DECIMAL)
BEGIN
	START TRANSACTION;
	
	UPDATE accounts SET balance = Balance + money_amount
	WHERE Id = account_id;
	
	IF (SELECT COUNT(*) FROM accounts where id = account_id) <> 1
	THEN
		ROLLBACK;
	END IF;

	COMMIT;
END$$
DELIMITER ;

CALL usp_deposit_money (1, 10);
select * from Accounts
WHERE id = 1;

CALL usp_deposit_money (2, 10.1);
select * from Accounts
WHERE id = 2;

CALL usp_deposit_money (3, 12.43245656);
select * from Accounts
WHERE id = 3;

CALL usp_withdraw_money (1, 10);
select * from Accounts
WHERE id = 1;

CALL usp_withdraw_money (2, 10.1);
select * from Accounts
WHERE id = 2;

CALL usp_withdraw_money (3, 12.43245656);
select * from Accounts
WHERE id = 3;

CALL usp_deposit_money (1, 12.3);
CALL usp_withdraw_money (1, 12.0001);
SELECT * FROM Accounts WHERE id = 1;

-- Problem 14. Money Transfer
DELIMITER $$
CREATE PROCEDURE usp_transfer_Money (from_account INT, to_account INT, money_amount DECIMAL)
BEGIN
	START TRANSACTION;

	IF money_amount < 0
	THEN
		ROLLBACK;
	END IF;

	CALL usp_withdraw_money (from_account, money_amount);

	CALL usp_Deposit_Money (to_account, money_amount);

	COMMIT;
END$$
DELIMITER ;

-- Problem 15. Create Table Logs
CREATE TABLE logs(
log_id INT AUTO_INCREMENT NOT NULL,
account_id INT NOT NULL,
old_sum DECIMAL,
new_sum DECIMAL,
CONSTRAINT pk_logs PRIMARY KEY (log_id)
);

DELIMITER $$
CREATE TRIGGER t_Account AFTER UPDATE ON Accounts
FOR EACH ROW
BEGIN
		SET @account_id = OLD.id;
		SET @old_sum = OLD.balance;
		SET @new_sum = NEW.balance;
		INSERT INTO Logs (account_id, old_sum, new_sum) VALUES (@account_id, @old_sum, @new_sum);
END$$
DELIMITER ;


CALL usp_deposit_money (1, 10);
SELECT * FROM logs;

-- Problem 16. Create Table Emails
CREATE TABLE notification_emails
(
id INT AUTO_INCREMENT NOT NULL,
recipient INT NOT NULL,
subject VARCHAR(50),
Body VARCHAR(255),
CONSTRAINT pk_notification_emails PRIMARY KEY (id)
);

DELIMITER $$
CREATE TRIGGER t_CreateEmail AFTER INSERT ON logs
FOR EACH ROW
BEGIN
	SET @recipient = NEW.account_id;
	SET @old_sum = NEW.old_sum;
	SET @new_sum = NEW.new_sum;
	SET @subject = CONCAT('Balance change for account: ', @recipient);
	SET @body = CONCAT('On ', NOW(), ' your balance was changed from ', @old_sum, ' to ', @new_sum, '.');

	INSERT INTO notification_emails (recipient, subject, body) VALUES (@recipient, @subject, @body);
END$$
DELIMITER ;

CALL usp_deposit_money (1, 10);
SELECT * FROM logs;
SELECT * FROM notification_emails;

-- PART III: Diablo Database Queries
USE Diablo 
GO

-- Problem 18. Trigger
GO
CREATE TRIGGER tr_User_Game_Items on User_Game_Items
INSTEAD OF INSERT
AS
	INSERT INTO User_Game_Items
	SELECT Item_Id, User_Game_Id FROM inserted
	WHERE
		Item_Id in (
			SELECT Id 
			FROM Items 
			WHERE Min_Level <= (
				SELECT Level
				FROM Users_Games 
				WHERE Id = User_Game_Id
			)
		)
GO

-- Add bonus cash for users
UPDATE Users_Games
SET Cash = Cash + 50000 + (SELECT SUM(i.Price) FROM Items i JOIN User_Game_Items ugi ON ugi.Item_Id = i.Id WHERE ugi.User_Game_Id = Users_Games.Id)
WHERE User_Id IN (
	SELECT Id 
	FROM Users 
	WHERE User_name IN ('loosenoise', 'baleremuda', 'inguinalself', 'buildingdeltoid', 'monoxidecos')
)
AND Game_Id = (SELECT Id FROM Games WHERE Name = 'Bali')

-- Buy items for users
INSERT INTO User_Game_Items (User_Game_Id, Item_Id)
SELECT  Users_Games.Id, i.Id 
FROM Users_Games, Items i
WHERE User_Id in (
	SELECT Id 
	FROM Users 
	WHERE User_name IN ('loosenoise', 'baleremuda', 'inguinalself', 'buildingdeltoid', 'monoxidecos')
) AND Game_Id = (SELECT Id FROM Games WHERE Name = 'Bali' ) AND ((i.Id > 250 AND i.Id < 300) OR (i.Id > 500 AND i.Id < 540))


-- Get cash from users
UPDATE Users_Games
SET Cash = Cash - (SELECT SUM(i.Price) FROM Items i JOIN User_Game_Items ugi ON ugi.Item_Id = i.Id WHERE ugi.User_Game_Id = Users_Games.Id)
WHERE User_Id IN (
	SELECT Id 
	FROM Users 
	WHERE User_name IN ('loosenoise', 'baleremuda', 'inguinalself', 'buildingdeltoid', 'monoxidecos')
)
AND Game_Id = (SELECT Id FROM Games where Name = 'Bali')

SELECT u.User_name, g.Name, ug.Cash, i.Name as `Item Name` FROM Users_Games ug
JOIN Games g ON ug.Game_Id = g.Id
JOIN Users u ON ug.User_Id = u.Id
JOIN User_Game_Items ugi ON ugi.User_Game_Id = ug.Id
JOIN Items i ON i.Id = ugi.Item_Id
WHERE g.Name = 'Bali'
ORDER BY User_name, `Item Name`;

-- Problem 19. Massive Shopping
START TRANSACTION;
	UPDATE 
		Users_Games 
	SET 
		Cash = Cash - (SELECT SUM(Price) FROM Items WHERE Min_Level BETWEEN 11 AND 12) 
	WHERE Id = 110;

	INSERT INTO User_Game_Items (User_Game_Id, Item_Id)
		SELECT 110, Id FROM Items WHERE Min_Level BETWEEN 11 AND 12;
COMMIT;

START TRANSACTION;
	UPDATE 
		Users_Games 
	SET 
		Cash = Cash - (SELECT SUM(Price) FROM Items WHERE Min_Level BETWEEN 19 AND 21) 
	WHERE Id = 110;

	INSERT INTO User_Game_Items (User_Game_Id, Item_Id)
		SELECT 110, Id FROM Items WHERE Min_Level BETWEEN 19 AND 21;
COMMIT;


SELECT Items.Name as `Item Name`
FROM Items 
INNER JOIN User_Game_Items ON Items.Id = User_Game_Items.Item_Id 
WHERE User_Game_Id = 110 
ORDER BY `Item Name`

-- Problem 20. Number of Users for Email Provider
select 
	SUBSTRING(Email, LOCATE('@', Email) + 1, LENGTH(Email) - LOCATE('@', Email)) AS `Email Provider`,
	COUNT(User_name) AS `Number Of Users`
from Users
group by SUBSTRING(Email, LOCATE('@', Email) + 1, LENGTH(Email) - LOCATE('@', Email))
order by COUNT(User_name) desc, `Email Provider`

-- Problem 21. All Users in Games
select g.Name as Game, gt.Name as "Game Type", u.User_name, ug.Level, ug.Cash, c.Name as "Character" from Games g
join Game_Types gt on gt.Id = g.Game_Type_Id
join Users_Games ug on ug.Game_Id = g.Id
join Users u on ug.User_Id = u.Id
join Characters c on c.Id = ug.Character_Id
order by Level desc, User_name, g.Name

-- Problem 22. Users in Games with Their Items
select u.User_name, g.Name as Game, COUNT(i.Id) as `Items Count`, SUM(i.Price) as `Items Price`
from Users u
join Users_Games ug on ug.User_Id = u.Id
join Games g on ug.Game_Id = g.Id
join Characters c on ug.Character_Id = c.Id
join User_Game_Items ugi on ugi.User_Game_Id = ug.Id
join Items i on i.Id = ugi.Item_Id
group by u.User_name, g.Name
having COUNT(i.Id) >= 10
order by `Items Count` desc, `Items Price` desc, User_name

-- Problem 23. * User in Games with Their Statistics
select 
	u.User_name, 
	g.Name as Game, 
	MAX(c.Name) `character`,
	SUM(its.Strength) + MAX(gts.Strength) + MAX(cs.Strength) as Strength,
	SUM(its.Defence) + MAX(gts.Defence) + MAX(cs.Defence) as Defence,
	SUM(its.Speed) + MAX(gts.Speed) + MAX(cs.Speed) as Speed,
	SUM(its.Mind) + MAX(gts.Mind) + MAX(cs.Mind) as Mind,
	SUM(its.Luck) + MAX(gts.Luck) + MAX(cs.Luck) as Luck
from Users u
join Users_Games ug on ug.User_Id = u.Id
join Games g on ug.Game_id = g.Id
join Game_Types gt on gt.Id = g.Game_Type_Id
join Statistics gts on gts.Id = gt.Bonus_Stats_Id
join Characters c on ug.Character_Id = c.Id
join Statistics cs on cs.id = c.statistics_id
join User_Game_Items ugi on ugi.User_Game_Id = ug.Id
join Items i on i.Id = ugi.Item_Id
join Statistics its on its.Id = i.Statistics_Id
group by u.User_name, g.Name
order by Strength desc, Defence desc, Speed desc, Mind desc, Luck desc


-- Problem 24. All Items with Greater than Average Statistics
select 
	i.Name, 
	i.Price, 
	i.Min_Level,
	s.Strength,
	s.Defence,
	s.Speed,
	s.Luck,
	s.Mind
from Items i
join Statistics s on s.Id = i.Statistics_Id
where s.Mind > (
	select AVG(s.Mind) from Items i 
	join Statistics s on s.Id = i.Statistics_Id
) and s.Luck > (
	select AVG(s.Luck) from Items i 
	join Statistics s on s.Id = i.Statistics_Id
) and s.Speed > (
	select AVG(s.Speed) from Items i 
	join Statistics s on s.Id = i.Statistics_Id
) 
ORDER BY i.Name

-- Problem 25. Display All Items with information about Forbidden Game Type
select i.Name as Item, Price, Min_Level, gt.Name as `Forbidden Game Type` from Items i
left join Game_Type_Forbidden_Items gtf on gtf.Item_Id = i.Id
left join Game_Types gt on gt.Id = gtf.Game_Type_Id
order by `Forbidden Game Type` desc, Item

-- Problem 26. Buy Items for User in Game
DELIMITER $$
CREATE PROCEDURE usp_buy_items_for_alex ()
BEGIN
	DECLARE alex_id INTEGER DEFAULT 0;
	SET alex_id = (select ug.Id from Users_Games ug 
				join Users u on u.Id = ug.User_Id
				join Games g on g.Id = ug.Game_Id
				where u.User_name = 'Alex' and g.Name = 'Edinburgh');
				
	INSERT INTO User_Game_Items(Item_Id, User_Game_Id)
	VALUES 
		(
			(select Id from Items where Name = 'Blackguard'), 
			alex_id
		);
	
	
	update Users_Games
	set Cash = Cash - (select Price from Items where Name = 'Blackguard')
	where Id = alex_id;
	
	insert into User_Game_Items(Item_Id, User_Game_Id)
	values 
		(
			(select Id from Items where Name = 'Bottomless Potion of Amplification'), 
			alex_id
		);
	
	update Users_Games
	set Cash = Cash - (select Price from Items where Name = 'Bottomless Potion of Amplification')
	where Id = alex_id;
	
	insert into User_Game_Items(Item_Id, User_Game_Id)
	values (
			(select Id from Items where Name = 'Eye of Etlich (Diablo III)'), 
			alex_id
		);
	
	update Users_Games
	set Cash = Cash - (select Price from Items where Name = 'Eye of Etlich (Diablo III)')
	where Id = alex_id;
	
	insert into User_Game_Items(Item_Id, User_Game_Id)
	values (
			(select Id from Items where Name = 'Gem of Efficacious Toxin'), 
			alex_id
		);
	
	update Users_Games
	set Cash = Cash - (select Price from Items where Name = 'Gem of Efficacious Toxin')
	where Id = alex_id;
	
	insert into User_Game_Items(Item_Id, User_Game_Id)
	values (
			(select Id from Items where Name = 'Golden Gorget of Leoric'), 
			alex_id
		);
	
	update Users_Games
	set Cash = Cash - (select Price from Items where Name = 'Golden Gorget of Leoric')
	where Id = alex_id;
	
		
	insert into User_Game_Items(Item_Id, User_Game_Id)
	values (
			(select Id from Items where Name = 'Hellfire Amulet'), 
			alex_id
		);
	
	update Users_Games
	set Cash = Cash - (select Price from Items where Name = 'Hellfire Amulet')
	where Id = alex_id;
	
	select u.User_name, g.Name, ug.Cash, i.Name AS "Item Name" from Users_Games ug
	join Games g on ug.Game_Id = g.Id
	join Users u on ug.User_Id = u.Id
	join User_Game_Items ugi on ugi.User_Game_Id = ug.Id
	join Items i on i.Id = ugi.Item_Id
	where g.Name = 'Edinburgh'
	order by i.Name;
END$$
DELIMITER ;


CALL usp_buy_items_for_alex ();

-- PART IV – Queries for Geography Database
USE [Geography];

-- Problem 27. Peaks and Mountains
SELECT 
  Peak_Name, Mountain_Range as Mountain, Elevation
FROM 
  Peaks p 
  JOIN Mountains m ON p.Mountain_Id = m.Id
ORDER BY Elevation DESC, Peak_Name

-- Problem 28. Peaks with Their Mountain, Country and Continent
SELECT 
  Peak_Name, Mountain_Range as Mountain, c.Country_Name, cn.Continent_Name
FROM 
  Peaks p
  JOIN Mountains m ON p.Mountain_Id = m.Id
  JOIN Mountains_Countries mc ON m.Id = mc.Mountain_Id
  JOIN Countries c ON c.Country_Code = mc.Country_Code
  JOIN Continents cn ON cn.Continent_Code = c.Continent_Code
ORDER BY Peak_Name, Country_Name

-- Problem 29. Rivers by Country
SELECT
  c.Country_Name, ct.Continent_Name,
  COUNT(r.River_Name) AS Rivers_Count,
  IFNULL(SUM(r.Length), 0) AS Total_Length
FROM
  Countries c
  LEFT JOIN Continents ct ON ct.Continent_Code = c.Continent_Code
  LEFT JOIN Countries_Rivers cr ON c.Country_Code = cr.Country_Code
  LEFT JOIN Rivers r ON r.Id = cr.River_Id
GROUP BY c.Country_Name, ct.Continent_Name
ORDER BY Rivers_Count DESC, Total_Length DESC, Country_Name

-- Problem 30. Count of Countries by Currency
SELECT
  cur.Currency_Code,
  MIN(cur.Description) AS Currency,
  COUNT(c.Country_Name) AS Number_Of_Countries
FROM
  Currencies cur
  LEFT JOIN Countries c ON cur.Currency_Code = c.Currency_Code
GROUP BY cur.Currency_Code
ORDER BY Number_Of_Countries DESC, Currency ASC

-- Problem 31. Population and Area by Continent
SELECT
  ct.Continent_Name,
  SUM(CAST(c.Area_In_Sq_Km AS DECIMAL)) AS Countries_Area,
  SUM(CAST(c.Population AS DECIMAL)) AS Countries_Population
FROM
  Countries c
  LEFT JOIN Continents ct ON ct.Continent_Code = c.Continent_Code
GROUP BY ct.Continent_Name
ORDER BY Countries_Population DESC

--Problem 32. Monasteries by Country
CREATE TABLE Monasteries(
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50),
  country_code CHAR(2),
  CONSTRAINT fk_monasteries_countries FOREIGN KEY (country_code) REFERENCES Countries(country_code)
);

INSERT INTO Monasteries(Name, Country_Code) VALUES
('Rila Monastery “St. Ivan of Rila”', 'BG'), 
('Bachkovo Monastery “Virgin Mary”', 'BG'),
('Troyan Monastery “Holy Mother''s Assumption”', 'BG'),
('Kopan Monastery', 'NP'),
('Thrangu Tashi Yangtse Monastery', 'NP'),
('Shechen Tennyi Dargyeling Monastery', 'NP'),
('Benchen Monastery', 'NP'),
('Southern Shaolin Monastery', 'CN'),
('Dabei Monastery', 'CN'),
('Wa Sau Toi', 'CN'),
('Lhunshigyia Monastery', 'CN'),
('Rakya Monastery', 'CN'),
('Monasteries of Meteora', 'GR'),
('The Holy Monastery of Stavronikita', 'GR'),
('Taung Kalat Monastery', 'MM'),
('Pa-Auk Forest Monastery', 'MM'),
('Taktsang Palphug Monastery', 'BT'),
('Sümela Monastery', 'TR');

ALTER TABLE Countries
ADD Is_Deleted BIT NOT NULL
DEFAULT 0;

UPDATE Countries c
INNER JOIN (SELECT c.Country_Code
  FROM Countries c
    JOIN Countries_Rivers cr ON c.Country_Code = cr.Country_Code
    JOIN Rivers r ON r.Id = cr.River_Id
  GROUP BY c.Country_Code
  HAVING COUNT(r.Id) > 3) c2
  on c.Country_Code = c2.Country_Code
SET Is_Deleted = 1;

SELECT 
  m.Name AS Monastery, c.Country_Name AS Country
FROM 
  Countries c
  JOIN Monasteries m ON m.Country_Code = c.Country_Code
WHERE c.Is_Deleted = 0
ORDER BY m.Name;

-- Problem 33. Monasteries by Continents and Countries
UPDATE Countries
SET Country_Name = 'Burma'
WHERE Country_Name = 'Myanmar';

INSERT INTO Monasteries(Name, Country_Code) VALUES
('Hanga Abbey', (SELECT Country_Code FROM Countries WHERE Country_Name = 'Tanzania'));
INSERT INTO Monasteries(Name, Country_Code) VALUES
('Myin-Tin-Daik', (SELECT Country_Code FROM Countries WHERE Country_Name = 'Maynmar'));

SELECT ct.Continent_Name, c.Country_Name, COUNT(m.Id) AS Monasteries_Count
FROM Continents ct
  LEFT JOIN Countries c ON ct.Continent_Code = c.Continent_Code
  LEFT JOIN Monasteries m ON m.Country_Code = c.Country_Code
WHERE c.Is_Deleted = 0
GROUP BY ct.Continent_Name, c.Country_Name
ORDER BY Monasteries_Count DESC, c.Country_Name;