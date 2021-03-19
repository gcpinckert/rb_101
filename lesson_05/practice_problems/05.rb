# Using the given nested hash
# Find out the total age of just the male members of the family

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

# Option 1

# Iterate through outer hash, for each entry
  # Select only those inner hashes whose gender value is male
  # Initialize sum variable
  # Iterate through the new hash of only male family members
    # Add each age to the sum variable
# Return sum

def find_total_male_age(hash)
  guys = hash.select { |__, details| details["gender"] == "male" }
  total_age = 0
  guys.each { |__, details| total_age += details["age"] }

  total_age
end

puts find_total_male_age(munsters) # == 444

# Option 2

# Initialize an empty array
# Iterate through each entry of outer hash, for each sub-hash
  # If the value associated with gender is male
    # Select the value associated with 'age' and add it to the ages array
# Sum the ages array
# Return the sum

def find_sum_male_age(nested_hash)
  ages = []
  nested_hash.each do |__, details|
    if details["gender"] == "male"
      ages << details["age"]
    end
  end

  ages.sum
end

puts find_sum_male_age(munsters) # == 444