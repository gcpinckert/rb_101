# ask the user for two numbers:
# ask the user for operation to perform
# perform the operation on the two numbers
# output the result

puts "Welcome to Calculator!"
puts "What's the first number?"
num1 = gets.chomp.to_i

puts "What's the second number?"
num2 = gets.chomp.to_i

puts "What operation would you like to perform?"
puts "1) add 2) subtract 3) multiply 4) divide"
operator = gets.chomp

case operator
when "1" then result = num1 + num2
when "2" then result = num1 - num2
when "3" then result = num1 * num2
when "4" then result = num1.to_f / num2.to_f
end

puts "The result is #{result}."