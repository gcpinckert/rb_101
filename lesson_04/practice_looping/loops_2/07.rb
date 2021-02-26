# - Modify the code so that it prints the current number
# - It should stop iterating when the current number is 2

5.times do |index|
  puts index
  break if index == 2
end