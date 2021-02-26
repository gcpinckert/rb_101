# - Create a method called `multiply`
# - That takes as arguments: an array of numbers and an integer
# - Return a new array of each element multiplied by the integer

# Input: array of numbers and an integer
# Output: new array of each number multiplied by integer

# - Set new empty array multiplied_numbers
# - Iterate through array elements
#   - Multiply each element by the integer input
#   - Add each element to the array multiplied_numbers
# - Return multiplied_numbers array

def multiply(nums, factor)
  multiplied_nums = []

  for num in nums
    num *= factor
    multiplied_nums << num
  end

  multiplied_nums
end

my_numbers = [1, 4, 3, 7, 2, 6]
p multiply(my_numbers, 3) # => [3, 12, 9, 21, 6, 18]