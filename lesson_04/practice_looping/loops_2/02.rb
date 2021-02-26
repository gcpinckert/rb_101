# - Make the loop stop if `number` is equal to or between 0 and 10

loop do
  number = rand(100)
  puts number
  break if (0..10).include?(number)
end