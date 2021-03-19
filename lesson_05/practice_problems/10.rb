# Using the given data structure:
  # Use the map method to return a new array identical in structure
  # The value of each integer should be incremented by 1
  # Do not modify the original array

# Iterate through the array, for each inner hash
  # Iterate though the key-value pairs, for each one
    # Increment the value + 1

arr =  [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

arr2 =  arr.map do |hash|
          incremented_hash = {}
          hash.each { |key, value| incremented_hash[key] = value + 1 }
          incremented_hash
        end

p arr
p arr2
