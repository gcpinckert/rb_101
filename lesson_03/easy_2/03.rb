# Add the given values to the given hash

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
additional_ages = { "Marilyn" => 22, "Spot" => 237 }

# Using Hash#[]

ages["Marilyn"] = 22
ages["Spot"] = 237

p ages

# Using Hash#merge!

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }

ages.merge!(additional_ages)

p ages
