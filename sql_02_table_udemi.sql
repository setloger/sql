-- Тестовая база данных: https://github.com/pthom/northwind_psql

-- 01 --

SELECT *
FROM products

SELECT product_id, product_name, unit_price
FROM products

-- 02 --

SELECT product_id, product_name, unit_price * units_in_stock
FROM products

SELECT product_id, product_name, unit_price * units_in_stock as full_price
FROM products

-- 03 DISTINCT выборка уникальных значений --

SELECT city, country
FROM employees

SELECT DISTINCT country
FROM employees

SELECT DISTINCT country
FROM employees

SELECT DISTINCT city, country
FROM employees

-- 04 --

SELECT *
FROM orders

SELECT COUNT (*)
FROM orders

-- запрос не учитывает кол-во стран, тк их 2

SELECT COUNT(country)
FROM employees

-- используем с DISTINCT --

SELECT COUNT(DISTINCT country)
FROM employees

-- 05, 06 --

-- используем несколько SELECT отделяем ; --

SELECT *
FROM costumers;

SELECT contact_name, city
FROM costumers

-- кол-во заказов

SELECT order_id, shipped_date - order_date
FROM orders

-- уникальные города и уникальные города + страна

SELECT DISTINCT city
FROM customers;

SELECT DISTINCT city, country
FROM customers

--

SELECT COUNT (DISTINCT country)
FROM customers

-- 07 WHERE --

SELECT company_name, contact_name, phone
FROM customers
WHERE country = 'USA';

SELECT *
FROM products
WHERE unit_price > 20;

SELECT COUNT (*) 
FROM products
WHERE unit_price > 20;

SELECT *
FROM customers
WHERE city <> 'Berlin';

-- 08 Логические операторы --

SELECT * 
FROM products
WHERE unit_price > 25; 

SELECT * 
FROM products
WHERE unit_price > 25 AND units_in_stock > 40;

SELECT * 
FROM customers
WHERE city = 'Berlin' or city = 'London' or city = 'San Francisco';

SELECT * 
FROM orders
WHERE shipped_date > '1998-04-30' AND (freight < 10 OR freight > 200);

-- 09 BETWEEN (всегда включает границы) --

SELECT COUNT(*) 
FROM orders
WHERE freight BETWEEN 20 AND 40; 

SELECT * 
FROM orders
WHERE order_date BETWEEN '1998-03-30' and '1998-04-03'

-- 10 IN & NOT IN --

-- пример запроса, ктр-й не стоит использовать
SELECT * 
FROM customers
WHERE country = 'Mexico' OR country = 'Germany' OR country = 'USA' OR country = 'Canada'

-- идентичный запрос --
SELECT * 
FROM customers
WHERE country IN('Mexico', 'Germany', 'USA', 'Canada');

SELECT * 
FROM customers
WHERE country NOT IN('Mexico', 'Germany', 'USA', 'Canada');

-- 11 ORDER BY --

SELECT DISTINCT country
FROM customers
ORDER BY country;

SELECT DISTINCT country
FROM customers
ORDER BY country DESC

SELECT DISTINCT country, city
FROM customers
ORDER BY country DESC, city ASC

-- 12 скалярные функции MIN, MAX, AVG, SUM --
-- MIN --

SELECT ship_city, order_date
FROM orders
WHERE ship_city = 'London'
ORDER BY order_date;

SELECT MIN(order_date)
FROM orders
WHERE ship_city = 'London'

--MAX --

-- загружаем ресурсы сервера, что не есть хорошо --
SELECT ship_city, order_date
FROM orders
WHERE ship_city = 'London'
ORDER BY order_date DESC;

SELECT MAX(order_date)
FROM orders
WHERE ship_city = 'London'

-- AVG --

SELECT AVG(unit_price)
FROM products
WHERE discontinued <> 1

-- SUM -- 

SELECT SUM(units_in_stock)
FROM products
WHERE discontinued <> 1

-- 14 Pattern Matching with Like --

SELECT last_name, first_name
FROM employees
WHERE last_name LIKE 'D%';

SELECT last_name, first_name
FROM employees
WHERE first_name LIKE '%t'

SELECT first_name, last_name, postal_code
FROM employees
Where postal_code LIKE '98%'

-- 15 LIMIT  --

SELECT product_name, unit_price
FROM products
WHERE discontinued <> 1
ORDER BY unit_price DESC
LIMIT 5

-- 16 NULL  --

SELECT ship_city, ship_region, ship_country
FROM orders
WHERE ship_region IS NULL

SELECT ship_city, ship_region, ship_country
FROM orders
WHERE ship_region IS NOT NULL

-- 17 GROUP BY  --

SELECT ship_country, COUNT(*)
FROM orders
WHERE freight > 50
GROUP BY ship_country
ORDER BY COUNT(*) DESC

SELECT category_id, SUM(units_in_stock)
FROM products
GROUP BY category_id
ORDER BY SUM(units_in_stock) DESC
LIMIT 10

-- 18 HAVING постфильтрация  --

SELECT category_id, SUM(unit_price * units_in_stock)
FROM products
WHERE discontinued <> 1
GROUP BY category_id
HAVING SUM(unit_price * units_in_stock) > 5000

-- 19 UNION, INTERSECT, EXCEPT  --
-- UNION объединяет две таблицы и удаляет дубликаты 

SELECT country
FROM customers
UNION
SELECT country
FROM employees

-- INTERSECT - пересечение между двумя таблицами

SELECT country
FROM customers
INTERSECT
SELECT country
FROM suppliers

-- EXCEPT - разница между таблицами

SELECT country
FROM customers
EXCEPT
SELECT country
FROM suppliers
