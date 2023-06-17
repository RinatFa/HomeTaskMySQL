/* Задание.
1. Создайте функцию, которая принимает кол-во сек и формат. их 
в кол-во дней, часов, минут и секунд.
Пример: 123456 -> '1 days 10 hours 17 minutes 36 seconds '
2. Выведите только четные числа от 1 до 10 (Через цикл).
Пример: 2,4,6,8,10
*/

CREATE DATABASE IF NOT EXISTS lesson_6_dz;
USE lesson_6_dz; 
-- 1. Создайте функцию, которая принимает кол-во сек и формат. их 
-- в кол-во дней, часов, минут и секунд.
-- Пример: 123456 -> '1 days 10 hours 17 minutes 36 seconds '
DROP FUNCTION IF EXISTS numb_daystime;
DELIMITER //
CREATE FUNCTION numb_daystime(input_number INT)
RETURNS VARCHAR(45)
DETERMINISTIC
  BEGIN
	DECLARE days INT;
	DECLARE hours INT;
	DECLARE minutes INT;
	DECLARE seconds INT;
	DECLARE temp INT;
    DECLARE result VARCHAR(45) DEFAULT "";
	SET days = input_number DIV 86400;
    SET temp = input_number MOD 86400;
    SET hours = temp DIV 3600;
    SET temp = temp MOD 3600;
    SET minutes = temp DIV 60;
    SET seconds = temp MOD 60;
	SET result = CONCAT(days, " days ", hours, " hours ",
			  minutes, " minutes ", seconds, " seconds ");
    RETURN result;
  END //
DELIMITER ;
SELECT numb_daystime(123456) AS 
"Количество дней, часов, минут и секунд";

-- 2. Выведите только четные числа от 1 до 10 (Через цикл).
-- Пример: 2,4,6,8,10
-- Вывод без последней запятой
DROP PROCEDURE IF EXISTS even_numbers;
DELIMITER //
CREATE PROCEDURE even_numbers(IN input_number INT)
  BEGIN
    DECLARE n INT;
    DECLARE result VARCHAR(45) DEFAULT "";
    SET n = 0;
    REPEAT
	  SET n = n + 2;
	  SET result = CONCAT(result, n, ",");
	  UNTIL n >= input_number - 2
	END REPEAT;
    SET result = CONCAT(result, input_number);
	SELECT result;
  END //
DELIMITER ;
CALL even_numbers(10);
