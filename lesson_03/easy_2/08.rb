# Shorten the given sentence by removing everything starting from "house"
# Using String#slice! make the shortened the return value the first part
# Leave advice = "house training your pet dinosaur"

advice = "Few things in life are as important as house training your pet dinosaur."

shortened_string = advice.slice!(0..38)

puts shortened_string
puts advice

# Bonus: String#slice is an alias for using [] index notation, it does not
# mutate the caller

advice = "Few things in life are as important as house training your pet dinosaur."

shortened_string = advice[0..38]
