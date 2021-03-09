# Pick out the minimum age from the given hash

# Input: hash
# Output: integer, minimum value from hash

# Solution 1:

# Extract all values from given hash into an array
# Find minimum value in array
# Return that value

ages = { "Herman" => 32, 
  "Lily" => 30, 
  "Grandpa" => 5843, 
  "Eddie" => 10, 
  "Marilyn" => 22, 
  "Spot" => 237 }

puts ages.values.min
