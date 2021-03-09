# Turn the given array into a hash:
#   - Each hash key should be a name from the given array
#   - Each hash value should be the index of the name from the array

# Questions:
#   - Do we need to modify the original calling array?
#   - (is this even possible?)

# Input: array
# Output: hash, keys are array elements, values are element's index

# Set new empty hash
# Iterate through given array, for each element:
#   Set element value to current hash key
#   Set element index to current hash value
# Return hash

# Solution 1:
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
names_positions = {}

flintstones.each_with_index do |name, index|
  names_positions[name] = index # note: permanently modifies names_positions
end
# note: each_with_index returns original flintstones array

p names_positions

# Solution 2: returns the created hash object
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
counter = -1

hash = flintstones.to_h do |name|
        counter += 1
        [name, counter]
      end

p hash

# Solution 3: returns the created hash object
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
counter = -1

hash = flintstones.each_with_object({}) do |name, hash|
  counter += 1
  hash[name] = counter
end

p hash