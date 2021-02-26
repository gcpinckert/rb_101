# - Modify the given code
# - Add the user's input to the `numbers` array
# - Stop the loop when the array contains 5 numbers

# Input: 5 numbers, entered by user
# Output: array of all numbers entered by user, no more or less than 5

numbers = []

loop do
  puts 'Enter any number:'
  input = gets.chomp.to_i

  numbers << input
  break if numbers.size >= 5
end

puts numbers
