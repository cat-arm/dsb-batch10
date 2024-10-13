pizza <- function() {
  print("Hello welcome to pizzeria restaurant!")

  ## present menu to a user
  my_bill <- 0
  menu <- data.frame(id=1:5,
                     name=c("margherita", "pepperoni", "hawaiian", "Vegetarian", "seafood"),
                     price=c(200,250,200,300,400))
  drink <- data.frame(id=1:3,
                     name=c("orange", "watermelon", "pepsi"),
                     price=c(80,150,30))
  print("Our Pizza")
  print(paste(menu$name, "price", menu$price, "Bath", sep = " "))
  print("Our Drink")
  print(paste(drink$name, "price", drink$price, "Bath", sep = " "))

  ## let them choose a menu
  my_pizza <- tolower(trimws(readline("Choose your pizza: ")))
  while (!(my_pizza %in% menu$name)) {
    my_pizza <- tolower(trimws(readline("Choose your pizza: ")))
  }
  my_pizza_price <- menu$price[menu$name == my_pizza]
  print(paste("Your pizza is", my_pizza, "price", my_pizza_price, "Bath", sep = " "))

  ## let them choose a drink
  my_drink <- tolower(trimws(readline("Choose your drink: ")))
  while (!(my_drink %in% drink$name)) {
    my_pizza <- tolower(trimws(readline("Choose your drink: ")))
  }
  my_drink_price <- drink$price[drink$name == my_drink]
  print(paste("Your drink is", my_drink, "price", my_drink_price, "Bath", sep = " "))

  ## bonus - check bill
  my_bill = my_pizza_price + my_drink_price
  print(paste("Your bill is", my_bill, "Bath", sep = " "))
}
