# - The given code increments number_a and number_b by either 0 or 1
# - Loop is used so the variables can be incremented more than once
# - Break stops the loop after the first iteration
# - Use next to modify the code
# - The loop should iterate until number_a or number_b is equal to 5
# - Print "5 was reached!" before breaking out of the loop

number_a = 0
number_b = 0

loop do
  number_a += rand(2)
  number_b += rand(2)

  next unless number_a == 5 || number_b == 5
  puts "5 was reached!"
  
  break
end