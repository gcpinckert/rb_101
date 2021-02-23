# Write a simple method to determine if a string is an IP address
# IP address = dot-separated numbers like 10.4.5.11
# Supplied method is_an_ip_number?
  # true if string is numeric between 0 and 255
# Use the given code, which has problems
  # Not returning a false condition
  # handle the case if there are more or fewer than 4 components
    # i.e. 4.5.5 or 1.2.3.4.5 should be invalid

# Given Code:
# def dot_separated_ip_address?(input_string)
#   dot_separated_words = input_string.split(".")
#   return false unless dot_separated_words.size == 4

#   while dot_separated_words.size > 0 do
#     word = dot_separated_words.pop
#     return false unless is_an_ip_number?(word)
#   end

#   true
# end

# input = string
# output = expression that evaluates to true / false (?)

# take input string and create an array 
# each element of array the string chars between each .
# create new array of each element that meats criteria of is_an_ip_num
# check to see if length of new array is 4

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  dot_separated_words.select { |word| is_an_ip_number?(word) }
  dot_separated_words.size == 4
end