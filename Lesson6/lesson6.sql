-- Кто больше всех писал сообщения пользователю, если под "общался" считать входящие от друзей пользователя
select * from users 
where 
id = (select from_user_id from 
	(select count(*) as c, from_user_id from messages as m where to_user_id = 1  group by from_user_id order by c DESC limit 1) as bestfrend
);

-- Общее количество лайков получившие пользователи младше 10 лет
select count(*) from likes where id IN
	(select id from media where user_id IN  
		(select user_id from profiles where TIMESTAMPDIFF(year, birthday, NOW()) < 10));
		
-- Определить кто больше поставил лайков (всего) - мужчины или женщины?
select 
(select count(*) as dolikes from likes
where user_id in
(select user_id from profiles where gender = 'm')
) as male_likes,
(select count(*) as dolikes from likes
where user_id in
(select user_id from profiles where gender = 'f')
) as female_likes