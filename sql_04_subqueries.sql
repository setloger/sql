-- 1 subqueries --
SELECT company_name
FROM suppliers
WHERE country IN (SELECT DISTINCT country
                  FROM customers)
ORDER BY suppliers.company_name ASC;
--Такой же результат, только через JOIN --
SELECT DISTINCT suppliers.company_name
FROM suppliers
JOIN customers USING(country)
ORDER BY suppliers.company_name ASC

SELECT category_name, SUM(units_in_stock)
FROM products
INNER JOIN categories USING(category_id)
GROUP BY category_name
ORDER BY SUM(units_in_stock) DESC
LIMIT (SELECT MIN(product_id)) + 4 FROM products)

SELECT product_name, units_in_stock
FROM products
WHERE units_in_stock > (SELECT AVG(units_in_stock)
                        FROM products)
ORDER BY units_in_stock

-- 2 WHERE EXSISTS --

SELECT company_name, contact_name
FROM customers
WHERE EXISTS (SELECT customer_id FROM orders
               WHERE customer_id = customers.customer_id
               AND freight BETWEEN 50 AND 100)

SELECT company_name, contact_name
FROM customers
WHERE NOT EXISTS (SELECT customer_id FROM orders
                  WHERE customer_id = customers.customer_id
                  AND order_date BETWEEN '19995-02-01' AND '1995-02-15')

-- 3 subqueries with ANY, ALL (квантификаторы) -- 

SELECT DISTINCT company_name
FROM customers
JOIN orders USING(customer_id)
JOIN order_details USING(order_id)
WHERE quantity > 40

--Такой же результат, только через JOIN --

SELECT DISTINCT company_name
FROM customers
WHERE customer_id = ANY(
    SELECT customer_id
    FROM orders
    JOIN order_details USING(order_id)
    WHERE quantity > 40
)

SELECT DISTINCT product_name, quantity
FROM products
JOIN order_details USING(product_id)
WHERE quantity > (
    SELECT AVG(quantity)
    FROM order_details
)
ORDER BY quantity

-- позапрос --
SELECT AVG(quantity)
FROM order_details
GROUP BY product_id

SELECT DISTINCT product_name, quantity
FROM products
JOIN order_details USING(product_id)
WHERE quantity > ALL (SELECT AVG(quantity)
                      FROM order_details
                      GROUP BY product_id)
ORDER BY quantity