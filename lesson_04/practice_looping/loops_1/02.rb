# - The given code is an example of a nested loop
# - Both loops are infinite loops
# - Modify the code so each loop stops after the first iteration

# Example Output:
# => 'This is the outer loop.'
# => 'This is the inner loop.'
# => 'This is outside all loops.'

loop do
  puts 'This is the outer loop.'

  loop do
    puts 'This is the inner loop.'
    break
  end
  break
end

puts 'This is outside all loops.'