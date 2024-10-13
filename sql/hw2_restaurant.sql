/*
  create at least 3 tables insert data in: restaurant
  - transactions
  - staff
  - menu
  - ingredient 
  - ...
  write sql queries at least 3 queries
  - with clause
  - sub query
  - aggregate fucntion & group by
  - where ..
*/
CREATE TABLE staff (
  staff_id int,
  name char(60),
  salary int
);

CREATE TABLE menu (
  menu_id int,
  name char(60),
  price int
);

CREATE TABLE ingredient (
  ingredient_id int,
  name char(60),
  price int
);

CREATE TABLE menu_ingredient (
  menu_id int,
  ingredient_id int
);

CREATE TABLE transactions (
  transaction_id int,
  invoice_date date,
  staff_id int,
  menu_id int
);

INSERT INTO staff values
  (1, 'arm', 35000),
  (2, 'jane', 30000),
  (3, 'jim', 40000);

INSERT INTO menu values
  (1, 'Tom Yum Kung', 320),
  (2, 'Spicy Shrimp', 240),
  (3, 'Pork Galic', 200),
  (4, 'Omelette with Minced Pork', 160);

INSERT INTO ingredient values
  (1, 'Shrimp', 150),
  (2, 'Chili', 20),
  (3, 'Garlic', 40),
  (4, 'Monosodium Glutamate', 60),
  (5, 'Pork', 60),
  (6, 'Egg', 30),
  (7, 'Rice', 20);

INSERT INTO menu_ingredient values
  (1, 1),
  (1, 2),
  (1, 4),
  (1, 7),
  (2, 1),
  (2, 2),
  (2, 7),
  (3, 4),
  (3, 5),
  (3, 7),
  (4, 5),
  (4, 6),
  (4, 7);

INSERT INTO transactions VALUES
(1, '2023-06-01', 1, 1),
(2, '2023-06-01', 2, 2),
(3, '2023-06-02', 3, 3),
(4, '2023-06-02', 1, 4),
(5, '2023-06-03', 2, 1),
(6, '2023-06-03', 3, 2),
(7, '2023-06-04', 1, 3),
(8, '2023-06-04', 2, 4),
(9, '2023-06-05', 3, 1),
(10, '2023-06-05', 1, 2);

-- profit from all transactions 

.mode table
.header on

SELECT * FROM staff;
SELECT * FROM menu;
SELECT * FROM ingredient;
SELECT * FROM menu_ingredient;
SELECT * FROM transactions;

-- find price and cost per menu
SELECT
  m.name AS menu_name,
  m.price AS menu_price,
  SUM(i.price) AS cost,
  m.price - SUM(i.price) AS profit
FROM
  menu m
JOIN menu_ingredient mi On m.menu_id = mi.menu_id
JOIN ingredient i ON mi.ingredient_id = i.ingredient_id
GROUP BY 1;

-- find profit per transaction
WITH profit_per_menu AS (
  SELECT
    m.menu_id,
    m.name AS menu_name,
    m.price AS menu_price,
    SUM(i.price) AS cost,
    m.price - SUM(i.price) AS profit
  FROM
    menu m
  JOIN menu_ingredient mi ON m.menu_id = mi.menu_id
  JOIN ingredient i ON mi.ingredient_id = i.ingredient_id
  GROUP BY 2
)

SELECT
  t.invoice_date,
  ppm.menu_name,
  ppm.menu_price - ppm.cost AS profit
FROM transactions AS t
JOIN profit_per_menu AS ppm ON t.menu_id = ppm.menu_id
ORDER BY 1;

-- find total Profit
WITH profit_per_transactions AS (
  WITH profit_per_menu AS (
    SELECT
      m.menu_id,
      m.name AS menu_name,
      m.price AS menu_price,
      SUM(i.price) AS cost,
      m.price - SUM(i.price) AS profit
    FROM
      menu m
    JOIN menu_ingredient mi ON m.menu_id = mi.menu_id
    JOIN ingredient i ON mi.ingredient_id = i.ingredient_id
    GROUP BY 2
  )

  SELECT
    t.invoice_date,
    ppm.menu_name,
    ppm.menu_price - ppm.cost AS profit
  FROM transactions AS t
  JOIN profit_per_menu AS ppm ON t.menu_id = ppm.menu_id
  ORDER BY 1
)

SELECT SUM(profit) AS total_profit FROM profit_per_transactions;
