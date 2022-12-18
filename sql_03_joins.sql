-- INNER JOIN внутреннее соединение --

SELECT product_name, suppliers.company_name, units_in_stock
FROM products
INNER JOIN suppliers ON products.supplier_id = suppliers.supplier_id
ORDER BY units_in_stock DESC;

SELECT category_name, SUM(units_in_stock)
FROM products
INNER JOIN categories ON products.category_id = categories.category_id
GROUP BY category_name
ORDER BY SUM(units_in_stock) DESC
LIMIT 5;

SELECT category_name, SUM(unit_price * units_in_stock)
FROM products
INNER JOIN categories ON products.category_id = categories.category_id
WHERE discontinued <> 1
GROUP BY category_name
HAVING SUM(unit_price * units_in_stock) > 5000
ORDER BY SUM(unit_price * units_in_stock) DESC;

SELECT order_id, customer_id, first_name, last_name, title
FROM orders
INNER JOIN employees ON orders.employee_id = employees.employee_id

SELECT order_date, product_name, ship_country, products.unit_price, quantity, discount
FROM orders
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id

-- LEFT, RIGHT JOIN --
-- Идентичные запросы --
-- 1 --
SELECT company_name, product_name
FROM suppliers
LEFT JOIN products ON suppliers.supplier_id = products.supplier_id;

SELECT company_name, product_name
FROM suppliers
INNER JOIN products ON suppliers.supplier_id = products.supplier_id

-- 2 --

SELECT company_name, order_id
FROM customers
LEFT JOIN orders ON orders.customer_id = customers.customer_id
WHERE order_id IS NULL;

SELECT company_name, order_id
FROM orders
RIGHT JOIN customers ON orders.customer_id = customers.customer_id
WHERE order_id IS NULL


-- SELF JOIN --
-- взято https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-self-join/ --
CREATE TABLE employee (
	employee_id INT PRIMARY KEY,
	first_name VARCHAR (255) NOT NULL,
	last_name VARCHAR (255) NOT NULL,
	manager_id INT,
	FOREIGN KEY (manager_id) 
	REFERENCES employee (employee_id) 
	ON DELETE CASCADE
);
INSERT INTO employee (
	employee_id,
	first_name,
	last_name,
	manager_id
)
VALUES
	(1, 'Windy', 'Hays', NULL),
	(2, 'Ava', 'Christensen', 1),
	(3, 'Hassan', 'Conner', 1),
	(4, 'Anna', 'Reeves', 2),
	(5, 'Sau', 'Norman', 2),
	(6, 'Kelsie', 'Hays', 3),
	(7, 'Tory', 'Goff', 3),
	(8, 'Salley', 'Lester', 3);

SELECT e.first_name || ' ' || e.last_name AS employee,
       m.first_name || ' ' || m.last_name AS manager
FROM employee e 
LEFT JOIN employee m ON m.employee_id = e.manager_id
ORDER BY manager

-- USING & NATURAL JOIN синтаксический сахар --
-- INNER JOIN = JOIN --
-- Идентичные запросы --
SELECT contact_name, company_name, phone, first_name, last_name, title,
       order_date, product_name, ship_country, products.unit_price, quantity, discount
FROM orders
JOIN order_details ON orders.order_id = order_details. order_id
JOIN products ON order_details.product_id = products.product_id
JOIN customers ON orders.customer_id = customers.customer_id
JOIN employees ON orders.employee_id = employees.employee_id
WHERE ship_country = 'USA';

SELECT contact_name, company_name, phone, first_name, last_name, title,
       order_date, product_name, ship_country, products.unit_price, quantity, discount
FROM orders
JOIN order_details USING(order_id)
JOIN products USING(product_id)
JOIN customers USING(customer_id)
JOIN employees USING(employee_id)
WHERE ship_country = 'USA'

-- NATURAL JOIN -- 
-- Лучше не использовать, тк соединяет по всем столбцам неявно --
SELECT order_id, customer_id, first_name, last_name, title
FROM orders
NATURAL JOIN employees

-- AS псевдонимы --

SELECT COUNT(*) AS employees_count
FROM employees

SELECT category_id, SUM(units_in_stock) AS units_in_stock
FROM products
GROUP BY category_id
ORDER BY units_in_stock DESC
LIMIT 5

SELECT category_id, SUM(unit_price * units_in_stock) AS total_price
FROM products
WHERE discontinued <> 1
GROUP BY category_id
HAVING SUM(unit_price * units_in_stock) > 10000 --здесь пишем в постфильтр еще раз SUM... псевдоним работать не будет (total_price)
ORDER BY total_price DESC



