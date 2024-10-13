## Recap basic programming
## 1. variable x<-100
## 2. data types
## 3. data structure: vector, list, matrix, df
## 4. function ✅
## 5. control flow : if for while ✅

## create your own function

greeting <- function() {
  print("hello world")  
}

greeting_name <- function(name) {
  text <- paste0("Hello! ", name) 
  print(text)
}

## simple function
## default argument
add_two_num <- function(x=10, y=20) {
  return(x + y)
}

cube <- function(base, power=3) {
  base ** power
}

cube <- function(base, power=3) base**power

## function calls another function(s)
hi1 <- function() print("hi")
hi2 <- function() print("hi hi!")
hi3 <- function() print("hello!")

all_hi <- function() {
  hi1()
  hi2()
  hi3()
}

## control flow
## if for while


grading <- function(score) {
  if (score >= 80) {
    return("A")
  } else if (score >= 70) {
    return("B")
  } else if (score >= 60) {
    return("C")
  } else if (score >= 50) {
    return("D")
  } else {
    return("Failed")
  }
}

## for loop
## vectorization
nums <- c(25, 30, 40, 100, 1225)

for (i in nums) {
  if (i %% 2 == 0) {
    print(paste0(i, ":even number"))
  } else {
    print(paste0(i, ":odd number"))
  }
}

## while loop
count <- 0

while (count < 5) {
  print("ยังไม่ลืมแฟนเก่า")
  count = count + 1
  if (count == 5) {
    print("ลืมได้แล้วนะครับ")
  }
}

## take input from a user
## user input is character
user_name <- readline("what's your name: ")
user_pw <- readline("your password: ")

## Facebook Login Logic
users <- c("toy", "john", "mary")
pw <- 1234

fb_login <- function() {
  print("Welcome to facebook!")
  username <- readline("Username: ")
  password <- readline("Password: ")
  if ((username %in% users) & (password == pw)) {
    print("Log in successfully!")
  } else {
    print("Try again!")
  }
}

## homework
## 1. chatbot order pizza
pizza <- function() {
  print("Hello welcome to pizzeria restaurant!")
  ## present menu to a user
  ## let them choose a menu
  ## let them choose a drink
  ## bonus - check bill
}

## 2. pao ying chub
play_game <- function() {
  games <- 0
  while (games < 10) {
    ## pao ying chub
  }
}
