-- Task05AgeRange
SELECT u.nickname, u.gender, u.age
  FROM users AS u
 WHERE u.age >= 22 AND u.age <= 37;
 
-- Task06Messages
SELECT m.content, m.sent_on
  FROM messages AS m
 WHERE m.sent_on > "2014-05-12" AND m.content LIKE '%just%'
 ORDER BY m.id DESC;
 
-- Task07Chats
SELECT c.title, c.is_active
  FROM chats AS c
 WHERE (c.is_active = 0 AND LENGTH(c.title) < 5) OR SUBSTR(c.title FROM 3 FOR 2) LIKE "tl"
 ORDER BY c.title DESC;
 
-- Task08ChatMessages
SELECT c.id, c.title, m.id
  FROM chats AS c
  JOIN messages AS m ON m.chat_id = c.id
 WHERE m.sent_on < "2012-03-26" AND RIGHT(c.title, 1) LIKE "x"
 ORDER BY c.id ASC, m.id ASC;
 
-- Task09MessageCount
SELECT c.id, COUNT(m.id) AS `total_messages`
  FROM chats AS c
 RIGHT JOIN messages AS m
    ON m.chat_id = c.id
 WHERE m.id IS NULL OR m.id < 90
 GROUP BY c.id
 ORDER BY `total_messages` DESC, c.id ASC
 LIMIT 5;
 
-- Task10Credentials
SELECT u.nickname, cr.email, cr.`password`
  FROM users AS u
  JOIN credentials AS cr ON u.credential_id = cr.id
 WHERE RIGHT(cr.email, 5) LIKE "co.uk"
 ORDER BY cr.email ASC;
 
-- Task11Locations
SELECT u.id, u.nickname, u.age
  FROM users AS u
  LEFT JOIN locations AS l ON u.location_id = l.id
 WHERE l.id IS NULL;
  
-- Task12LeftUsers
SELECT m.id, m.chat_id, m.user_id
  FROM messages AS m
  LEFT JOIN users_chats AS uc ON uc.user_id = m.user_id AND uc.chat_id = m.chat_id
 WHERE m.chat_id = 17 AND uc.user_id IS NULL
 ORDER BY m.id DESC;
  
-- Task13UsersInBulgaria
SELECT u.nickname, c.title, l.latitude, l.longitude
  FROM users AS u
  JOIN users_chats AS uc ON uc.user_id = u.id
  JOIN chats AS c ON c.id = uc.chat_id
  JOIN locations AS l ON l.id = u.location_id
 WHERE l.latitude >= 41.139999 AND l.latitude <= 44.129999 AND l.longitude >= 22.209999 AND l.longitude <= 28.359999
 ORDER BY c.title ASC;
 
-- Task14LastChat
SELECT c.title, m.content
  FROM chats AS c
  LEFT OUTER JOIN messages AS m
    ON m.chat_id = c.id
 WHERE c.start_date = (SELECT MAX(c.start_date)
						 FROM chats AS c);

-- doesn't work if there are 2 most recent messages in last chat
SELECT c.title, (SELECT m.content
				   FROM messages AS m
				  WHERE m.chat_id = c.id
				  ORDER BY m.sent_on ASC
				  LIMIT 1) AS content
  FROM chats AS c
 ORDER BY c.start_date DESC
 LIMIT 1;
 