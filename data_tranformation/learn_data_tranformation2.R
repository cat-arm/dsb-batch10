library(tidyverse)
## dplyr + ggplot

mtcars
df <- tibble(mtcars)

df <- mtcars %>%
  rownames_to_column(var="model") %>%
  tibble()

## random sample
set.seed(15)
df %>%
  sample_n((3))

df %>%
  sample_frac(0.2)

df %>%
  select(model, am) %>%
  mutate(am = ifelse(am==0, "Auto", "Manual")) %>%
  count(am) %>%
  mutate(pct = n / sum(n))

## distinct
model_names <- df %>%
  select(model, am) %>%
  mutate(am = ifelse(am==0, "Auto", "Manual")) %>%
  distinct(model) %>%
  pull()


## join tables

## SQL joins
## inner, left, right, full(outer)

## inner join
band_members %>%
  inner_join(band_instruments, by = "name")

## left join
band_members %>%
  left_join(band_instruments, by = "name")

## right join
band_members %>%
  right_join(band_instruments, by = "name")

## full join
band_members %>%
  full_join(band_instruments, by = "name") %>%
  drop_na()

## replace NA
band_members %>%
  full_join(band_instruments, by = "name") %>%
  mutate(plays = replace_na(plays, "drum"),
         band = replace_na(band, "Aerosmith"))

## union data (like SQL)
df1 <- data.frame(id=1:3,
                  name=c("toy","john","mary"))

df2 <- data.frame(id=3:5,
                  name=c("mary","anna", "david"))

df3 <- data.frame(id=6:8,
                  name=c("a","b","c"))

df4 <- data.frame(id=9:10,
                  name=c("d","e"))

bind_rows(df1, df2)

df1 %>%
  bind_rows(df2) %>%
  bind_rows(df3) %>%
  bind_rows(df4) %>%
  distinct()

list_df <- list(df1, df2, df3, df4)

list_df %>%
  bind_rows() %>%
  distinct()


library(tidyverse) ## ggplot2

qplot(mpg, data=mtcars, geom="histogram", bins=10)

qplot(mpg, data=mtcars, geom="density")

qplot(x=hp, y=mpg, data=mtcars, geom="point")
