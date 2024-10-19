## homework
## 1. review methods (list, string) อย่างละ 5 อัน
## 2. create this functionL pao ying chub

# 1. review methods (list, string) อย่างละ 5 อัน
# list method
number1 = [2,33,3,2,1,56,44,8,101,55,3,0]
number2 = [99,56,88,22,1,44,66,88,99]

# .append use for append element in end of list
number1.append(99)
print(number1)

# .extend use for extend list with another list in the end
number1.extend(number2)
print(number1)

#.sort use for sort data --> reverse=True is desc
number1.sort(reverse=True)
print(number1)

# .count use for count how many specific element in list
count = number1.count(99)
print(count)

# .clear use for clear all data in list
number1.clear()
print(number1)

# string method
# .zfill add number of 0 in front off string
txt = "33"
new_txt = txt.zfill(10)
print(new_txt)

# .strip() use for trim all space in the left and right side out
text = "     oho     "
new_text = text.strip()
print(new_text)

# .rjust can specific length of string and can set the value of the rest of the length rjust is text inm the right side
text = "hen"
new_text = text.rjust(10,"0")
print(new_text)

# .find use for find what's index of the string in the main string 
txt = "Hello, welcome to my world."
x = txt.find("welcome")
print(x)

# .encode use for encode string default is utf-8
txt = "My name is Arm"
x = txt.encode()
print(x)

# 2. create this functionL pao ying chub

from random import choice

def pao_ying_chub():
    print("Let's play game!")
    print("Win at least 6 form 10 rounds!")

    hands = ["hammer", "scissor", "paper"]
    user_point = 0
    comp_point= 0
    totals_round = 10
    round = 1
    while round <= 10:
        print(f"Start round {round}")
        computer_hand = choice(hands)

        user_hand = input("Please choose your hand: [hammer, scissor, paper]\nYour hand: ").lower()
        while user_hand not in hands:
            user_hand = input("Invalid hand! Please choose again: [hammer, scissor, paper]\nYour hand: ").lower()

        print(f"Comp hand: {computer_hand}")
        round += 1
        
        if ((user_hand == "hammer" and computer_hand == "scissor") or (user_hand == "scissor" and computer_hand == "paper") or (user_hand == "paper" and computer_hand == "hammer")):
            user_point += 1
            comp_point == 0
            print(f"You win: your point is {user_point}")
        elif ((user_hand == "scissor" and computer_hand == "hammer") or (user_hand == "paper" and computer_hand == "scissor") or (user_hand == "hammer" and computer_hand == "paper")):
            user_point += 0
            comp_point += 1
            print(f"You lose: your point is {user_point}")
        else:
            user_point += 0
            comp_point += 0
            print(f"You draw: your point is {user_point}")

    print("End game")
    if (user_point > comp_point):
        print("You win this game")
    elif(user_point < comp_point):
        print("You lose this game")
    else:
        print("You tie this game")

pao_ying_chub()
