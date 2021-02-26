# - Print 5 random numbers between 0 and 99
# - Use a while loop
# Example Output:
# => 62
# => 55
# => 32
# => 97
# => 12

# - Set empty array to hold randomly generated numbers
# - While the size of the array is less than 5
#   - Generate random number
#   - Add to numbers array
# - Print numbers to screen, each on a new line

numbers = []

while numbers.size < 5
  numbers << rand(0..99)
end

puts numbers