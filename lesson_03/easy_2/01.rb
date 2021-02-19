# See if "Spot" is present in the given hash

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }

# Option 1: without researching methods / docs:

# Iterate through hash keys
  # Compare each key to the string "Spot"
  # If the current key matches "Spot":
    # Return true
  # Otherwise, continue iterating through the hash
# If you get to the end of the hash:
  # Return false

def key_present?(hash, key_to_check)
  hash.each_key do |key|
    if key == key_to_check
      return true
    end
  end
  
  false
end

puts key_present?(ages, "Spot")

# Option 2: Use Hash#include? method

puts ages.include?("Spot")

# Note: #has_key? #key? and #member? are all aliases for #include?
