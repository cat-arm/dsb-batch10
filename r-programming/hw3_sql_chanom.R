# load libraries
library(tidyverse)
library(RSQLite)

## create a new database
## homework 03 - create a new restaurant.db

con <- dbConnect(SQLite(), "chanom.db")

dbListTables(con)

# Write the 'menus' table to the database
dbWriteTable(con, "menus", 
             data.frame(id=1:5,
                        name=c("Milk tea", "Green tea", "Coffee", "Matcha", "Chocolate"),
                        price=c(120, 100, 150, 200, 250)),
             overwrite=TRUE)

# Write the 'employees' table to the database
dbWriteTable(con, "employees",
             data.frame(id=1:3,
                        name=c("Nai A", "Nai B", "Nai C"),
                        salary_per_hour=c(30, 27, 25),
                        work_hour_per_day=c(4, 3, 8)),
             overwrite=TRUE)

# Write the 'transactions' table to the database
dbWriteTable(con, "transactions",
             data.frame(id=1:5,
                        sales=c(1, 3, 3, 2, 1)),
             overwrite=TRUE)

# Write the 'transaction_menu' table to the database
dbWriteTable(con, "transaction_menu",
             data.frame(transaction_id=c(1, 1, 2, 2, 2, 3, 3, 3, 3, 4, 5, 5, 5, 5),
                        menu_id=c(1, 2, 1, 1, 3, 2, 4, 4, 4, 5, 1, 1, 2, 5)),
             overwrite=TRUE)


# Write the 'commission' table to the database
dbWriteTable(con, "commission",
             data.frame(id=1:2,
                        menu_id=c(4, 5),
                        special_paid=c(5,10)),
             overwrite=TRUE)

dbListTables(con)

# Query data from the all table
dbGetQuery(con, "SELECT * FROM menus")
dbGetQuery(con, "SELECT * FROM employees")
dbGetQuery(con, "SELECT * FROM transactions")
dbGetQuery(con, "SELECT * FROM transaction_menu")
dbGetQuery(con, "SELECT * FROM commission")

# Query data transaction detail
dbGetQuery(con, "
  SELECT 
    t.id AS transaction_id,
    e.name AS employee_name,
    m.name AS menu_name,
    m.price AS menu_price,
    COALESCE(c.special_paid, 0) AS commission
  FROM 
    transactions t
  JOIN 
    employees e ON t.sales = e.id
  JOIN 
    transaction_menu tm ON t.id = tm.transaction_id
  JOIN 
    menus m ON tm.menu_id = m.id
  LEFT JOIN 
    commission c ON m.id = c.menu_id;
")

# Query data employees cost per person
dbGetQuery(con, "
  SELECT 
    e.name AS employee_name,
    (e.salary_per_hour * e.work_hour_per_day) AS daily_salary,
    COALESCE(SUM(c.special_paid), 0) AS total_commission,
    (e.salary_per_hour * e.work_hour_per_day) + COALESCE(SUM(c.special_paid), 0) AS total_payment,
    COALESCE(SUM(m.price), 0) AS total_sales
  FROM 
    transactions t
  JOIN 
    employees e ON t.sales = e.id
  JOIN 
    transaction_menu tm ON t.id = tm.transaction_id
  JOIN 
    menus m ON tm.menu_id = m.id
  LEFT JOIN 
    commission c ON m.id = c.menu_id
  GROUP BY 
    e.id;
")

# Query data total sales
total_product_sales_result <- dbGetQuery(con, "
  SELECT 
    SUM(m.price) AS total_sales
  FROM 
    transactions t
  JOIN 
    transaction_menu tm ON t.id = tm.transaction_id
  JOIN 
    menus m ON tm.menu_id = m.id;
")

# Query data total cost
total_product_cost_result <- dbGetQuery(con, "
  SELECT 
    SUM(m.price * 0.60) AS total_product_cost
  FROM 
    transactions t
  JOIN 
    transaction_menu tm ON t.id = tm.transaction_id
  JOIN 
    menus m ON tm.menu_id = m.id;
")

# Query total salary cost
total_salary_cost_result <- dbGetQuery(con, "
  SELECT 
    SUM(e.salary_per_hour * e.work_hour_per_day) AS total_salary_cost
  FROM 
    transactions t
  JOIN 
    employees e ON t.sales = e.id
  GROUP BY 
    e.id;
")

# Calculate profit
total_product_sales <- total_product_sales_result$total_sales
total_product_cost <- total_product_cost_result$total_product_cost
total_salary_cost <- sum(total_salary_cost_result$total_salary_cost)
profit <- total_product_sales - total_product_cost - total_salary_cost

# Disconnect from the database
dbDisconnect(con)
