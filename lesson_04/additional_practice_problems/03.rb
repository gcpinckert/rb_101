# Remove those with an age of 100 and greater from the given hash

# Input: hash
# Output: original hash, only key value pairs whose value < 100

# Iterate through hash, for each key-value pair
#   If value is >= 100
#     Remove that key value pair
# Return original hash (mutate the caller)

# Solution 1: returns `nil` if no changes are made

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages.reject! { |name, age| age >= 100 }
p ages

# Solution 2: returns `nil` if no changes are made

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages.select! { |name, age| age < 100 }
p ages

# Solution 3: returns calling hash even if no changes are made

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

ages.keep_if { |name, age| age < 100 }
p ages