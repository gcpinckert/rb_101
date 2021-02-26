# - Modify the given loop so it iterates 5 times instead of just once

# Example Output:
# => "Number of iterations = 1"
# => "Number of iterations = 2"
# => "Number of iterations = 3"
# => "Number of iterations = 4"
# => "Number of iterations = 5"

# - Set iterations variable equal to 1
# - While iterations is less than or equal to 5
#   - Print the desired message
#   - Increment the iterations variable

iterations = 1

loop do
  puts "Number of iterations = #{iterations}"
  iterations += 1
  break if iterations > 5
end