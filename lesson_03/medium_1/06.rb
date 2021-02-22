# What is the output of the given code?

answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)

p answer - 8

# The code will output 34. Because answer is reassigned within the method
# mess_with_it when it is passed in as "some_number", and reassignment is
# never mutating, answer will retain it's original value of 42 outside the
# method.