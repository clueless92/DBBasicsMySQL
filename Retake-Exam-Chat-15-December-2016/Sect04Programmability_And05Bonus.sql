
-- Task15Radians
DELIMITER JJ
CREATE FUNCTION udf_get_radians(degrees_val FLOAT)
RETURNS FLOAT
BEGIN
	DECLARE radians_val FLOAT;
	SET radians_val := (degrees_val * PI()) / 180;
	RETURN radians_val;
END JJ
DELIMITER ;

SELECT udf_get_radians(22.12) AS `radians`

-- Task16ChangePassword
DELIMITER JJ
CREATE PROCEDURE udp_change_password(email VARCHAR(30), new_password VARCHAR(20))
BEGIN
	DECLARE user_count INT;
	SET user_count := (SELECT COUNT(*)
	  						  FROM credentials AS cr
	 						 WHERE cr.email = email);
	IF (user_count = 0)
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "The email does't exist!";
	ELSE
		UPDATE credentials AS cr SET cr.`password` = new_password WHERE cr.email = email;
	END IF;
END JJ
DELIMITER ;

CALL udp_change_password('abarnes0@sogou.com','new_pass');

-- Task17SendMessage
DELIMITER JJ
CREATE PROCEDURE udp_send_message(user_id INT, chat_id INT, content VARCHAR(200))
BEGIN
	DECLARE user_count INT;
	SET user_count := (SELECT COUNT(*)
	  						  FROM users AS u
	  						  JOIN users_chats AS uc ON uc.user_id = u.id
							 WHERE u.id = user_id AND uc.chat_id = chat_id);
	IF (user_count = 0)
		THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'There is no chat with that user!';
	ELSE
		INSERT INTO messages (messages.content, messages.sent_on, messages.user_id, messages.chat_id)
		VALUES (content, DATE(NOW()), user_id, chat_id);
	END IF;
END JJ
DELIMITER ;
	
CALL udp_send_message(19, 17, 'Awesome');

-- 18LogMessages
CREATE TABLE IF NOT EXISTS messages_log (
	id INT PRIMARY KEY AUTO_INCREMENT,
	content VARCHAR(200),
	sent_on DATE,
	chat_id INT,
	user_id INT
);

DELIMITER JJ
CREATE TRIGGER tr_on_message_deleted
AFTER DELETE ON messages FOR EACH ROW
BEGIN
	INSERT INTO messages_log (id, content, sent_on, chat_id, user_id)
	VALUES(old.id, old.content, old.sent_on, old.chat_id, old.user_id);
END JJ
DELIMITER ;

DELETE FROM messages WHERE messages.id = 1;

-- 19DeleteUsers
DELIMITER JJ
CREATE TRIGGER tr_on_delete_user
BEFORE DELETE ON users FOR EACH ROW
BEGIN
	DELETE FROM messages WHERE messages.user_id = old.id;
	DELETE FROM users_chats WHERE users_chats.user_id = old.id;
END JJ
DELIMITER ;

DELETE FROM users WHERE users.id = 1
