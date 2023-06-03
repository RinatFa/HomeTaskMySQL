/* Задание.
1. Отсортируйте данные по полю заработная плата (salary) в порядке: 
убывания; возрастания 
2. Выведите 5 максимальных заработных плат (saraly)
3. Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
4. Найдите кол-во сотрудников с специальностью (post) «Рабочий» 
в возрасте от 24 до 49 лет включительно
5. Найдите количество специальностей
6. Выведите специальности, у которых средний возраст сотрудников меньше 30 лет

Доп: Внутри каждой должности вывести ТОП-2 по ЗП (2 самых 
высокооплачиваемых сотрудника по ЗП внутри каждой должности)
*/

-- 1. Таблица “staff” с данными. Отсортировать данные по полю 
-- заработная плата (salary) в порядке: убывания; возрастания 
CREATE DATABASE IF NOT EXISTS lesson_3_dz;
USE lesson_3_dz; 
DROP TABLE IF EXISTS staff;
CREATE TABLE staff
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(45),
    lastname VARCHAR(45),
	post VARCHAR(45),
    seniority INT,
    salary INT,
    age INT
);
INSERT staff (firstname, lastname, post, seniority, salary, age)
VALUES 
   ("Вася", "Петров", "Начальник", 40, 100000, 60),
   ("Петр", "Власов", "Начальник", 8, 70000, 30),
   ("Катя", "Катина", "Инженер", 2, 70000, 25),
   ("Саша", "Сасин", "Инженер", 12, 50000, 35),
   ("Иван", "Иванов", "Рабочий", 40, 30000, 59),
   ("Петр", "Петров", "Рабочий", 20, 25000, 40),
   ("Сидр", "Сидоров", "Рабочий", 10, 20000, 35),
   ("Антон", "Антонов", "Рабочий", 8, 19000, 28),
   ("Юрий", "Юрков", "Рабочий", 5, 15000, 25),
   ("Максим", "Максимов", "Рабочий", 2, 11000, 22),
   ("Юрий", "Галкин", "Рабочий", 3, 12000, 24),
   ("Людмила", "Маркина", "Уборщик", 10, 10000, 49);
SELECT firstname, lastname, post, seniority, salary, age 
FROM staff ORDER BY salary DESC;
SELECT firstname, lastname, post, seniority, salary, age 
FROM staff ORDER BY salary;

-- 2. Выведите 5 максимальных заработных плат (saraly)
SELECT firstname, lastname, post, seniority, salary, age 
FROM staff ORDER BY salary DESC LIMIT 5;

-- 3. Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
SELECT post, SUM(salary) AS "Суммарная зарплата" 
FROM staff GROUP BY post;

-- 4. Найдите кол-во сотрудников со специальностью (post) «Рабочий» 
-- в возрасте от 24 до 49 лет включительно
SELECT post, COUNT(post) AS "Кол-во сотрудников в возрасте от 24 до 49" 
FROM staff 
WHERE age BETWEEN 24 AND 49 
GROUP BY post HAVING post = "Рабочий";

-- 5. Найдите количество специальностей
SELECT COUNT(*) AS post_count FROM (
  SELECT post FROM staff GROUP BY post) as post_rows;

-- 6. Выведите специальности, у которых
-- средний возраст сотрудников меньше 33 лет
SELECT post,
  AVG(age) AS "Средний возраст < 33"
FROM staff GROUP BY post HAVING AVG(age) < 33;

-- Доп: Внутри каждой должности вывести ТОП-2 по ЗП (2 самых 
-- высокооплачиваемых сотрудника по ЗП внутри каждой должности)
(SELECT firstname, lastname, post, seniority, salary, age FROM staff
WHERE post = "Начальник" ORDER BY salary DESC LIMIT 2)
UNION
(SELECT firstname, lastname, post, seniority, salary, age FROM staff
WHERE post = "Инженер" ORDER BY salary DESC LIMIT 2)
UNION
(SELECT firstname, lastname, post, seniority, salary, age FROM staff
WHERE post = "Рабочий" ORDER BY salary DESC LIMIT 2)
UNION
(SELECT firstname, lastname, post, seniority, salary, age FROM staff
WHERE post = "Уборщик" ORDER BY salary DESC LIMIT 2);
