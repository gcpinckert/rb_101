# - Given the array of several numbers
# - Print each number
# - Use an until loop

# Input: array of numbers
# Output: Each number in the array printed on a separate line
# Example Output:
# 7
# 9
# 13
# 25
# 18

# - Until the given array is empty
#   - Remove the first element in the array
#   - Print that element to the console

numbers = [7, 9, 13, 25, 18]

until numbers.size == 0
  puts numbers.slice!(0)
end