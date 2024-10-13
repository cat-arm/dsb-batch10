play_game <- function() {
  hands <- c("hammer", "scissor", "paper")
  game <- 0
  user_point <- 0
  comp_point <- 0
  while (game < 10) {
    comp_hand <- sample(hands,1)
    user_hand <- tolower(readline("Choose your hand: "))
    if (user_hand == "quit") {
      print("You Quit This Game")
      break
    }
    while (user_hand != "hammer" && 
           user_hand != "scissor" && 
           user_hand != "paper") {
      user_hand <- tolower(readline("Choose your hand: "))
    }
    if ((user_hand == "hammer" && comp_hand == "hammer") || 
        (user_hand == "scissor" && comp_hand == "scissor") ||
        (user_hand == "paper" && comp_hand == "paper")) {
      user_point = user_point + 0
      comp_point = comp_point + 0
      print(paste("You Use", user_hand, "Com use", 
                  comp_hand, "You Draw This Round", sep = " "))
    }
    else if ((user_hand == "hammer" && comp_hand == "scissor") || 
             (user_hand == "scissor" && comp_hand == "paper") || 
             (user_hand == "paper" && comp_hand == "hammer")) {
      user_point= user_point + 1
      comp_point = comp_point + 0
      print(paste("You Use", user_hand, "Com use", 
                  comp_hand, "You Win This Round", sep = " "))
    }
    else if ((user_hand == "hammer" && comp_hand == "paper") || 
             (user_hand == "scissor" && comp_hand == "hammer") || 
             (user_hand == "paper" && comp_hand == "scissor")) {
      user_point = user_point + 0
      comp_point = comp_point + 1
      print(paste("You Use", user_hand, "Com use", 
                  comp_hand, "You Lose This Round", sep = " "))
    }
    game = game + 1
  }
  if (user_point > comp_point && 
      user_hand != "quit") {
    print(paste("Your Point", user_point, "Com Point", 
                comp_point, "You Win This Game", sep = " "))
  }
  else if (user_point < comp_point && 
           user_hand != "quit") {
    print(paste("Your Point", user_point, "Com Point", 
                comp_point, "You Lose This Game", sep = " "))
  }
  else if (user_point == comp_point && 
           user_hand != "quit") {
    print(paste("Your Point", user_point, "Com Point", 
                comp_point, "You Draw This Game", sep = " "))
  }
}
