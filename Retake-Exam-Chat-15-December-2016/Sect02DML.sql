-- Task02Insert
INSERT INTO messages (content, sent_on, chat_id, user_id)
SELECT CONCAT(u.age, '-', u.gender, '-', l.latitude, '-', l.longitude) AS content,
				DATE(NOW()) AS sent_on,
				CASE
					WHEN (u.gender = 'F') THEN CEIL(SQRT(u.age * 2))
					WHEN (u.gender = 'M') THEN CEIL(POW(u.age / 18, 3))
				END AS chat_id,
				u.id AS user_id
	  FROM users AS u
	 INNER JOIN locations AS l
	    ON u.location_id = l.id
	 WHERE u.id >= 10 AND u.id <= 20
	 ORDER BY u.id ASC;

-- Task03Update
UPDATE chats AS c
 INNER JOIN messages AS m
    ON c.id = m.chat_id
   SET c.start_date = m.sent_on
 WHERE c.start_date > m.sent_on;
 
-- Task04Delete
DELETE locations
  FROM locations
  LEFT JOIN users
    ON locations.id = users.location_id
 WHERE users.id IS NULL;