# - Create a method that doubles certain elements in the calling array
# - Only elements with an odd index should be doubled
# - The method should return a new array

# Input: array of numbers
# Output: new array, with elements that have odd indices doubled in value

# - Set new empty array
# - Iterate over elements in calling array
#   - If the current element has an odd index
#     - Double the value
#   - Add the current element to the new array
#   - Stop iterating when you get to the end of the calling array
# - Return the new array

def double_odd_index(numbers)
  doubled_numbers = []
  counter = 0

  loop do
    break if counter >= numbers.size
    current_number = numbers[counter]
    current_number *=2 if counter.odd?
    doubled_numbers << current_number
    counter += 1
  end

  doubled_numbers
end

my_numbers = [1, 4, 3, 7, 2, 6]

puts double_odd_index(my_numbers)
# => [1, 8, 3, 14, 2, 12]