# - Run a loop that prints "The loop was processed!" one time
# - Only print if the boolean process_the_loop is true
# - Print "The loop wasn't processed" if false

# Input: boolean, process_the_loop
# Output: string, printed to the console

# - Randomly assign true or false to process_the_loop
# - if process_the_loop is true
#   - Print desired message to the console
# - Otherwise
#   - Print desired message to the console

process_the_loop = [true, false].sample

if process_the_loop
  loop do
    puts "The loop was processed!"
    break
  end
else
  puts "The loop wasn't processed."
end