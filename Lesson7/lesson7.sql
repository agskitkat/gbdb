-- Составьте список пользователей users, 
 -- которые осуществили хотя бы один заказ orders в интернет магазине.
 select * from users where id in (select distinct user_id from orders);


-- Выведите список товаров products и разделов catalogs, который соответствует товару.
select id, name from products where catalog_id = (select catalog_id from products where id = 1 limit 1)
union 
select id, name from catalogs where id = (select catalog_id from products where id = 1 limit 1);



-- (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.
DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  t_from VARCHAR(255),
  t_to VARCHAR(255)
);
DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label VARCHAR(255),
  name VARCHAR(255)
);
INSERT INTO flights (t_from, t_to) VALUES
  ('moscow', 'london'),
  ('london', 'paris'),
  ('tokyo', 'bagdad'),
  ('newyork', 'lissabon');
 INSERT INTO cities (label, name) VALUES
  ('moscow', 'Москва'),
  ('london', 'Лондон'),
  ('tokyo', 'Токио'),
  ('newyork', 'Нью-йорк'),
  ('paris', 'Париж'),
  ('bagdad', 'Багдад'),
  ('lissabon', 'Лиссабон');
  
-- решение:
 select (select name from cities where label = f.t_from) as rus_from, (select name from cities where label = f.t_to) as rus_to from flights as f;