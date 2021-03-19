# Using the given data structure
  # Return a new array
  # The array should contain only those hashes where ALL the integers are even

# Example:
  # arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]
  # => [{e: [8], f: [6, 10]}]

# Iterate through the top level array, for each inner hash
  # Select only those hashes where all integers are even
    # Iterate through array of hash values, for each value array
      # Are all int elements even?
# Return new array

arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

def even_ints_hash(arr_of_hshs)
  arr_of_hshs.select do |inner_hsh|
    inner_hsh.all? do |__, inner_arr| 
      inner_arr.all? { |num| num.even? }
    end
  end
end

puts even_ints_hash(arr) == [{e: [8], f: [6, 10]}]
