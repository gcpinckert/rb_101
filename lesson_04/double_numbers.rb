# - Create a method called `double_numbers!` 
# - The method should transform an array of numbers by doubling each number
# - The method should mutate the calling array, and return self

# Input: array of numbers
# Output: same array of numbers, with each element doubled

# - Iterate through input array
# - For each element in array:
#   - element = element * 2
# - Return array

def double_numbers!(nums)
  counter = 0

  loop do
    break if counter >= nums.size
    nums[counter] *= 2

    counter += 1
  end

  nums
end

my_numbers = [1, 4, 3, 7, 2, 6]
puts "Array before the method: #{my_numbers}"

double_numbers!(my_numbers) # => [2, 8, 6, 14, 4, 12]
puts "Array after the method #{my_numbers}"

