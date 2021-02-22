# Given is a basic Fibonacci calculator
# Input = 2 numbers (integers?)
# Calculate computes the next numbers in the sequence until a limit 
# The given code results in an error. What's wrong?

=begin
Given Code:

limit = 15

def fib(first_num, second_num)
  while first_num + second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1)
puts "result is #{result}"
=end

# The code above results in an error because the fib method cannot access
# the local variable limit from within the method (it is out of scope). Thus
# the program throws a NameError when we get to line 12 above. We will either
# have to set limit as a constant (thus giving it global scope), or pass it in
# as an argument along with first_num and second_num

limit = 15

def fib(first_num, second_num, limit)
  while first_num + second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, limit)
puts "result is #{result}"