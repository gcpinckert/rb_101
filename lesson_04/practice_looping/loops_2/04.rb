# - Modify the given code such that "That's correct!" is printed and the loop stops
# - When the user's answer is 4. 
# - Print "Wrong answer. Try again!" if the user's answer is not 4

loop do
  puts 'What does 2 + 2 equal?'
  answer = gets.chomp.to_i
  
  if answer == 4
    puts "That's correct!"
    break
  end
  
  puts "Wrong answer. Try again!"
end