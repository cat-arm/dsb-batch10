## load libraries
library(tidyverse)
library(glue)
library(RSQLite)

## glue => string template
name <- "toy"
age <- 35

glue("Hello my name is {name}, and I'm {age} years old.")

## connect sqlite database
## create connection
con <- dbConnect(SQLite(), "chinook.db")

## how many tables
dbListTables(con)

## check column names in a table
dbListFields(con, "customers")

## get data from a table
usa_customers <- dbGetQuery(con, "
           SELECT 
             firstname,
             lastname,
             country,
             email
           FROM customers
           WHERE country = 'USA'
           ")

usa_customers

dbListTables(con)

## write table into a database
branches <- data.frame(
  branch_id = 1:3,
  branch_name = c("BKK", "LON", "SEOUL")
)

dbWriteTable(con, "branches", branches)

## remove table
dbRemoveTable(con, "branches")

## dbDisconnect()
dbDisconnect(con)
