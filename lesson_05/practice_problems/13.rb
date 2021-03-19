# Using the given data structure
  # Return a new array containing the same sub-arrays
  # the sub-arrays should be ordered logically
  # order only takes the odd numbers into account.

# Example:
  # arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]
  #    => [[1, 8, 3], [1, 6, 7], [1, 4, 9]]

# Iterate through the top level array, for each sub-array
  # Iterate through elements in sub-array
  # Select only odd integers
  # Return the sub-array with only odd numbers
# Sort based on above return value

arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]

sorted = arr.sort_by do |sub_array|
          sub_array.select { |num| num.odd? }
        end

p sorted == [[1, 8, 3], [1, 6, 7], [1, 4, 9]]
