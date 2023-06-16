/* Задание.
1. Создайте представление, в которое попадут автомобили 
стоимостью до 25 000 долларов
2. Изменить в существующем представлении порог для стоимости: 
пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)
3. Создайте представление, в котором будут только автомобили марки 
“Шкода” и “Ауди”
4. Добавьте новый столбец под названием «время до следующей станции». 
Чтобы получить это значение, мы вычитаем время станций для пар 
смежных станций. Мы можем вычислить это значение без использования
оконной функции SQL, но это может быть очень сложно. Проще это 
сделать с помощью оконной функции LEAD. Эта функция сравнивает 
значения из одной строки со следующей строкой, чтобы получить
результат. В этом случае функция сравнивает значения в столбце 
«время» для станции со станцией сразу после нее.
*/

-- Таблица "cars" с данными.
CREATE DATABASE IF NOT EXISTS lesson_5_dz;
USE lesson_5_dz;
DROP TABLE IF EXISTS cars;
CREATE TABLE cars(
	id INT NOT NULL PRIMARY KEY,
    `name` VARCHAR(45),
    cost INT
);
INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);    
SELECT * FROM cars;

-- 1. Создайте представление, в которое попадут автомобили 
-- стоимостью до 25 000 долларов
DROP VIEW IF EXISTS cars_cost_25;
CREATE VIEW cars_cost_25 AS
	SELECT id, `name`, cost
	FROM cars
	WHERE cost <= 25000;
SELECT * FROM cars_cost_25;

-- 2. Изменить в существующем представлении порог для стоимости: 
-- пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)
ALTER VIEW cars_cost_25 AS
	SELECT id, `name`, cost
	FROM cars
	WHERE cost <= 30000;
SELECT * FROM cars_cost_25;

DROP VIEW cars_cost_25;

-- 3. Создайте представление, в котором будут только автомобили марки 
-- “Шкода” и “Ауди”
DROP VIEW IF EXISTS cars_name;
CREATE VIEW cars_name AS
	SELECT id, `name`, cost
	FROM cars
	WHERE `name` IN ('Skoda', 'Audi');
SELECT * FROM cars_name;

DROP VIEW cars_name;

/* 4. Добавьте новый столбец под названием «время до следующей станции». 
Чтобы получить это значение, мы вычитаем время станций для пар 
смежных станций. Мы можем вычислить это значение без использования
оконной функции SQL, но это может быть очень сложно. Проще это 
сделать с помощью оконной функции LEAD. Эта функция сравнивает 
значения из одной строки со следующей строкой, чтобы получить
результат. В этом случае функция сравнивает значения в столбце 
«время» для станции со станцией сразу после нее. */

-- Таблица "train" с данными.
DROP TABLE IF EXISTS train;
CREATE TABLE train(
	id INT NOT NULL PRIMARY KEY,
    train_id INT NOT NULL,
    station VARCHAR(20) NOT NULL,
    station_time TIME
);
INSERT train
VALUES
	(1, 110, "San Francisco", '10:00:00'),
    (2, 110, "Redwood City", '10:54:00'),
    (3, 110, "Palo Alto", '11:02:00'),
    (4, 110, "San Jose", '12:35:00'),
	(5, 120, "San Francisco", '11:00:00'),
    (6, 120, "Palo Alto", '12:49:00'), 
    (7, 120, "San Jose", '13:30:00');
SELECT * FROM train;

-- Добавлен новый столбец под названием «время до следующей станции»
-- NULL заменен на пустую строку
SELECT train_id, station, station_time,
  IF (SUBTIME(LEAD(station_time) 
    OVER(PARTITION BY train_id), station_time) IS NULL, '',
    SUBTIME(LEAD(station_time) 
    OVER(PARTITION BY train_id), station_time)) 
  AS 'time_to_next_station' -- OK без NULL
FROM train;
