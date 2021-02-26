# - The given code is an example of an infinite loop
# - Modify the code so the loop stops after the first iteration

# - Set a counter variable equal to 0
# - While the variable is less than 1
#   - Print the desired message
#   - Increment the counter variable by 1

counter = 0
loop do
  puts 'Just keep printing...'
  counter += 1
  break if counter > 0
end