# Using the given data structure:
  # Return a new array of the same structure
  # The sub arrays should be ordered in descending order
  # Order alphabetically or numerically as appropriate

# Iterate through top level array, for each sub-array
  # Sort in descending order

arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

def sort_subs_in_reverse(arr)
  arr.map do |sub_array|
    sub_array.sort { |a, b| b <=> a }
  end
end

p sort_subs_in_reverse(arr)
