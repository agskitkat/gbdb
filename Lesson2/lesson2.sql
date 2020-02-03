/* 
	Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, 
	задав в нем логин и пароль, который указывался при установке.
	
	В моём случае, я использую OPENSERVER на Windows.
	
*/

/*
	Создайте базу данных example, разместите в ней таблицу users,
	состоящую из двух столбцов, числового id и строкового name.
*/
CREATE DATABASE example; 

USE `example`;

CREATE TABLE `users` (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Имя пользователя'
)
COMMENT = 'Таблица пользователей';

/* Немного строк... */
INSERT INTO `users` VALUES  
	(NULL, "Вася"),
	(NULL, "Петя"),
	(NULL, "Таня"),
	(NULL, "Азис");

/*
	Создайте дамп базы данных example из предыдущего задания, 
	разверните содержимое дампа в новую базу данных sample.
	
	Из консоли под Windows 10 x64
	
	>>> mysqldump -u mysql -pmysql example > example.dump.sql
	>>> mysql -u mysql -pmysql example_new < example.dump.sql
	
*/



/* 
	(по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. 
	Создайте дамп единственной таблицы help_keyword базы данных mysql. 
	Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.

	>>> mysqldump -u mysql -pmysql mysql help_keyword --where="true limit 100" > help_keyword.dump.sql
*/

