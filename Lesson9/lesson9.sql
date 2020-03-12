-- В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

START TRANSACTION;
insert into sample.users select * from shop.users where id = 1;
delete from shop.users where id = 1;
commit;


-- Создайте представление, которое выводит название name товарной позиции из таблицы products 
-- и соответствующее название каталога name из таблицы catalogs.

use shop;

DROP VIEW IF EXISTS products_category;
CREATE VIEW products_category AS 
	SELECT p.name as product_name, c.name as catalog_name FROM products p
	left join catalogs c on p.catalog_id = c.id;

SELECT * FROM products_category;



-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, 
-- в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна 
-- возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать 
-- фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DELIMITER //
DROP FUNCTION IF EXISTS hello//

CREATE FUNCTION hello()
RETURNS TEXT DETERMINISTIC
begin
	SET @hour = minute(NOW());
	IF(@hour >= 0 and @hour < 6 ) THEN
		return "Доброй ночи";
	END IF;
	IF(@hour >= 6 and @hour < 12 ) THEN
		return "Доброе утро";
	END IF;
	IF(@hour >= 12 and @hour < 18 ) THEN
		return "Добрый день";
	END IF;
	return "Добрый вечер";
end //
DELIMITER ;
SELECT hello();



-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное 
-- значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля 
-- были заполнены.  При попытке присвоить полям NULL-значение необходимо отменить операцию.

use shop;

DELIMITER //

DROP TRIGGER IF EXISTS ins_product_name_dsc_not_null //
CREATE TRIGGER ins_product_name_dsc_not_null BEFORE INSERT ON products
FOR EACH ROW
begin
  	if (NEW.name IS NULL and NEW.description IS null) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Долже быть указан хотябы один параметр name или description';
	END IF;
END//

DROP TRIGGER IF EXISTS upd_product_name_dsc_not_null //
CREATE TRIGGER upd_product_name_dsc_not_null BEFORE UPDATE ON products
FOR EACH ROW
begin
  	if (NEW.name IS NULL and NEW.description IS null) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Долже быть указан хотябы один параметр name или description';
	END IF;
END//

DELIMITER ;

INSERT into products  
		(name, description, price, catalog_id)
	values
		(null, null, 7890.00, 1);