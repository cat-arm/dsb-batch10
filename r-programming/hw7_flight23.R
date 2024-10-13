library(tidyverse)
library(nycflights23)

# List all objects in the package
objects <- ls("package:nycflights23")
# Display the objects
objects

## preview data each table
head(airlines)
head(airports)
head(flights)
head(planes)
head(weather)

## manual of each table
?airlines
?airports
?flights
?planes
?weather

# first query
# how many Fixed case for each manufacture of airplane
planes %>%
  group_by(manufacturer) %>%
  summarize(fixed_case = n()) %>%
  arrange(desc(fixed_case))

# second query
# list of airlines which has the most average department delay 
flights %>%
  left_join(airlines, by = "carrier") %>%
  filter(dep_delay > 0 | arr_delay > 0) %>%
  group_by(carrier, name) %>%
  summarize(
    num_flights = n(),
    total_minute_dep_delay = sum(dep_delay, na.rm = TRUE),
    total_minute_arr_delay = sum(arr_delay, na.rm = TRUE)
  ) %>%
  mutate(
    avg_minute_dep_delay = total_minute_dep_delay / num_flights,
    avg_minute_arr_delay = total_minute_arr_delay / num_flights
  ) %>%
  arrange(desc(avg_minute_dep_delay))

## third query
## top 10 destination airports
flights %>%
  group_by(dest) %>% 
  summarize(num_flights = n()) %>%
  left_join(airports, by = c("dest" = "faa")) %>% 
  arrange(desc(num_flights))%>%
  slice_head(n = 10)

## forth
## find the airport which origin has visibility < 1 mile
weather %>%
  filter(visib < 1) %>%
  group_by(origin) %>%
  summarize(count_visib_gt_2 = n()) %>%
  left_join(airports, by = c("origin" = "faa")) %>%
  select(origin, name, count_visib_gt_2)

## fifth
## find total flights, total delayed flight from departure, total distance, unique airport when arrive 
flights %>%
  mutate(quarter = case_when(
    month %in% c(1, 2, 3) ~ "Q1",
    month %in% c(4, 5, 6) ~ "Q2",
    month %in% c(7, 8, 9) ~ "Q3",
    month %in% c(10, 11, 12) ~ "Q4"
  )) %>%
  group_by(year, quarter) %>%
  summarize(
    total_flights = n(),
    delayed_flights = sum(dep_delay > 0, na.rm = TRUE),
    total_distance = sum(distance, na.rm = TRUE),
    unique_dest_airports = n_distinct(dest)
  ) %>%
  arrange(year, quarter)
