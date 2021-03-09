# Using the given hash
# Add an additional "age_group" key to each member of the Munster family
# It should have one of three values describing the age group
#  - kid = ages 0-17
#  - adult = ages 18-64
#  - senior = 65+

# Example Output:
# { "Herman" => { "age" => 32, "gender" => "male", "age_group" => "adult" },
#   "Lily" => {"age" => 30, "gender" => "female", "age_group" => "adult" },
#   "Grandpa" => { "age" => 402, "gender" => "male", "age_group" => "senior" },
#   "Eddie" => { "age" => 10, "gender" => "male", "age_group" => "kid" },
#   "Marilyn" => { "age" => 23, "gender" => "female", "age_group" => "adult" } }

# Solution 1: if statements with conditionals
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |munster, facts|
  if facts["age"] > 0 && facts["age"] < 18
    facts["age_group"] = "kid"
  elsif facts["age"] > 17 && facts["age"] < 65
    facts["age_group"] = "adult"
  else
    facts["age_group"] = "senior"
  end
end

p munsters

# Solution 2: case statement with ranges
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |munster, facts|
  case facts["age"]
  when 0..17 then  facts["age_group"] = "kid"
  when 18..64 then facts["age_group"] = "adult"
  else             facts["age_group"] = "senior"
  end
end

p munsters