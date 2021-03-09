# Add up all of the ages (values) in the given hash

# Input: hash
# Output: integer, sum of hash values

# Solution 1:

# Extract all hash values into an array
# Sum the array

ages = { "Herman" => 32, 
         "Lily" => 30, 
         "Grandpa" => 5843, 
         "Eddie" => 10, 
         "Marilyn" => 22, 
         "Spot" => 237 }

puts ages.values.sum

# Solution 2:

# Set an ages_sum variable to 0
# Iterate through the hash
#   Add each value to the ages_sum variable
# Return the sum

ages = { "Herman" => 32, 
  "Lily" => 30, 
  "Grandpa" => 5843, 
  "Eddie" => 10, 
  "Marilyn" => 22, 
  "Spot" => 237 }
ages_sum = 0

ages.each do |__, age|
  ages_sum += age
end

puts ages_sum
