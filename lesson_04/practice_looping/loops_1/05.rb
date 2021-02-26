# - Modify the given code so 'Hello!' is printed 5 times

# Input: boolean
# Expected Output:
# => "Hello!"
# => "Hello!"
# => "Hello!"
# => "Hello!"
# => "Hello!"

# - Set boolean to true
# - Set counter variable to 0
# - While boolean is true
#   - Print the desired message
#   - Increment counter variable
#   - If counter is greater than or equal to 5
#     - Set boolean to false

say_hello = true
counter = 0

while say_hello
  counter += 1
  puts 'Hello!'
  if counter >= 5
    say_hello = false
  end
end