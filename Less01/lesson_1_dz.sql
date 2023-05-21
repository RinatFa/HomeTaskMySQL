/* Задание.
1. Создайте таблицу с мобильными телефонами, используя графический
интерфейс. Заполните БД данными. Добавьте скриншот на платформу 
в качестве ответа на ДЗ
2. Выведите название, производителя и цену для товаров, количество 
которых превышает 2 (SQL - файл, скриншот, либо сам код)
3. Выведите весь ассортимент товаров марки “Samsung”
4. Выведите информацию о телефонах, где суммарный чек
больше 100 000 и меньше 145 000**
4.*** С помощью регулярных выражений найти (можно использовать
операторы “LIKE”, “RLIKE” для 4.3 ):
4.1. Товары, в которых есть упоминание "Iphone"
4.2. "Galaxy"
4.3. Товары, в которых есть ЦИФРЫ
4.4. Товары, в которых есть ЦИФРА "8"
*/
-- 1. Таблица с мобильными телефонами с данными.
CREATE DATABASE IF NOT EXISTS lesson_1_dz;
USE lesson_1_dz; 
DROP TABLE IF EXISTS mobile_phone;
CREATE TABLE mobile_phone
(
    Id INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(20),
    Manufacturer VARCHAR(20),
    ProductCount INT,
    Price INT    
)
AUTO_INCREMENT = 1;
INSERT mobile_phone(ProductName, Manufacturer, ProductCount, Price)
VALUES 
   ("iPhone X", "Apple", 3, 76000),
   ("iPhone 8", "Apple", 2, 51000),
   ("Galaxy S9", "Samsung", 2, 56000),
   ("Galaxy S8", "Samsung", 1, 41000),
   ("P20 Pro", "Huawei", 5, 36000);
SELECT * FROM mobile_phone;
-- 2. Название, производитель и цена для товаров, 
-- количество которых превышает 2
SELECT ProductName, Manufacturer, Price FROM mobile_phone
WHERE ProductCount > 2;
-- 3. Весь ассортимент товаров марки “Samsung”
SELECT ProductName, Manufacturer, ProductCount, Price FROM mobile_phone
WHERE Manufacturer = "Samsung";
-- 4. Информация о телефонах, где суммарный чек
-- больше 100 000 и меньше 145 000**
SELECT ProductName, Manufacturer, ProductCount, Price FROM mobile_phone
WHERE (ProductCount * Price) > 100000 AND (ProductCount * Price) < 145000;
-- 4.*** С помощью операторов “LIKE”, “RLIKE” (4.3) и регулярных выражений:
-- 4.1. Товары, в которых есть упоминание "Iphone"
SELECT ProductName, Manufacturer, ProductCount, Price FROM mobile_phone
WHERE ProductName LIKE "Iphone%";
-- 4.2. Товары, в которых есть упоминание "Galaxy"
SELECT ProductName, Manufacturer, ProductCount, Price FROM mobile_phone
WHERE ProductName LIKE "Galaxy%";
-- 4.3. Товары, в которых есть ЦИФРЫ
SELECT ProductName, Manufacturer, ProductCount, Price FROM mobile_phone
WHERE ProductName RLIKE "[0-9]";
-- 4.4. Товары, в которых есть ЦИФРА "8"
SELECT ProductName, Manufacturer, ProductCount, Price FROM mobile_phone
WHERE ProductName LIKE "%8%"; -- = RLIKE "[8]"
