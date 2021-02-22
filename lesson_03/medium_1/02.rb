# What is the error in the given code?
# Give two possible ways to fix it.
# Given code:
  # puts "the value of 40 + 2 is " + (40 + 2)

# The issue here is that the right expression (40 + 2) leaves us with
# an operand that is an integer, which we then try to concatenate with a
# string. This is not possible, so the program throws an error. To get 
# the program to work, we will have to convert our right operand into a
# string, once the expression is evaluated. 

puts "the value of 40 + 2 is " + (40 + 2).to_s

# Here we explicitly convert the integer expression to a string

puts "the value of 40 + 2 is #{40 + 2}"

# Here we use the implicit conversion in string interpolation
