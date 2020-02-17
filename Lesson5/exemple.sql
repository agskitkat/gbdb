USE vk;

-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
-- Заполните их текущими датой и временем.
update users set created_at = NOW(), updated_at = NOW() where updated_at IS null and updated_at IS null;


-- Таблица users была неудачно спроектирована. 
-- Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались 
-- значения в формате "20.10.2017 8:10".
-- Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
ALTER TABLE users 
	ADD 
		created_at_new DATETIME;	
	
ALTER TABLE users 
	ADD 
		updated_at_new DATETIME;	
	
update users set 
	created_at_new = convert(STR_TO_DATE(created_at,'%d.%m.%Y %H:%i:%s'), DATETIME),
	updated_at_new = convert(STR_TO_DATE(updated_at,'%d.%m.%Y %H:%i:%s'), DATETIME);
	
ALTER TABLE users DROP COLUMN created_at;
ALTER TABLE users DROP COLUMN updated_at;

ALTER TABLE users CHANGE column created_at_new created_at DATETIME;

ALTER TABLE users CHANGE column updated_at_new updated_at DATETIME;


-- В таблице складских запасов storehouses_products в поле value могут встречаться 
-- самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. 
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
-- Однако, нулевые запасы должны выводиться в конце, после всех записей.

select value, IF(value = 0, 0, 1) isnotnull 
from storehouses_products 
order by isnotnull desc, value;




-- Подсчитайте средний возраст пользователей в таблице users
select avg(year(NOW()) - YEAR(birthday)) as avg_age from users left join profiles 
on profiles.user_id = users.id;

-- Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.
select 
WEEKDAY(
	convert(
		STR_TO_DATE (
			CONCAT (year(NOW()) , "-" , month(birthday) , "-" , day(birthday)),
			'%Y-%m-%d'
		)
		, DATETIME
	)
) as avg_age,
count(*)
from users 
left join profiles 
on profiles.user_id = users.id
group by avg_age;
	