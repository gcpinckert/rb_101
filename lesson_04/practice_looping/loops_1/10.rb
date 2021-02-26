# - Given an array of names
# - Great each friend individually
# - Use a for loop

# Expected Output:
# Hello, Sarah!
# Hello, John!
# Hello, Hannah!
# Hello, Dave!

# - Input: array of names
# - Output: string, including the names in the array
# - Iterate through the `names` array
# - For each name in names
#   - Print the desired greeting

friends = ['Sarah', 'John', 'Hannah', 'Dave']

for friend in friends
  puts "Hello, #{friend}!"
end
