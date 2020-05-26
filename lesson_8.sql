DESC likes;

SELECT COUNT(*) FROM likes 
  WHERE target_type_id = 2
    AND target_id IN (SELECT * FROM (
      SELECT user_id FROM profiles ORDER BY birthday DESC LIMIT 10
    ) AS sorted_profiles ) ;
   
--  ----------------------
    
SELECT l.target_type_id, COUNT(p.user_id) AS birthday
  FROM likes  AS l
    JOIN profiles AS p
  ON l.id = p.user_id
  GROUP BY p.user_id
  ORDER BY birthday
  LIMIT 10;
   

    
-- ---------------------------    
   
   SELECT 
  CONCAT(first_name, ' ', last_name) AS user, 
	(SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) + 
	(SELECT COUNT(*) FROM media WHERE media.user_id = users.id) + 
	(SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) AS overall_activity 
	  FROM users
	  ORDER BY overall_activity
	  LIMIT 10;
   
DESC likes ;
DESC messages;

-- 1
--  	 
-- SELECT users.id, first_name, last_name, COUNT(target_types.id) AS overall_activity
-- FROM users
--   LEFT JOIN likes 
--     ON users.id = likes.user_id
--   LEFT JOIN media
--     ON media.id = media.media_type_id
--   LEFT JOIN target_types
--     ON likes.target_type_id = target_types.id
--       AND target_types.name = 'media'
-- GROUP BY users.id
-- ORDER BY overall_activity DESC
-- LIMIT 10;

-- 2

SELECT users.id, first_name, last_name, COUNT(messages.id) AS overall_activity
FROM users
  LEFT JOIN likes 
    ON users.id = likes.user_id
  LEFT JOIN media
    ON media.id = media.media_type_id
  LEFT JOIN messages
    ON messages.from_user_id = messages.id
      AND messages.from_user_id = 'media'
GROUP BY users.id
ORDER BY overall_activity DESC
LIMIT 10;
