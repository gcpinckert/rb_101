# - Write a loop that prints numbers 1-5 and whether the number is even or odd
# - Example Output:
#   - 1 is odd!
#   - 2 is even!
#   - 3 is odd!
#   - 4 is even!
#   - 5 is odd!

# Input: integer of how many times to output (5)
# Output: String, current_number + whether it is odd or even

# - Set a counter variable equal to 1
# - If the counter is odd:
#   - Set a description variable = 'odd'
# - If the counter is even:
#   - Set a description variable = 'even'
# - Print the counter with its description to the screen
# - Repeat until the counter is eql to the integer of how many times to output

def display_odd_or_even(times_to_print)
  count = 1

  loop do
    break if count > times_to_print
    description = 'odd' if count.odd?
    description = 'even' if count.even?
    puts "#{count} is #{description}!"
    count += 1
  end
end

display_odd_or_even(5)