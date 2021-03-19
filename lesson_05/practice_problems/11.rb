# Using the given data structure
  # Return a new array identical in structure to the original
  # It should contain only the integers that are multiples of 3
  # Use a combination of methods
  # Include either `select` or `reject`

# Iterate through the top level array, for each sub-array
  # Iterate through sub-array, for each element
    # Select only those integers that are evenly divisible by 3 

arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

arr2 =  arr.map do |sub_array|
          sub_array.select { |num| num % 3 == 0 }
        end

p arr
p arr2