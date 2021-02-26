# - Use a while loop to print "Hello!" twice
# - Use the given code

def greeting(times_to_greet)
  while times_to_greet > 0
    puts 'Hello!'
    times_to_greet -= 1
  end
end

number_of_greetings = 2

greeting(number_of_greetings)