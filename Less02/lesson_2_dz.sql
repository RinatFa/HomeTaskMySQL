/* Задание 1.
1. Используя операторы языка SQL, создайте табличку “sales”. 
Заполните ее данными.
2. Сгруппируйте значений количества в 3 сегмента — 
меньше 100, 100-300 и больше 300.
3. Создайте таблицу “orders”, заполните ее значениями. 
Покажите “полный” статус заказа, используя оператор CASE
*/
-- 1. Таблица “sales” с данными.
CREATE DATABASE IF NOT EXISTS lesson_2_dz;
USE lesson_2_dz; 
DROP TABLE IF EXISTS sales;
CREATE TABLE sales
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    order_date DATE,
    count_product INT
);
INSERT sales (order_date, count_product)
VALUES 
   ("2022-01-01", 156),
   ("2022-01-02", 180),
   ("2022-01-03", 21),
   ("2022-01-04", 124),
   ("2022-01-05", 341);
SELECT * FROM sales;

-- 2. Для данных таблицы “sales” тип заказ в зависимости
-- от количества — меньше 100, 100-300 и больше 300
SELECT
	id As "id заказа",
CASE
	WHEN count_product > 0 AND count_product < 100
		THEN "Маленький заказ"
	WHEN count_product BETWEEN 100 AND 300
		THEN "Средний заказ"
	WHEN count_product > 300
		THEN "Большой заказ"
	ELSE "Нет заказов"
END AS "Тип заказа"
FROM sales;

-- 3. Таблица “orders” с данными.
DROP TABLE IF EXISTS orders;
CREATE TABLE orders
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id VARCHAR(10),
    amount DECIMAL(7,2),
    order_status VARCHAR(10)
);
INSERT orders (employee_id, amount, order_status)
VALUES 
   ("e03", 15.00, "OPEN"),
   ("e01", 25.50, "OPEN"),
   ("e05", 100.70, "CLOSED"),
   ("e02", 22.18, "OPEN"),
   ("e04", 9.50, "CANCELLED");
-- SELECT * FROM orders;
SELECT
	employee_id,
    amount,
    order_status,
CASE
	WHEN order_status = "OPEN"
		THEN "Order is in open state"
	WHEN order_status = "CLOSED"
		THEN "Order is closed"
	WHEN order_status = "CANCELLED"
		THEN "Order is cancelled"
	ELSE "Нет заказа"
END AS "full_order_status"
FROM orders;

/* Задание 2 для файла со скриптом interview.sql:
№1. Используя оператор ALTER TABLE, установите внешний ключ в одной из таблиц (clients-posts)
№2. Без оператора JOIN, верните заголовок публикации, текст с описанием, идентификатор клиента, опубликовавшего публикацию и логин данного клиента.
№3. Выполните поиск по публикациям, автором которых является клиент "Mikle".
*/
-- №1.
ALTER TABLE posts
ADD FOREIGN KEY(user_id) REFERENCES users(id)
ON DELETE CASCADE ON UPDATE CASCADE;
-- №2.
SELECT title AS "Заголовок публикации", full_text AS "Текст с описанием", user_id AS "Идентификатор клиента, опубликовавшего публикацию", 
(SELECT login FROM users WHERE id = posts.user_id) AS "Логин данного клиента"
FROM posts;
-- №3.
SELECT title, full_text, users.login FROM posts
JOIN users ON users.id = posts.user_id
WHERE users.login = "Mikle";
